Return-Path: <SRS0=QzDn=C2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD467C43461
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 09:44:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75F392076D
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 09:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iZHuJQ0h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F392076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 024256EB8F;
	Thu, 17 Sep 2020 09:44:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBE016EB91
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2020 09:44:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgUHW4kfmrz+OHRlpIsF2iTynQq1Hybt/xH97TrNsqTj5bdzL3xszr5Fgtpno2adKo6MFbQjYkXxd1u+8DW4Y/eMlftFuwQQdidOwaQY3/NlhL3+baIFbhwumaCnYwM3vhZCEo9mzb7Nnh8VyuOPqAhy/woIqpERHNfrh960Xo7MN7otXxr8yTkVbdL/y3HRnS04Yu7s35r/XLvpS7dX6EfHWR/tL0B/0qyTRv/U2HwaEvDwhQ1OndNprP0mmyZswfOVmMy2lFUBkj8LgvhvhEYWazE0USK98ETc2tIFJq72/RcLjVNXtGAlQepf3fPQXR5ruxvdeapY7nxusQ+Pkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6IqIEhp2aFn9EM7Peu4n2uwOG+QvJHqtyTi5eziAbo=;
 b=oX3RYf6YZa0L9XyW0Vx5o+CZz1Pb/zCFhTQn702F3TR4A2NbJFQ64Z1Ug45oqZ+Gi6pc7E2gN0lKrDJx1CLt2JLTlkMpYfs7v6ITBnNwHEnujOgLTXNasmz8PlsGrllCGlN2TSA2twv3Dd/eteNgTYZsgHE+IXkYOVfA66Ck9QMTrWQY2KtOEEf4GSD4MB0g39AQzuYg5ycCUZb7DoHs7o0byycNpRasIQveMSxH3P9GRQJyEKDXp4G6zsdVc4kpk3FL1kJKIbxNGKHpwvdHapyG9fO5t/KoIduPRD0DdACjRtF0GcKcEtx46L+5Xyuam9z04UMLjiTpXqmxEOQW+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6IqIEhp2aFn9EM7Peu4n2uwOG+QvJHqtyTi5eziAbo=;
 b=iZHuJQ0hUm/zWKheZRLB2r/sa7p7s7rT1tva6W4xsbCHm554Mn6nBdIVEs6NBZhRs8lfmfXrbWjIhxj3aZneMITtTFmU+fgfY4LCQPU4B5qvJ9GXKUfBGQ3F+6Jpxi5EHlFbrsJijuDtFEQDbSmbExXgbkHQ4eaQKO2TnU5IYkk=
Received: from BY5PR12MB3841.namprd12.prod.outlook.com (2603:10b6:a03:194::27)
 by BYAPR12MB3224.namprd12.prod.outlook.com (2603:10b6:a03:137::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Thu, 17 Sep
 2020 09:44:11 +0000
Received: from BY5PR12MB3841.namprd12.prod.outlook.com
 ([fe80::b46d:4fb5:514c:11c4]) by BY5PR12MB3841.namprd12.prod.outlook.com
 ([fe80::b46d:4fb5:514c:11c4%3]) with mapi id 15.20.3391.014; Thu, 17 Sep 2020
 09:44:11 +0000
From: "Chen, JingWen" <JingWen.Chen2@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Skip smu_post_init in SRIOV
Thread-Topic: [PATCH] drm/amd/pm: Skip smu_post_init in SRIOV
Thread-Index: AQHWjNNXaKhbaT89P0i98stesfpD06lsk0AAgAABLxA=
Date: Thu, 17 Sep 2020 09:44:11 +0000
Message-ID: <BY5PR12MB3841DF9EE104FDBFC3FED130B73E0@BY5PR12MB3841.namprd12.prod.outlook.com>
References: <20200917091654.1045366-1-Jingwen.Chen2@amd.com>
 <CY4PR12MB12873A51234ACFE8AA324571F13E0@CY4PR12MB1287.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB12873A51234ACFE8AA324571F13E0@CY4PR12MB1287.namprd12.prod.outlook.com>
Accept-Language: en-150, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-17T09:38:24Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=c4fd9a34-5504-4a7e-9b20-0000ae41e400;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-17T09:44:08Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: bcefad77-27cf-42ab-8cbc-000052f67fa2
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 83396f95-371b-4c8f-0c16-08d85aee3b65
x-ms-traffictypediagnostic: BYAPR12MB3224:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3224135881CD7E920D8D9A6FB73E0@BYAPR12MB3224.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ua9rmwT+RLL3Bk+S1XIvrVqlX9l4AskgaznXyam4qwZbO4WbJuyrNwG/STQp72z+w+eWrNNRTkhNu1OKfr76CIS0Ax5pd9vSlr4MTd+TdPsTOqF20nKkliThxeZWW6lQBycwBHiDYdQ12IP7W/UbfFNfpqjgYxaP7yL9FpQ4NAqsbFv95mFRlJUO1xhPDAYKYwIEJ4FCaa92gXetITvZDSTTNt2amjWjboX2/nz0Mqm0b3Xvm1aJxGu9uq/qI0i/EzNQaX4pBbzkBTp6pEubbS1ofPy+eLEtiVB5NtFT+uTQ21h9iFz2TX7z/ONQyusJzQWp7Mragm9BguyT4r+O/DlKa/Px3g0OFLc8LYTtA20DS2FMatQ3ABPsueQONjRvhLnl0KaTclEXv4aKxkHSLxgvoToEWqhwhWf5swxwMuXphRhtBMcowX2Th7FpkNjK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3841.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(83080400001)(83380400001)(9686003)(33656002)(8676002)(8936002)(86362001)(55016002)(6506007)(66946007)(66446008)(478600001)(64756008)(966005)(2906002)(110136005)(66556008)(76116006)(66476007)(45080400002)(52536014)(7696005)(53546011)(5660300002)(186003)(26005)(316002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: TD6B8ByGappiWbuuQHUNL9Yl8TuiWmWsW+JygK3Ip2O5gAPKu5QuZ9Rsu8sAEuNTIxhlyVb7LI77No3pLAQeF+dvuy09+q7w+ReodBHFvTgwpKFboPboACY7L6UblgDQJYsaYSGfw++dJx9mGAv+CTn0+HNp680SKkYwl+rKiqrXfUIi++eZ3gE9hyMY81WUwo0Sds7sjHoK3Gpqa/NmaLMdmyr93eVAfebyJaLIrPxzOOCecIdtyDuy4ymbm01Iv3Ix8aaKF5+2eYuxCnZ67ozAMbLz93bgVK0oqZaeLnf2lTlNbOtfKp70FQ/pVSIMauqcUmNiAmPOkInmtPY/YS3tEQ+a2OgsvscXAq2x6L4tCtJzBGMAb/BtZ3blrPfsVlmtf6BLVStN9GcQKvtqz2z6VbFIMY7209NgexkZ8n/D0yD0ha5GG4P6/nS71GBZBAy4jMM59bTF9Y4I+nJEEEeotdCPqVUxR2idkIjnC9yLgrL9NgCeBcMamPeKNcWJ4Zni2iTLE7S62omcFNDNt1fQKSswTB2KgrU9EFo4aE3eQluaICgr2EuGrZTsbBKuX45z9fksiRMrleqjNemP+DgW/IUG2bJKEaGB2xYXnjt4gZn6uM2Dk8m/a1Pn/e5HJH86dd7Dr01w/4wsymTGOA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3841.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83396f95-371b-4c8f-0c16-08d85aee3b65
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2020 09:44:11.5960 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mjCm434oKVTkb1MQzqrVawoBxOQODddU4JuZwbeHojOXpeOElrmd0l2b2alyGS939n8CZZIJZlZu/tIjT7olhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3224
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

Typo fixed in v3

Best Regards,
JingWen Chen

> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Thursday, September 17, 2020 5:40 PM
> To: Chen, JingWen <JingWen.Chen2@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Chen, JingWen <JingWen.Chen2@amd.com>
> Subject: RE: [PATCH] drm/amd/pm: Skip smu_post_init in SRIOV
> 
> [AMD Public Use]
> 
> You want to call it in SRIOV case or in bare-metal case?
> 
> Regards,
> Guchun
> 
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Jingwen Chen
> Sent: Thursday, September 17, 2020 5:17 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chen, JingWen <JingWen.Chen2@amd.com>
> Subject: [PATCH] drm/amd/pm: Skip smu_post_init in SRIOV
> 
> smu_post_init needs to enable SMU feature, while this require virtualization
> off. Skip it since this feature is not used in SRIOV.
> 
> v2: move the check to the early stage of smu_post_init.
> 
> Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index a027c7fdad56..a950f009c794 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2631,6 +2631,9 @@ static int navi10_post_smu_init(struct smu_context
> *smu)
>  	uint64_t feature_mask = 0;
>  	int ret = 0;
> 
> +	if (!amdgpu_sriov_vf(adev))
> +		return 0;
> +
>  	/* For Naiv1x, enable these features only after DAL initialization */
>  	if (adev->pm.pp_feature & PP_SOCCLK_DPM_MASK)
>  		feature_mask |=
> FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT);
> --
> 2.25.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.
> freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=02%7C01%7Cguchun.chen%40amd.com%7C12ec63de0caa413
> 4415008d85aea7b6a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C
> 637359310721844702&amp;sdata=9JCzyhqPIKMZV%2BBEL83HZyfwCyZjTP5iP
> gs7Hn4Epx8%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
