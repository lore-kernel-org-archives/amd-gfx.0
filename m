Return-Path: <SRS0=4PMp=2I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C562C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 01:52:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48DDA2176D
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 01:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="v0wAjyqB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48DDA2176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C100F6E0FA;
	Wed, 18 Dec 2019 01:52:43 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::621])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0F5A6E0FA
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2019 01:52:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qxz5n0TIQqzcI/mNxRxXhu5+nq9zsBA14HhsgAvIpyLLyyz6HNkBFj3gSkjPq4tuaFDKlt3Fb+CMK4MZC1efgxXJoARoEX3Eq+qnl4Wt4EB4VKH2EgvvTAFqVfB2T1F8tUChNgkKm/pJiuB5x/89w46IZ3klWYOsUrfrPica9j/Y2Vznq780e6yOcCxhBh87PyoVquNY48doR40YAbAWRiH6f+mgkeYqszpSWd4ZDv6yy2HgIa4nQUa1EnYuLcZUv95qLWSdtfymch64ATepRemO1j6Aigb7ih58INzOmbO+zxeCe/EOEIaNHvhnwjBytgmnngVRz8J0tO66gq0w8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHZaFXGhx+k7zBhU1x/z48psOj60gqpkOVVCSMKRalo=;
 b=ofaJeP6QrfOakg+3zxWhtrTf033Ea6Xx56zSTYMGCzuCxTgEoD33m6Mo4lAoPQzyq2qYv8v74e/Nzn2k39APw6QHoooRRfT4OGEpqiaP0XeogJ0Ba01XgvHRpx+DTvxGw2QtI6VGsKgwBpFm0OVLTQwWYo7guYfMA8nEho+6ZF9dmjEcDntYgNPZmW4RC7PmKPWa2epQAvSNqWfjBZ6TosicL06/iijDls3AnKyZbNMo2DCLw7DErwt0MtUvLz7PSyeJKwQ8GWGrkt6wkWi/TQZbjC92Q+92ORl7kiEOo03kzM8aflzZXB+nXXjFNlA86FfrsVL8lXR1rTWrjefQ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHZaFXGhx+k7zBhU1x/z48psOj60gqpkOVVCSMKRalo=;
 b=v0wAjyqBcIPH7REOLq6zRBqH4aB88c2XQsNKDAGuzFtIs9IbqsOIaNeSx7gYLqB5jx3hiyWnkYRa+rmGua9kaH+EdB6g3hkR5j3H2YPJTD9bdyqSIBgxBXen4vnBYB2KuFq4rzixQ0/fvQQavg7KEZe5Ck9FnjAjc7k12xDdCEQ=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3231.namprd12.prod.outlook.com (20.179.83.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Wed, 18 Dec 2019 01:52:40 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2559.012; Wed, 18 Dec 2019
 01:52:40 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 5/5] drm/amdgpu/smu: add metrics table lock for vega20
 (v2)
Thread-Topic: [PATCH v2 5/5] drm/amdgpu/smu: add metrics table lock for vega20
 (v2)
Thread-Index: AQHVtSNnuQxzTpUcM0S6JBMYVgvXCKe/IR2A
Date: Wed, 18 Dec 2019 01:52:40 +0000
Message-ID: <MN2PR12MB33441A36BEAC6CF4D6B7A71BE4530@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20191217214543.2285700-1-alexander.deucher@amd.com>
 <20191217214543.2285700-5-alexander.deucher@amd.com>
In-Reply-To: <20191217214543.2285700-5-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=45f0f4e7-7845-457a-95b0-0000cddf0beb;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-18T01:51:44Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a901435a-50d2-4e77-e003-08d7835cf710
x-ms-traffictypediagnostic: MN2PR12MB3231:|MN2PR12MB3231:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB32310E44BBC255E8EAB9751FE4530@MN2PR12MB3231.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(199004)(189003)(13464003)(66556008)(316002)(966005)(53546011)(66476007)(8936002)(71200400001)(8676002)(26005)(2906002)(64756008)(66446008)(52536014)(33656002)(6506007)(66946007)(81166006)(76116006)(81156014)(7696005)(478600001)(5660300002)(186003)(86362001)(45080400002)(9686003)(110136005)(4326008)(55016002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3231;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S/vAtHn9PlK6JtOeS12NyjkHNN7oF4eRAgKCkF1kCRHj3rjcM1P7xab1HRet+XF1wC1EQXhAytu8ipjFbhx9WTkjiVlICgyQ03mW022WGL7COasv/RM1528lQVLjExrOPRobg6YOijLNEC0wcpqHOjayr/Lx1z3wKpsAZP+mMlmgsl6Lvt7mvLYG3vEZxb/LhlPNoVryB+WHS5Tw7qijna5npoZlB/VO+XjcCd5WIzixXq2w8yRLycmumcUqSI23y7FkBcx78n2IDS5coC+3+bDRsLi5Muv4kY0rvllulN1ACRvhB2Q0sg37vOqMrfXYdncuq0ftImaIV/LAZAgHhi2tafv77J/p+DT8Kwp69D4x3tfSqMmeTMRTbPhNZBEdRuCmWkVjw4jd51B2abTZ6P3nIf/j6Kca5eroJGcs2lmib5uIXJnyH6MgalCiejrEva9rZpM93YncPn49hOr6f+3pGZ9hYBa78oAHh1WBDLOsGSiJbSMLj5pftv5NUOpu0jc5fzs4PpeRDR3c4OAlMi62EcWG1Jm0PlD30n2S0uQ=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a901435a-50d2-4e77-e003-08d7835cf710
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 01:52:40.0383 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fm0hsOxsak8Uz7V/ht99cOib8dYRHIGzfU8DGmyu2kQyD6lZSs6HC+fLWVHvZXuj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3231
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It's fine with me to check them in as a temporary workaround. 
Series is reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Wednesday, December 18, 2019 5:46 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH v2 5/5] drm/amdgpu/smu: add metrics table lock for vega20
> (v2)
> 
> To protect access to the metrics table.
> 
> v2: unlock on error
> 
> Bug:
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.fre
> edesktop.org%2Fdrm%2Famd%2Fissues%2F900&amp;data=02%7C01%7Cevan.q
> uan%40amd.com%7Cefa0dd86e5a74ead810708d7833a823e%7C3dd8961fe488
> 4e608e11a82d994e183d%7C0%7C0%7C637122159732784832&amp;sdata=X0Z
> UV1r90Dy3mvlp8zONFcxKQcSaciwkVt7GJabYH0I%3D&amp;reserved=0
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/vega20_ppt.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> index 2b1c3f8a0415..250ff5aa1305 100644
> --- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> @@ -1678,17 +1678,20 @@ static int vega20_get_metrics_table(struct
> smu_context *smu,
>  	struct smu_table_context *smu_table= &smu->smu_table;
>  	int ret = 0;
> 
> +	mutex_lock(&smu->metrics_lock);
>  	if (!smu_table->metrics_time || time_after(jiffies, smu_table-
> >metrics_time + HZ / 1000)) {
>  		ret = smu_update_table(smu, SMU_TABLE_SMU_METRICS, 0,
>  				(void *)smu_table->metrics_table, false);
>  		if (ret) {
>  			pr_info("Failed to export SMU metrics table!\n");
> +			mutex_unlock(&smu->metrics_lock);
>  			return ret;
>  		}
>  		smu_table->metrics_time = jiffies;
>  	}
> 
>  	memcpy(metrics_table, smu_table->metrics_table,
> sizeof(SmuMetrics_t));
> +	mutex_unlock(&smu->metrics_lock);
> 
>  	return ret;
>  }
> --
> 2.23.0
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.free
> desktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7Cefa0dd86e5a74ead81
> 0708d7833a823e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637
> 122159732784832&amp;sdata=xFCKqTGqv57k9SucgTc7Ur5AGctpMO%2BbPvw
> RKz53whI%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
