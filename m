Return-Path: <SRS0=lEWV=I5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3084EC433C1
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 09:02:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFB97619BB
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 09:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFB97619BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 825846E9FF;
	Wed, 31 Mar 2021 09:02:04 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E78C66E9FF
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Mar 2021 09:02:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvvSpmWowisTcpM+sT4tD3sCPJEn2ioJWQOJPAYXBN3JHjuzUQqoreoo1OIM35fjy6h4MLrloSh0sBKkoU8cqMj0Apae883Dc+lE5Lpn+wqZxV/dRogLN3vKqapYI18pl6bBOP0Tc8RB4lt/2YOI3mlFeQQ533M8ONBBAKIRxCzj3EyEBKl9LUO/ocHmXH43GwDrGNYI15lHaQBNO6eB1ONcrPsHzCH1PhFFxK4ZkgFnJ+P4zMq8127qizTdAmZZb0wD5r2zAs+zpRDFWVTYbkxHI6nIvY7YZm6Ak0wZTRD9BTYkA99MY25NQFvDtYRGv8FSJEEu26Sv/eMW8KEj2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rxRsUx/YQ38cff3TGQqUOwMg/93i9dGuZQzx8+zW3w=;
 b=FQCCy4aAuNQyHid2x/bAm7LMR90rbZ0DK6C1a+rKcPchCl4cvrUXiOD1A5/20XSRDcc/ylWaH+CPjCUaf0yOAybB+yiLynXxiw5KXZ7sJw+CKFTdeZbn/BFFX0ztJgqipmdhxTJqgHAykXMMuK7GX10JCP/BT6hFhfnktv7gMCVytuhAEIdrTS9RbYm9CSirYsZDQzZyFkSvfEILsijtniZdhzWM5kh1XBNQPBRqAjw250KCYyQ59uUoUll3jyVJREyQ+/ERUdH2TROwaFQqru3eSjYKLTRdWNKs9nFi62dB1XQQc6vdkOBK0fyKNLXItX2cZ8/a3M3GusO1A2PJCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rxRsUx/YQ38cff3TGQqUOwMg/93i9dGuZQzx8+zW3w=;
 b=n7j6/sf4d9XyUvCa+GF7Cm3r/pmACIGprCYwrK66GFmNzytMk1DObFzaEhszHEn4upuTPDN0AoN6yaqvZ7GlRHmIHcLv79nSk7hfrWP8xyIEwNPg5AXCKDbcR5pdj75khmsjVCIQy4DIJ9P7vkMMHpCBJE+BqVVjLyx5MuL5bX8=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BYAPR12MB2599.namprd12.prod.outlook.com (2603:10b6:a03:6b::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.33; Wed, 31 Mar
 2021 09:02:02 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132%3]) with mapi id 15.20.3999.027; Wed, 31 Mar 2021
 09:02:02 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: Revert "SWDEV-238407 Add clear vf fw
 support"
Thread-Topic: [PATCH 2/2] drm/amdgpu: Revert "SWDEV-238407 Add clear vf fw
 support"
Thread-Index: AQHXJffmHG3GZpNlX0Sx8NZx4r4iz6qdzRBw
Date: Wed, 31 Mar 2021 09:02:01 +0000
Message-ID: <BY5PR12MB41155C1B22B01B9CD637FFD88F7C9@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210331063407.9065-1-Emily.Deng@amd.com>
 <20210331063407.9065-2-Emily.Deng@amd.com>
In-Reply-To: <20210331063407.9065-2-Emily.Deng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=005322fe-d250-4133-bcac-47fe7b99d2c5;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-31T09:01:55Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5503df46-14b5-4698-6b86-08d8f423a620
x-ms-traffictypediagnostic: BYAPR12MB2599:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2599DCEFEF1D624D1D2473F88F7C9@BYAPR12MB2599.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:194;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uj2Ok9MxQmovF8x9TG1upvPkDJ44mahdyYxcRo1DXXveN6ul2XB8wSt9b5uioEr2Z/cyrGvbJCfnRYT4IEgQBdQ8cz7jRkYQ5OQ8mf5llY7XBhR5GV5D8xhvaMRwXLBMEadno97k0usDVpIex4IPmVVeKfv8SSMMldIcO3/uHtMYirY9uDS2JJBfsxZFrjZ4IrqZREj/tMnJHeGyiCza919oJ2Ja6Ly1kYVS3BbX5ibAKBTkJ1RvcgOoKAZt3cVJTXc43RisfIKr97L8ffjf67EIiNCn0cIlaaSU5/B+R9dXuJ8Oo0+hMijpG7JbRMGenR+E4MN5ty6ybqA65l6olRkS9AXUvf03HAJ89B9ctbm1WI/7T8FAQrKk62H9tMYocgSWO148aNvID4aCiqvZMS/2bn6f1lQadEp4rTot8BLABxwiaVZT0JAoJBHQBzU3MbcUoN0QH4tCNAjEbUxHezF3YD35SDZVFxYXk4owQHU3lfUycZssizDDD8h/RwjEU1jP50XePWnfqRz545mhOI54WhW7XIXEH3+tR7gE6hd97Xr++ck6AEbJtcKwP3c3PkrxIcIGDIrLDpumBEbzMpazCOjkl2X1fvIITiVXUNi6joYcLz+JOwHAi6yg0mCLXQf/6hO1uqOfyF9UOV+uiGTQeS3bdGJJnxCFj90ASP4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(6506007)(5660300002)(316002)(33656002)(110136005)(38100700001)(86362001)(71200400001)(8936002)(478600001)(52536014)(66946007)(7696005)(55016002)(8676002)(76116006)(26005)(186003)(66556008)(66476007)(9686003)(64756008)(66446008)(83380400001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?mybb+OJeSAWr5w+RZAnQLLmqqOYWE8uo9T6We0SN74EJd6qk4ofok7gKuEQi?=
 =?us-ascii?Q?maiUMPbB9Z6+7tBFf3/1d8cCYzB4dl8E7YqOeY/OsF9rIO4zdgX8DzdbgCKp?=
 =?us-ascii?Q?d5yct+SJrKwBkpeUep0GRm/id0XHJrJRNK8oquQU+iYyhbbzIq8BkH0EbTfY?=
 =?us-ascii?Q?2wr4QDYgBwm1g56mV4zxBYjko/88nRXT2GM2i2L2ESIeWh8drPZLrweBE0Tu?=
 =?us-ascii?Q?S/7csCSXEvJYkH1RWEYkMUObFsZENyTcvIMgWL/BOwdnZXmiuGCfzLfmyhMm?=
 =?us-ascii?Q?Cs7JKEj95vuiS3NmcSKkqikG76EHWHulk6yXJ/LziBC1zQQ+VI6VdMmndOwB?=
 =?us-ascii?Q?1qdao/dEQc1csWnJfTnkDYHNqh0iXkSg9NeJ73W0MHJMLshP8o+F8cDCQVvw?=
 =?us-ascii?Q?pKEvk4KBdR4dvGOGhb9IknLgKjrg5IHrdCMdwochBO/ci0lS1N9xbNntTGQc?=
 =?us-ascii?Q?G08R9OSiUiAiFMRj0lHeuiviIH6KeU03M2hRBRxUn4c7d6tWGXFX9J8ROBZJ?=
 =?us-ascii?Q?fyeKKAWQ2nhxZyIX9AVSPY7HyXPN1JHf2LszJ47BgnG5J0eqUzz6hJNrvAky?=
 =?us-ascii?Q?n8bPsnk/cE3Y+jDmXSBtdGZkXCZPMXKAqF36lyiaextMmujd4XebADC7J1y4?=
 =?us-ascii?Q?epSD7zZCQYJYagxqcdy/uVExkRC5fhuEtPTcbHy+wkPu0Rf8p2/8OttT468m?=
 =?us-ascii?Q?5LSbPFjYnKRoyPFNCBFmL6Fa/ZF9C10fYMLKOtgWsA0idzkkDz0HHmZ7lDP2?=
 =?us-ascii?Q?8T3EHflAjmbIx3hLJIqh4BDKjpGrf4lSwQOFRWntUoP7l1AsOa2zaTe69yur?=
 =?us-ascii?Q?CKNNBlgsMhzkSYPVkJoWGYahA/kGMSJCLz9BzJSyWQ+Uu5DxI6NHL0xfrkgd?=
 =?us-ascii?Q?P7lSqfmIcAxVfUpNxv9fw8N0YjnthwkB1913kDEjxpVGorh6e12Xm+R/z8b4?=
 =?us-ascii?Q?iE5x4FOf5kfihoJ4Ue3TwjIZzc3UuYiM+CI30ByLcQvrqW2DJPFoaWHutEDD?=
 =?us-ascii?Q?9Rpite6tGVx+ghLJj6OPb+tWiXJd48Z7jqqq9n8voBQ+cD7djLhtKhkRt3Jb?=
 =?us-ascii?Q?ucBM6KEBZVOpVi7zqeozfuL9y4uXBcN9cDvORZ+5XZBFyrTVw1nqdJ7VZZJ3?=
 =?us-ascii?Q?BiJJ/NMqnEs5OJHvb/KeHMSHtXoq1gzTApG8XwobRPBOAOfSRhRZEJf7bDwJ?=
 =?us-ascii?Q?4+KZVDnD1aBnaXIdxKM9l0WAA4H+TiV09ww4rAnkMvm25nqXc5LScr9wDayT?=
 =?us-ascii?Q?c91zBLCpWI57wg5vvGVr97Hqigf/KgFTVYzZKginqfdvfVAflFLx9wh/63Ci?=
 =?us-ascii?Q?CF6W91NEvC89CzYpQOECBIxt?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5503df46-14b5-4698-6b86-08d8f423a620
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 09:02:01.8780 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iNvOszuzrrKpmg/BtnEcw51IBNvOP/tHzj43C7oPMZ1C37o8vVo5RrHcXwyCs7o8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2599
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

[AMD Official Use Only - Internal Distribution Only]

Ping ......

>-----Original Message-----
>From: Emily Deng <Emily.Deng@amd.com>
>Sent: Wednesday, March 31, 2021 2:34 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: [PATCH 2/2] drm/amdgpu: Revert "SWDEV-238407 Add clear vf fw
>support"
>
>As already moved the support to host driver, so revert this in guest driver.
>This reverts commit 8d5e6f45df5f9073760dea0ab94321615cea16ec.
>
>Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 36 ++-----------------------
>drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h |  8 ------
> 2 files changed, 2 insertions(+), 42 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>index c36c8fca1f64..aa2f8fc4aac8 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>@@ -291,9 +291,8 @@ psp_cmd_submit_buf(struct psp_context *psp,
> amdgpu_asic_invalidate_hdp(psp->adev, NULL);
> }
>
>-/* We allow TEE_ERROR_NOT_SUPPORTED for VMR command and
>PSP_ERR_UNKNOWN_COMMAND in SRIOV */
>-skip_unsupport = (psp->cmd_buf_mem->resp.status ==
>TEE_ERROR_NOT_SUPPORTED ||
>-psp->cmd_buf_mem->resp.status ==
>PSP_ERR_UNKNOWN_COMMAND) && amdgpu_sriov_vf(psp->adev);
>+/* We allow TEE_ERROR_NOT_SUPPORTED for VMR command in
>SRIOV */
>+skip_unsupport = (psp->cmd_buf_mem->resp.status == 0xffff000a)
>&&
>+amdgpu_sriov_vf(psp->adev);
>
> memcpy((void*)&cmd->resp, (void*)&psp->cmd_buf_mem->resp,
>sizeof(struct psp_gfx_resp));
>
>@@ -420,26 +419,6 @@ static int psp_tmr_init(struct psp_context *psp)
> return ret;
> }
>
>-static int psp_clear_vf_fw(struct psp_context *psp) -{
>-int ret;
>-struct psp_gfx_cmd_resp *cmd;
>-
>-if (!amdgpu_sriov_vf(psp->adev) || psp->adev->asic_type !=
>CHIP_NAVI12)
>-return 0;
>-
>-cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
>-if (!cmd)
>-return -ENOMEM;
>-
>-cmd->cmd_id = GFX_CMD_ID_CLEAR_VF_FW;
>-
>-ret = psp_cmd_submit_buf(psp, NULL, cmd, psp-
>>fence_buf_mc_addr);
>-kfree(cmd);
>-
>-return ret;
>-}
>-
> static bool psp_skip_tmr(struct psp_context *psp)  {
> switch (psp->adev->asic_type) {
>@@ -1924,12 +1903,6 @@ static int psp_hw_start(struct psp_context *psp)
> return ret;
> }
>
>-ret = psp_clear_vf_fw(psp);
>-if (ret) {
>-DRM_ERROR("PSP clear vf fw!\n");
>-return ret;
>-}
>-
> ret = psp_boot_config_set(adev);
> if (ret) {
> DRM_WARN("PSP set boot config@\n");
>@@ -2448,11 +2421,6 @@ static int psp_hw_fini(void *handle)
> }
>
> psp_asd_unload(psp);
>-ret = psp_clear_vf_fw(psp);
>-if (ret) {
>-DRM_ERROR("PSP clear vf fw!\n");
>-return ret;
>-}
>
> psp_tmr_terminate(psp);
> psp_ring_destroy(psp, PSP_RING_TYPE__KM); diff --git
>a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
>b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
>index dd4d65f7e0f0..b5b1feaa259e 100644
>--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
>+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
>@@ -97,7 +97,6 @@ enum psp_gfx_cmd_id
>     GFX_CMD_ID_SETUP_VMR          = 0x00000009,   /* setup VMR region */
>     GFX_CMD_ID_DESTROY_VMR        = 0x0000000A,   /* destroy VMR region
>*/
>     GFX_CMD_ID_PROG_REG           = 0x0000000B,   /* program regs */
>-    GFX_CMD_ID_CLEAR_VF_FW        = 0x0000000D,   /* Clear VF FW, to be
>used on VF shutdown. */
>     GFX_CMD_ID_GET_FW_ATTESTATION = 0x0000000F,   /* Query GPUVA of
>the Fw Attestation DB */
>     /* IDs upto 0x1F are reserved for older programs (Raven, Vega 10/12/20)
>*/
>     GFX_CMD_ID_LOAD_TOC           = 0x00000020,   /* Load TOC and obtain
>TMR size */
>@@ -401,11 +400,4 @@ struct psp_gfx_rb_frame
>                 /* total 64 bytes */
> };
>
>-#define PSP_ERR_UNKNOWN_COMMAND 0x00000100
>-
>-enum tee_error_code {
>-    TEE_SUCCESS                         = 0x00000000,
>-    TEE_ERROR_NOT_SUPPORTED             = 0xFFFF000A,
>-};
>-
> #endif /* _PSP_TEE_GFX_IF_H_ */
>--
>2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
