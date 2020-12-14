Return-Path: <SRS0=8Fgq=FS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3315C4361B
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 06:41:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E99E22583
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 06:41:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E99E22583
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFE466E046;
	Mon, 14 Dec 2020 06:41:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDD776E044
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Dec 2020 06:41:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvmw9nOUQnXVHyvm3rcAukGzUG9V/5elYrjzSOl7OSizJJd4leN1vctLhcm93/Dp7A3/7H95MP2kdgVDO9fUVrv160B8qsM5Te8EG/uz9H5CphpQMaYpuNHULCPc38CcbhqDmnynKHWvuBPzf5VvSnVfMirplxcuXLRO+zGNm3a0GU2sK+l9u74KGTWWImSZ4PUINg6w2bR8P8nq5N9rtXSiAj5dxe1txV9En3AeYWgqePmz/M4aj6NHzEUHNVcfZP75yNujkkcEIQZt1BLeEPboMvxZMzI0p8ZblFun3hIP/dEgS5Jx+LIY317+GRSyHR/mpS84iFiFz0DGf0P/Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIMFN5fu8e8QYfX5xFoOf4InEvyAjiE5ea3Fote1Tb8=;
 b=iBFJYs9aJ08UOG5R4YrDcFkQy+okBv2Umi2jCV7RgUE6GCuyA9AjWqyanS8pcmLuWL56+89/bHB7sAeefYAdJmeBYwnNCq4T7YqfIWipieS5khYuvmGfijtww1IrvLrtjtFqKDRvPn+zE7wZ2FsR5wjNUdAigxaCY5ZLnjwBMS9/iLvH5lWIU8CR6u0CWw4mfRbCksWE9TG7pM2OBa4si590BbV7T1N3lT5ZuP7O0tf18PBWKYUEh3x8vOkmZaKnNimY68p62dC/+tW2eaxxlbnrldIq6bIdJrTlmA95VNKOy4/CqLgJX7gLrujxfy213Q6oZeolK0UIDSU22LdegQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIMFN5fu8e8QYfX5xFoOf4InEvyAjiE5ea3Fote1Tb8=;
 b=Ma7wET3ei7/zmC87VmkaFJHfEdxZJElbqMJPDs2VIQAVLSQNhGFBnNRp6xeV0jh7LIHQYxg6W8MGq0W+kajDFU2PLUdM2VII3qXU2ZM10PNQK0S6GRBSn3hEm9DRRx9cXmi79oO3ZLytIkkrkB3MGJwzWG7RZ2ruETsj7Ly2BDE=
Received: from MW2PR12MB2460.namprd12.prod.outlook.com (52.132.180.139) by
 MWHPR1201MB2542.namprd12.prod.outlook.com (10.172.100.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12; Mon, 14 Dec 2020 06:41:06 +0000
Received: from MW2PR12MB2460.namprd12.prod.outlook.com
 ([fe80::d500:b0ae:3691:8bf0]) by MW2PR12MB2460.namprd12.prod.outlook.com
 ([fe80::d500:b0ae:3691:8bf0%3]) with mapi id 15.20.3654.021; Mon, 14 Dec 2020
 06:41:06 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdgpu: skip load smu and sdma microcode on sriov
 for SIENNA_CICHLID
Thread-Topic: [PATCH 1/1] drm/amdgpu: skip load smu and sdma microcode on
 sriov for SIENNA_CICHLID
Thread-Index: AQHW0cbQnOCBm1NGAEKG9Yum7OTZ3Kn1990AgAAsUOA=
Date: Mon, 14 Dec 2020 06:41:05 +0000
Message-ID: <MW2PR12MB24603D6D37470FE8FCB06E779AC70@MW2PR12MB2460.namprd12.prod.outlook.com>
References: <20201214031121.17794-1-Stanley.Yang@amd.com>
 <BL0PR12MB49132C2855D9B16092F2205997C70@BL0PR12MB4913.namprd12.prod.outlook.com>
In-Reply-To: <BL0PR12MB49132C2855D9B16092F2205997C70@BL0PR12MB4913.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
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
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-12-14T06:41:02Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: dae74a1e-2b83-451d-aee7-00008f931efb
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bf720148-a019-45cb-c0d3-08d89ffb3bda
x-ms-traffictypediagnostic: MWHPR1201MB2542:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1201MB2542F9502EB12AF9A17760AA9AC70@MWHPR1201MB2542.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P6zdxDLKvXqD6+S8TWwmma0mT3AYD9rlIdtoIvmNqI3a52deM58H9KNWpjUoJjV0X4cObpxCkPrTafuQnO/78F0Cfx1XVAwqI+RnjAHPlCzUrmbb35ZU6DESnuXxqY9277e82BlHF2KYJiwQ9g7zLnnUghapAX6l0EP7h1eV3rg8BF7CBHlR5FjEbl9LeCc2NP5JnUoTQIpywMhvOMiNcrXYeMpGoG9JwrxEOgpNEAPStwjn7GvyTKJBmphnKa0w5Tu/5vRibsGmDLHQ3nuE/Z3XqdVrntfVYuhkdYFcvA7PrQNs2FBwwF5YTfHg8NpwX0qYSdx9edGrFA5zDKC4xlUH/MCivzf4KVTgitH3R/RPA6YFW8WhDDOWDwlpVq3V1xoF4MU7gAnkCBMhJODNGg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(346002)(26005)(508600001)(45080400002)(55016002)(9686003)(186003)(6506007)(4326008)(2906002)(53546011)(5660300002)(110136005)(8936002)(52536014)(66556008)(8676002)(7696005)(64756008)(33656002)(66946007)(66476007)(71200400001)(66446008)(76116006)(83380400001)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Mv/VWYm5vjLyN4JLr5/PGwV9AJt6HQcpXwykXnrXiULol/SOfvN54SbHEJMi?=
 =?us-ascii?Q?MceOldxhHKJURmpISF7QN17mILOhpPguzGgCKDNhdqT7WAdM25Z3b16dxt8Z?=
 =?us-ascii?Q?4O6KTegNnypLYYVDpaxl+EUidBLPa44op0J0d3NK/qJNAa11Bfe48kpKYj//?=
 =?us-ascii?Q?W37kqiayAYm0w3MPNNF25NpCecgyg815zzjiscVtHnZfCy1hBlbB9a/iyO6D?=
 =?us-ascii?Q?DBvTGvrHYBi92WsvrWBdhsGDeEODqnxY5n8p4TszHtwahz1fx1dbjXVUwCD5?=
 =?us-ascii?Q?6YcKF+CwKAdbEDNnOc3XHkHPHpWn/jFMWzH7EuaNkis69inw9v3jNgJ4lir7?=
 =?us-ascii?Q?YJOR0TUx5Ime2UMA5gJ368XxqBJ4jY3lvWYfSXrErT2QtEYkfc6DQOeVznU7?=
 =?us-ascii?Q?L8yN6vB/E6GkKOB691S8Mii/9BRn3H3vQHKKR2oJkxiIlr/PlxyhFQzvUrZg?=
 =?us-ascii?Q?xyKO0PkIbfuK5UvaHVRsU09RcOPckhXEBsKlVL/RFem/y3/F5xBlR/2cXnGF?=
 =?us-ascii?Q?Dy3IFvft04BuLORu4EevPeRXhr367zAkBdJidbmykIwRmY5XKl5M9MsrlBr8?=
 =?us-ascii?Q?uk2phH4vDPnQwMtnabgJl/yNNj9p7L1LtkaeB+fUmOy3c75iKg/aHCXzDRsF?=
 =?us-ascii?Q?ZDa8u2h6JQ7/ksTDcaWVJ79BXkD1ZtcVFhi2InwDBJpG/np6Efp647K6Pf3m?=
 =?us-ascii?Q?Cn039co7oldjPP3nZ7/KQuwauW+2v07r6UESFCxpru3BfnmaDVJiOzX9dPbP?=
 =?us-ascii?Q?OzUW8QgZZSYPVweiyds6Hee80ZGsUWl5FMdfP5MtfOJZuCTyAzCEsckaEgMy?=
 =?us-ascii?Q?z9vVLdmFXWrMDfqiJkOlQjOq4afRECB+JtP653P0/ZAi7hS50ftei2VHud2R?=
 =?us-ascii?Q?2QQPO4Arh40bpGVLsVIJCc0VltOTTkmW4nyOuq82uy7HGikYDM2+EzjqNACq?=
 =?us-ascii?Q?Hz0wwcVV93eUEeKdQAAQfQFbyBcja0BEHgfkt0u0xME=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf720148-a019-45cb-c0d3-08d89ffb3bda
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2020 06:41:06.0855 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E/sfMTzOVD4vasTiXq7GWgZGHt0AkpgdO6WNL4eebeZHL5i0Jnb3PQYjyquxSwUMOn/uNAl6WkqiJYfLvgcGkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2542
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
Cc: "Jian, Jane" <Jane.Jian@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Hi Lijo,

Good point, I will modify and send patch version two.

Regards,
Stanley
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Monday, December 14, 2020 12:01 PM
> To: Yang, Stanley <Stanley.Yang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Yang, Stanley <Stanley.Yang@amd.com>; Jian, Jane <Jane.Jian@amd.com>
> Subject: RE: [PATCH 1/1] drm/amdgpu: skip load smu and sdma microcode on
> sriov for SIENNA_CICHLID
> 
> [AMD Public Use]
> 
> >-----Original Message-----
> >From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> >Stanley.Yang
> >Sent: Monday, December 14, 2020 8:41 AM
> >To: amd-gfx@lists.freedesktop.org
> >Cc: Yang, Stanley <Stanley.Yang@amd.com>; Jian, Jane
> ><Jane.Jian@amd.com>
> >Subject: [PATCH 1/1] drm/amdgpu: skip load smu and sdma microcode on
> >sriov for SIENNA_CICHLID
> >
> >[CAUTION: External Email]
> >
> >skip load smu and sdma fw on sriov due to smc, sos, ta and asd fw have
> >been skipped for SIENNA_CICHLID.
> >
> >Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> >---
> > drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c    | 3 +++
> > drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 4 +++-
> > 2 files changed, 6 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> >b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> >index 39e17aae655f..87566dee048d 100644
> >--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> >+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> >@@ -153,6 +153,9 @@ static int sdma_v5_2_init_microcode(struct
> >amdgpu_device *adev)
> >        struct amdgpu_firmware_info *info = NULL;
> >        const struct common_firmware_header *header = NULL;
> >
> >+       if (amdgpu_sriov_vf(adev) && (adev->asic_type ==
> >CHIP_SIENNA_CICHLID))
> >+               return 0;
> >+
> >        DRM_DEBUG("\n");
> >
> >        switch (adev->asic_type) {
> >diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> >b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> >index cf999b7a2164..31f05d96586c 100644
> >--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> >+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> >@@ -847,7 +847,9 @@ static int smu_sw_init(void *handle)
> >        smu->smu_dpm.dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
> >        smu->smu_dpm.requested_dpm_level =
> AMD_DPM_FORCED_LEVEL_AUTO;
> >
> >-       if (!amdgpu_sriov_vf(adev) || (adev->asic_type != CHIP_NAVI12)) {
> >+       if (!amdgpu_sriov_vf(adev) ||
> >+                       ((adev->asic_type != CHIP_NAVI12) &&
> >+                       (adev->asic_type != CHIP_SIENNA_CICHLID))) {
> >                ret = smu_init_microcode(smu);
> >                if (ret) {
> >                        dev_err(adev->dev, "Failed to load smu
> >firmware!\n");
> >--
> 
> It's not good to keep adding ASIC checks in the generic interface code. Move
> this check to smuv11.
> 
> Thanks,
> Lijo
> 
> >2.17.1
> >
> >_______________________________________________
> >amd-gfx mailing list
> >amd-gfx@lists.freedesktop.org
> >https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s
> >.f
> >reedesktop.org%2Fmailman%2Flistinfo%2Famd-
> >gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C0a496c71fa1d4bc6a8
> 72
> >08d89fddf683%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6374
> 35
> >122965129344%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLC
> JQ
> >IjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=i1y6s
> nfi
> >3bnQVHOuVGfMqjSG%2FsBLYtxLkrnT9PV4%2FbU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
