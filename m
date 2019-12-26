Return-Path: <SRS0=shUv=2Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBC7C2D0DA
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Dec 2019 07:33:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C50DC2071E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Dec 2019 07:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TUhfD95U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C50DC2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 928F189A9B;
	Thu, 26 Dec 2019 07:33:49 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760048.outbound.protection.outlook.com [40.107.76.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1609989A9B
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Dec 2019 07:33:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e72HWiL49petKXmM8j7dApFxR44i7Vhfijf8ZouU6JPC6O/VmzznTzKpDTU1pH8Ix5q3Bgwvf+CC6oDouGJaTmqIWuqJBuh47/ZHpG+xpv9dWeHHpwP7JYE9PQ4Ms9A+8JjBkHmQhSRr38RnkYwiUQsJFPjlpXxotkDbFUGPyX/Cpx96iJ6Uc3hI6yAKsRvwy/GpVMl8JWGVyj+2rwDORao4iJkSm/6Hi5ASafjUTnvYDiR37a1eag6VK4FuqEIziBQwVTxabOMXgXjGgK1Uq89dMFkrUO3E6rkjlxrPJeXHeyA3zxSF42rW6LDNeCRrlRYz8u6nT5wLasuVhYBc7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4a6Y1vkz8/rk28iXkOUVAj75yUiic5kMyxUMEU6k/A=;
 b=iUdz6BRpcWgSuf0hm6JUOATfRm1RqReny9+AEABogllr6Mkk/XQFGITAn2+Vd4fXmCYAGdYqOjrNkDgL7GQAp5aiuojS27OoHHBnnjML9WiPnR/2+43PQ3e8p8MdlOaVAAgF7FRQekB+jSkNrJDrN27N8nxgcx5+2iUKvSqL46VTL7crDls1YULSTrGN8Y6iTV4TGl3hVbOytY2nisWbT3n03U4AyIqXAgtwt9Bp+E4bkoo3fsZ/Q2867mHQ2pTyibNhyLNSs5bytT6rUsdnX3BmWXntWs9vT7KC0/JhjAvY8NpKFDnitGGGb2HuRnS7NfAAiprxHa/g3jJDfDl3Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4a6Y1vkz8/rk28iXkOUVAj75yUiic5kMyxUMEU6k/A=;
 b=TUhfD95ULra/wdXmiMJ2WcVv+knN8AftSa/7kCVV1O6TEBD+jumais7WEMroQ8vFXZ9F3nOOyzmy6MZn3GloZd16fcT0SpI04XxbdhmB13cI1B4nLkRAr0gmLiuCY2gxLs/2YCJa99I6thbGv2EJ1YNx9m4l0vjSwGQhwTufimw=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB2926.namprd12.prod.outlook.com (20.179.84.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Thu, 26 Dec 2019 07:33:45 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2581.007; Thu, 26 Dec 2019
 07:33:45 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/powerplay: fix NULL pointer issue when SMU
 disabled
Thread-Topic: [PATCH] drm/amdgpu/powerplay: fix NULL pointer issue when SMU
 disabled
Thread-Index: AQHVu6pSn+bjk9Exn0aZ6A54wx+Uo6fMBieg
Date: Thu, 26 Dec 2019 07:33:45 +0000
Message-ID: <MN2PR12MB3344372F107D238861B30936E42B0@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <1577336793-18367-1-git-send-email-likun.gao@amd.com>
In-Reply-To: <1577336793-18367-1-git-send-email-likun.gao@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=4341072a-777a-4c99-98df-0000282baa0c;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-26T07:33:19Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 14ac1afc-e4b5-497e-057f-08d789d5f0c0
x-ms-traffictypediagnostic: MN2PR12MB2926:|MN2PR12MB2926:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB29264CB5846322ED27BDD879E42B0@MN2PR12MB2926.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 02638D901B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(189003)(199004)(13464003)(86362001)(5660300002)(71200400001)(316002)(54906003)(52536014)(76116006)(110136005)(33656002)(66556008)(66446008)(6506007)(53546011)(186003)(64756008)(478600001)(8676002)(2906002)(9686003)(81166006)(81156014)(66946007)(55016002)(4326008)(26005)(66476007)(7696005)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2926;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xkHlbX7mV1TzUVMGsDWuIYUhLRUW6RrnIdcXe1L0cpw4vnszESalB8pizcL15xdwPihtNPLqjNng756rlKO1xRwTNKJgJ0a2qaZBTk0RNWYBZR5CAYDDEwiWfBookW/iWfcbOYyUjLz3CxVEidzeZPUj9U6fGizaKznXhdcZSPX1YXmvc3g0GPmVbgShFChaSTezkNZM1lQ5Jcx/eC+4vIRyd+BerX9vuUana3+X1OwfFvaWnKtADDTKh8u/81Ytjj5aVhKwcebCZpZFLwQuYQm5NXyCwXiDtUWT7lcVS7eJmouCJ7vIr0/cOGH/0oOYdNIQwFl+zU+mu523CistZTCSO6pauAKcBuKQKD1a0oqLDGxR4cB/Tw3GnxiWohqGiQ+b+HyF/dZhB+wVwkNugU7TUBIMV95L2FYDwXII7beg0Bb6zU/sJuE9oZfPjHAaUbnvgJ2Dw7ep9hg8QHe66YifeBEf+lbIo9O5rxvgA96UT8yFy0KTpJP6h+dcY9SN
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ac1afc-e4b5-497e-057f-08d789d5f0c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2019 07:33:45.4121 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aYPy0tX9OFAZZNJ/XnQXdDBOhoFVip3BYCTJNgvHiDCOKubrBXLpxO2RxNLc3dnK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2926
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: Gao, Likun <Likun.Gao@amd.com>
> Sent: Thursday, December 26, 2019 1:07 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Quan, Evan <Evan.Quan@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>;
> Feng, Kenneth <Kenneth.Feng@amd.com>; Gao, Likun <Likun.Gao@amd.com>
> Subject: [PATCH] drm/amdgpu/powerplay: fix NULL pointer issue when SMU
> disabled
> 
> From: Likun Gao <Likun.Gao@amd.com>
> 
> Fix smu related NULL pointer issue which occurs when SMU is disabled.
> 
> Signed-off-by: Likun Gao <Likun.Gao@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index d07c4f2..3724085 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -1905,8 +1905,14 @@ int smu_write_watermarks_table(struct
> smu_context *smu)  int smu_set_watermarks_for_clock_ranges(struct
> smu_context *smu,
>  		struct dm_pp_wm_sets_with_clock_ranges_soc15
> *clock_ranges)  {
> -	struct smu_table *watermarks = &smu-
> >smu_table.tables[SMU_TABLE_WATERMARKS];
> -	void *table = watermarks->cpu_addr;
> +	struct smu_table *watermarks;
> +	void *table;
> +
> +	if (!smu->smu_table.tables)
> +		return 0;
> +
> +	watermarks = &smu->smu_table.tables[SMU_TABLE_WATERMARKS];
> +	table = watermarks->cpu_addr;
> 
>  	mutex_lock(&smu->mutex);
> 
> @@ -2398,7 +2404,7 @@ bool smu_baco_is_support(struct smu_context *smu)
> 
>  	mutex_lock(&smu->mutex);
> 
> -	if (smu->ppt_funcs->baco_is_support)
> +	if (smu->ppt_funcs && smu->ppt_funcs->baco_is_support)
>  		ret = smu->ppt_funcs->baco_is_support(smu);
> 
>  	mutex_unlock(&smu->mutex);
> --
> 2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
