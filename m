Return-Path: <SRS0=8Fgq=FS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8C1C4361B
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 04:00:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2647E238E1
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 04:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2647E238E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 995F789DC2;
	Mon, 14 Dec 2020 04:00:55 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E8EE89DC2
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Dec 2020 04:00:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLx9yaYtFn6k49X9x5aF82ONPNVv+UP9DjcHxiuzstRhJTWaZH8ihj4hYTkMNPYsKOLKtLw+j7+UVRbEsNXZau5a0Eda6BvARGoR5MoLNAjsAYooafmExdgaRnGi0P8KrSIsMu+AgTjBLS8G5OUsod0Ir8mwZcwVUeC3n/QnwJ0RIWzrYlUXXvVlKIwvPcrRVeNoaRvoQiE8Cq52gNQ4IN84j422SsAXWtybgWpB+uIlIQ9A5cJW8M8ilbrIk67HZNBQkS+DzqtmEFy+0yLSVadTj9NCNic2La6Nv1g7PnS4EM9p+df8dRs2vugl8TWd+ZsVFIfQyHbxlzwqJKFE9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHjdHK0zTn6A9Gg+lE4T2me+IbfMfVDAOkGsICpFbzQ=;
 b=KZXIMCe7euDwWjl4A8nFUtQZLViOXAm4B7CzF0qe88UiWHJWqstucAOjadgffhD4vfnc58DFA8yJycQA+tKs5q30+blKWrZ7o6st00Fd9uNE3gti+tWr9NApP7Rr7aO2yv64jOHO6xt2EpocYt9fDoENEl4FZbOpNehtmMeDABF29wNe9x5E8+s6xOdNtMn/ZxJCDGv4eBuebc+A9s7HwXkFXQVs1UBVY2BK8wIg/5ayjm8j04HEeyyrT+Y9vzzs+wPbPcrbWjzxst8sgpjG1CD8dhVlus/08M79/wrd1nOABteXuv1vb6IIe73sNMU5YyuLGL+sVqGW8oH3s0H5KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHjdHK0zTn6A9Gg+lE4T2me+IbfMfVDAOkGsICpFbzQ=;
 b=3F127FqyHWf6FMhrzGqx+bvR4mj510y9od/0c7TC+skldEds5R9yTVWkEUHNC+c2YE3Cis0JPqKf5h2kslJS2+oJhqDNu7LPQVFGwKcx1ll6SXg87MedHOvZTW2oXnUNPtpwvbvMWkrqZxTXMLK1ZF88F8HPfMbvcB6Y4Amr1eU=
Received: from BL0PR12MB4913.namprd12.prod.outlook.com (2603:10b6:208:1c7::20)
 by BL0PR12MB2578.namprd12.prod.outlook.com (2603:10b6:207:49::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Mon, 14 Dec
 2020 04:00:50 +0000
Received: from BL0PR12MB4913.namprd12.prod.outlook.com
 ([fe80::4112:ac5:8125:7c05]) by BL0PR12MB4913.namprd12.prod.outlook.com
 ([fe80::4112:ac5:8125:7c05%2]) with mapi id 15.20.3632.032; Mon, 14 Dec 2020
 04:00:50 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdgpu: skip load smu and sdma microcode on sriov
 for SIENNA_CICHLID
Thread-Topic: [PATCH 1/1] drm/amdgpu: skip load smu and sdma microcode on
 sriov for SIENNA_CICHLID
Thread-Index: AQHW0cbVFeaEfOwRIUKXnRw3hPaIx6n19plA
Date: Mon, 14 Dec 2020 04:00:50 +0000
Message-ID: <BL0PR12MB49132C2855D9B16092F2205997C70@BL0PR12MB4913.namprd12.prod.outlook.com>
References: <20201214031121.17794-1-Stanley.Yang@amd.com>
In-Reply-To: <20201214031121.17794-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-14T04:00:25Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=2638c908-0369-49f8-95c6-00008663bb96;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-12-14T04:00:15Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 6bd2eff2-ec0a-4e55-92e9-000072c531de
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-12-14T04:00:47Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 0b4eb205-80f4-41f3-982a-000039e6abb0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.197.181]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fa2f5b7b-d2c2-4545-24d2-08d89fe4d862
x-ms-traffictypediagnostic: BL0PR12MB2578:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB25783849B063DAB67E566ADD97C70@BL0PR12MB2578.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ni4KSD3DEABEedKM7FpNG4gr1+Afeoztb73xqMvjMu1SMhk/3O9AaKquJeP2v69AxoWw9d9ucOrvVAp7fIemeMJBHlVOHvZAKhnhvzRxgkEoWV+TSv+xP2xLXny7EH6H9jjAU1pJDWMlPCjZM4Epv477iKQaDhnrG55n/WwqoctJEF05sHfMr94Vous8Kv9LiJSX1BmCtBbtsP66u5qmWR/iCor7/Wr65zoKoQHsw9xSD5Q10AfsuafLk+v/ZIoB2ohvPGsS+26KX1yTf4bB22sdz9OtSYeGINhOVbEOcyn4YqRl8QwFWOa1o89G5xB/KtqYmP0TPvHi0dovEZ8ucQJkhexYQ3A7Cvs+3iAJ12dFqE8rqDmMuwRlz/qldgUNVtSuk8gM7JQYLObERzm1aA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4913.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(136003)(33656002)(76116006)(508600001)(71200400001)(64756008)(55236004)(66946007)(2906002)(66476007)(45080400002)(66446008)(66556008)(52536014)(8676002)(4326008)(26005)(8936002)(54906003)(110136005)(186003)(83380400001)(86362001)(5660300002)(7696005)(6506007)(9686003)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?aZ2YwGi2pCuRl29ncY8p8NPlxR3EgZCur/Z9KCJG8/lNfHfRg760Po2vi0yh?=
 =?us-ascii?Q?f3W2vu64cmwYWtupIG5V+vCJOFhCqyL0AjgQ+86a+g8A8PJLwYd469PTFOqQ?=
 =?us-ascii?Q?atMAZKCL6ALkMSbPwtnHq30B8i4JyyACihN4oeJ+ERc+QPaWltva4CHWBlMb?=
 =?us-ascii?Q?w9P/KcDnzVckc926FXHdGOqAge/D1wRJmUV1kefFsdyl+MtCB8IF8p67Wdib?=
 =?us-ascii?Q?du6dLhceenxGP4WJaI44YsgGNZp1XFf8kIMH7mm5iBnGurgQKKpmucwmACq4?=
 =?us-ascii?Q?Eh7i1r0stNtjw9uCOSOfF6T5eV4tKaZ8iqHcb3rT4LMdIGHD5v8arNrf8Wwh?=
 =?us-ascii?Q?MqvrylLGaWZ048Rev/dLF9ZMrw52wPIu+c2PeuZbnAvK/4wos5CKOzyAk2nz?=
 =?us-ascii?Q?Lgt967KHinXdU+6daKu84r0RGCb2SLdHac+MZVJRSzPEBAqUcSuG6/8Pb7Cj?=
 =?us-ascii?Q?feS7U2d9aIXe7mvzn+JEsE4ThCn6B5BMOitBBpAEq4RmxjcD3z3swtk9aRvW?=
 =?us-ascii?Q?v6wlvWcHceYfPv1CJJk6C6CnC59OSuJRqiMfDTRnIupR7rvNe4LNsNxBJT8p?=
 =?us-ascii?Q?q7EnikteKSh0nhIWluWLA+a5mD6NpC/mVA7sHvaDQl1D0i5Plv5nmcr3Rero?=
 =?us-ascii?Q?P+M1RcB6LRjthqufoYm1LRL2DZgu9bAUrnZFrJ86vxq6rZFNOxd0cd/EBeUH?=
 =?us-ascii?Q?UaH6s2dKVjxEwbf7uv2zo9W5ZQLyU6c3wViqhviUT6GT+XkNTEokKXawfstY?=
 =?us-ascii?Q?0kTsi0F9bHl9hzpIi4uToYSZnGmvgP8gzLIj0RB2RcQArdvrAnwlm20aXsLW?=
 =?us-ascii?Q?kO6iev27yXjT4ekeiyIIumqru/HbcR40FOCtTQJcroizeWhQ0+OWYouIkUHw?=
 =?us-ascii?Q?gKdDU9pN9Ble1iYz12t007hqooHScDlcsYNQrBhjI0KYUj4pOgvuKu/oShZN?=
 =?us-ascii?Q?D7IQr4fWJF2yLCu6RsbkawiEVfk1/G2hLDHpi64VgMQ=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4913.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2f5b7b-d2c2-4545-24d2-08d89fe4d862
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2020 04:00:50.3390 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KX9VsZ3ClqlkhuHsC72AJ5PZNVavVO40339PLn9APtNGWHqidZONF89HiHg3d8KL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2578
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>, "Jian, Jane" <Jane.Jian@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>Stanley.Yang
>Sent: Monday, December 14, 2020 8:41 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Yang, Stanley <Stanley.Yang@amd.com>; Jian, Jane
><Jane.Jian@amd.com>
>Subject: [PATCH 1/1] drm/amdgpu: skip load smu and sdma microcode on
>sriov for SIENNA_CICHLID
>
>[CAUTION: External Email]
>
>skip load smu and sdma fw on sriov due to smc, sos, ta and asd fw have been
>skipped for SIENNA_CICHLID.
>
>Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c    | 3 +++
> drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 4 +++-
> 2 files changed, 6 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>index 39e17aae655f..87566dee048d 100644
>--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>@@ -153,6 +153,9 @@ static int sdma_v5_2_init_microcode(struct
>amdgpu_device *adev)
>        struct amdgpu_firmware_info *info = NULL;
>        const struct common_firmware_header *header = NULL;
>
>+       if (amdgpu_sriov_vf(adev) && (adev->asic_type ==
>CHIP_SIENNA_CICHLID))
>+               return 0;
>+
>        DRM_DEBUG("\n");
>
>        switch (adev->asic_type) {
>diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>index cf999b7a2164..31f05d96586c 100644
>--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>@@ -847,7 +847,9 @@ static int smu_sw_init(void *handle)
>        smu->smu_dpm.dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
>        smu->smu_dpm.requested_dpm_level =
>AMD_DPM_FORCED_LEVEL_AUTO;
>
>-       if (!amdgpu_sriov_vf(adev) || (adev->asic_type != CHIP_NAVI12)) {
>+       if (!amdgpu_sriov_vf(adev) ||
>+                       ((adev->asic_type != CHIP_NAVI12) &&
>+                       (adev->asic_type != CHIP_SIENNA_CICHLID))) {
>                ret = smu_init_microcode(smu);
>                if (ret) {
>                        dev_err(adev->dev, "Failed to load smu firmware!\n");
>--

It's not good to keep adding ASIC checks in the generic interface code. Move this check to smuv11. 

Thanks,
Lijo

>2.17.1
>
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.f
>reedesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C0a496c71fa1d4bc6a872
>08d89fddf683%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637435
>122965129344%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQ
>IjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=i1y6snfi
>3bnQVHOuVGfMqjSG%2FsBLYtxLkrnT9PV4%2FbU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
