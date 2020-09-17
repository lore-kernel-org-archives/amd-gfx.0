Return-Path: <SRS0=QzDn=C2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44AEC43461
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 09:17:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 603C22076D
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 09:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Yq61hZDg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 603C22076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E66066E0B6;
	Thu, 17 Sep 2020 09:17:52 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680059.outbound.protection.outlook.com [40.107.68.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D8C76E0B6
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2020 09:17:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2FCErAx5muRXqpqZlsE1ITIs6jd5cG5FQR3oPhRq/XeQNiULvrnw4jTHVxRj7jl2f4MygfzcoxEstqw1t611akjWQOo/33uYEmVW4iAP3mRwXurXo2I8yaBpBTH8F99jNQiz/x6nQrHrMxgH03xpIgX62G0hi1JhvEfW9VzuPTdmCNtQyFlI+Gf52L5r4mTK43OaxWC+ArYyG8gIqyPCGM2HRg0gQ2dbbS1uMNYfKQyX0LByC3K5c+5mXpEGRePBO1bkCUN/TP/RtDBIUB/Op+EaMLwfe40e+mtEa4U4jpTgPY1+VxZgPM4eNcZHUtf5FKd1ze1RbreSxiyK/mWlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B70zGScsEE9lqEkBXX/v/WZVsK91ku/9OlIcc7WfjAk=;
 b=KdqQV7QAb7SP64zjKWGY10cvIB3nD/qoHqzgHRn/rosKi9ncp8Z5GNR2iTpRgFaB+tDkcAdpJ28eXG1UbQj/M4Jhv78CYGrLmNaweIruHA+EcT9uVu9DoCf+CdYEgek/0Lp71fesDy57yBHAyW9as3jBXBpyT9KmWc7/pBtu9L3CFOsChOMZU13n3SQ63XpVY0kJhP44IOi4WzBgj0xGEA6p6k8t2TWeOVHVdbbjGu5hNcSJMcFHPOV1lzTTCyVS0Z0yNED9RK3/JXe8Oer8f4S4+Hj5+LtTzO7C7L4TqHfQjBQV+04AxjFQjbsAHv05kPbkd0ZouQUzRbIuWOEgDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B70zGScsEE9lqEkBXX/v/WZVsK91ku/9OlIcc7WfjAk=;
 b=Yq61hZDgILmmdpBPDGRgKieq7MbBTv3ydBW42xbHTvDu9+jjWO4caKE/zvC35dvm+3WobHGYwXEqZ7tbx2YsagIxoIgqLr7CVHBdla046nj12dzoMuc+EViIRveRE7/PY2/Ld7QG7z5qP3BPL9zy+DUPDHGQML1E3MkUgIREhhU=
Received: from BY5PR12MB3841.namprd12.prod.outlook.com (2603:10b6:a03:194::27)
 by BY5PR12MB3987.namprd12.prod.outlook.com (2603:10b6:a03:1a8::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Thu, 17 Sep
 2020 09:17:49 +0000
Received: from BY5PR12MB3841.namprd12.prod.outlook.com
 ([fe80::b46d:4fb5:514c:11c4]) by BY5PR12MB3841.namprd12.prod.outlook.com
 ([fe80::b46d:4fb5:514c:11c4%3]) with mapi id 15.20.3391.014; Thu, 17 Sep 2020
 09:17:49 +0000
From: "Chen, JingWen" <JingWen.Chen2@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Skip smu_post_init in SRIOV
Thread-Topic: [PATCH] drm/amd/pm: Skip smu_post_init in SRIOV
Thread-Index: AQHWjMoIseHmG3KvbkSXeyBFckU8ealsfXsAgAAPqYA=
Date: Thu, 17 Sep 2020 09:17:48 +0000
Message-ID: <BY5PR12MB38412336AC05F4E582A1E795B73E0@BY5PR12MB3841.namprd12.prod.outlook.com>
References: <20200917081035.1024221-1-Jingwen.Chen2@amd.com>
 <CY4PR12MB12875D75473E9D52A07A745CF13E0@CY4PR12MB1287.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB12875D75473E9D52A07A745CF13E0@CY4PR12MB1287.namprd12.prod.outlook.com>
Accept-Language: en-150, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-17T08:20:13Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=2448d157-4791-45b2-8db7-00003495e8b7;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-17T09:17:44Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: f369152e-f613-4f3d-84c5-0000278ab56c
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ef5da9aa-b4d8-4830-6ebe-08d85aea8c15
x-ms-traffictypediagnostic: BY5PR12MB3987:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB3987DBBF407DAF38D25E5D3FB73E0@BY5PR12MB3987.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M8VyyvJXTR2g0UHQcFyHVDUYgq24ATS1XexrlGnmEgy0eb643TmI5bhuPcjJOUKze2oHI2EEu/tXGGJK9u/1DQJ6R3kbjT6WAfyprL0NrxuVORyJDI/0yuhKmjeff2tRyVztiqeXvAk1NoxnbZ7nAi+4fw9KOVerJAd1vSqFsV46NCzvmQ/mcks/pRLHlfC0m5/BZ+cTfY+ieB56nJSD9MPwuC8tc1OeXxhZXCVqLabQr4b7D7aKw0Ev0d9serdiL2/KXx/GllR6GG44PVCJnJQSZxy4JKCp6XpD6+brebIIdXTONFOQZ87E2B1y5/jyQ8aBe7x7qvhrUSJ/+02+X5jrp3MC7XwJulehKZ81z3S4XFWDyMfvM4gutSxZ2RuP1lre0nITn/j28ExK2ji7mg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3841.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(55016002)(316002)(76116006)(8676002)(5660300002)(64756008)(33656002)(966005)(110136005)(45080400002)(66446008)(478600001)(66476007)(9686003)(52536014)(66556008)(66946007)(6506007)(86362001)(7696005)(83380400001)(83080400001)(71200400001)(53546011)(26005)(2906002)(186003)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: ZQUhwBTpJ6XPg5mqOte95lT36MPz7DDYSGq2UjQ7amK68d71Ex3ReVtnS8bj9nE+Ma177uqvaldbidPQyQgMpbZDfX0CHosx1ZsElva6E8Vqyv8c/TkvM0a6NBhoN2D9zZb5332Gh//HihBAVeHbn5/6RUmcft3sj5hbeXC/VVc0Fk37ij4rP4j4mZjOk2CilDsVGF1UzEkBAQUJdLPnnXB1tzjY6PKqt4MtJltT0fI4EkUySciJPePbcb4ki930zlrWsVwLGKEzGYhXncrJij7ExGNCkFds4oOuTT48M7Tx9txQPf7UQjXlgwYyFd/PR6xyat041esntPNcgVdKGbHNdDaL2PQq7TyWHD9bcEEti3eqRFmXmXXjBff4l98aSZ92Gj1mtpIzWUi8vxk/yA29J7jBMMEk8Roa0HC4PtTKL6YwW0/xmFo7trD2eT+rRa+flZgAomlLhIQh4+ALh1E40MK/0yy26eE276TE3h2Qt1WrRkexZqeffZLe2Ht5QoAwKC0yUyh0wGOnyHb838CLkb7wyFaRgRSdKPH4cSTovIYKLxa6p8X2LIHDn/BXTXR0kFnpabcV7DeAdRrpsaE17lwn/OcUJgdMOsevu0Ay3xveTrtKT7yq2FwzPWuExGFLfR1Gdf2dfjCd+3u9kA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3841.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef5da9aa-b4d8-4830-6ebe-08d85aea8c15
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2020 09:17:49.0537 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aVXOnEk7e1gNIWHLKCqPzVIZ5i8xtPvjQUFarZfEgQF1NAIG4utBLNzO0MBxz5CHMG2a7VcbQcc1rH5gMAJqrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3987
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Done in v2

Best Regards,
JingWen Chen

> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Thursday, September 17, 2020 4:21 PM
> To: Chen, JingWen <JingWen.Chen2@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Chen, JingWen <JingWen.Chen2@amd.com>
> Subject: RE: [PATCH] drm/amd/pm: Skip smu_post_init in SRIOV
> 
> [AMD Public Use]
> 
> Why not moving the check in smu_post_init, and return 0 at the first early
> stage if it's SRIOV case?
> 
> Regards,
> Guchun
> 
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Jingwen Chen
> Sent: Thursday, September 17, 2020 4:11 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chen, JingWen <JingWen.Chen2@amd.com>
> Subject: [PATCH] drm/amd/pm: Skip smu_post_init in SRIOV
> 
> smu_post_init needs to enable SMU feature, while this require virtualization
> off. Skip it since this feature is not used in SRIOV.
> 
> Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 5c4b74f964fc..79163d0ff762 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -469,10 +469,12 @@ static int smu_late_init(void *handle)
>  	if (!smu->pm_enabled)
>  		return 0;
> 
> -	ret = smu_post_init(smu);
> -	if (ret) {
> -		dev_err(adev->dev, "Failed to post smu init!\n");
> -		return ret;
> +	if (!amdgpu_sriov_vf(adev)) {
> +		ret = smu_post_init(smu);
> +		if (ret) {
> +			dev_err(adev->dev, "Failed to post smu init!\n");
> +			return ret;
> +		}
>  	}
> 
>  	ret = smu_set_default_od_settings(smu);
> --
> 2.25.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.
> freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=02%7C01%7Cguchun.chen%40amd.com%7C7bc132d80cd34c4
> e7b8f08d85ae1fcc5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C
> 637359274256715319&amp;sdata=x%2Bc0jbDbTv8PR7qj4GCbYgxorKyFg2K%2
> BJYgcrs4iftE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
