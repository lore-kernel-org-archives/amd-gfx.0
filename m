Return-Path: <SRS0=CFUU=N4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968A1C433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Sep 2021 09:26:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 378EB6056C
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Sep 2021 09:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 378EB6056C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1FA389690;
	Mon,  6 Sep 2021 09:26:40 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2062.outbound.protection.outlook.com [40.107.96.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC2608967A
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Sep 2021 09:26:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AL6czB6fjsYpU5hNpmSfGVsrjsPCJMbmiM7c+tHtR0D4dQb7OuBu5x3mPRzmXKQWMe8smX2/dWK67/Gg4OIPgyoUycuaaeX3+Zg1Pd+iWr4aB0tEojH0GKCLx1uOgt/1tAnf6/6NPebMftye2dUQY3uLJZgVRqeNUIVws3RnZAOEQUj0rsNqovZUlqdb4ERL6OKoMr4kyNO53INViVgnQVCTfSZ3+pTYZlv/uzJZkA4wL+AKQmdoLhZ9FGdBFj3mLUUAP/6lsgtLhBFKjGi3eBzaS7vwprBdKZdgPmh9YaG0mrCxZlZLqMLF7jtOI8K9o7NyZgTogD9/+rEz+wyURA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=HEVRCiGqMOL9bB3XHdEtFcajCEa+LaECp4wqnsTFA5s=;
 b=Ic/cD0wZPJIhn9iEX8hY9EkkG9cVR+EHly1N9SXmCdZIMeu6RVlI4sZC8U5/x3WI32+xNidVUKwH5jk6s8t3EA8fUREES5NdCD/ur0LVxqMGykBCyhPisVl2N8fxCmUfkczGgj4qE8VtmcCAD6LJxHtzLiWlp/VyDA9K+p7cbwSumXYsQa5F+DLjg6/+0Bq/4aGoMp3u38PNO4TdRN/tNNq0EnKjsUD4Q3uesBB1B3pr+gevuMvH7X9+lF4kCFUp+sQk6TZM7fK/JbpffkzzzI7oftsvsDjCAH4KYtMrgvwaLio1y+IoOBrE2lncaEnL9e9OJ6gc7J3ZxZyAj08sEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEVRCiGqMOL9bB3XHdEtFcajCEa+LaECp4wqnsTFA5s=;
 b=2i6sDSK1BwoS/tfLk/RlVf5Fy+eXGC8riBmQoA0C46Hq6OHI839QRmG7YD6ilqugsA0moZgjdYfNpR40uNCzMjD4TE+1DwT/KM1FcpEFydfyE9qtwZmYbbesk0MJvi0BNq2LjuVQmz9BGsVY994RLhg05URF6qxHn+Pi5V5cWHo=
Received: from BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11)
 by BN9PR12MB5209.namprd12.prod.outlook.com (2603:10b6:408:11a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Mon, 6 Sep
 2021 09:26:37 +0000
Received: from BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::a3:7688:bffe:880e]) by BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::a3:7688:bffe:880e%3]) with mapi id 15.20.4478.025; Mon, 6 Sep 2021
 09:26:37 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Create common PSP TA load function
Thread-Topic: [PATCH] drm/amdgpu: Create common PSP TA load function
Thread-Index: AQHXovoDj9UifJlg0kOX+Oehio6ZuquWvIeQ
Date: Mon, 6 Sep 2021 09:26:37 +0000
Message-ID: <BN9PR12MB5226B232853FE887A1495673FBD29@BN9PR12MB5226.namprd12.prod.outlook.com>
References: <20210906083412.27473-1-candice.li@amd.com>
In-Reply-To: <20210906083412.27473-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-06T09:26:35Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=b4f4430b-6b51-4bb3-bd5b-5456e851f7f9;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05dd155b-d9c8-4434-7300-08d971186d64
x-ms-traffictypediagnostic: BN9PR12MB5209:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB520954C29CDD036147787E19FBD29@BN9PR12MB5209.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BrR4/RGxHIdp8e/eHAZEy7C9NfOJz5PubJaOibQHBa1o6m2cXPgP+THIBi/t/k1TcgZuB1RH+fQbqgcnn1rTuh0YJQNnUdjO994W/eU/5sKSZLuPv6nVz63Ff2JZcWBJoOEDLWh7qsTl6L3KCojB54Eg0X9YelmC5J7JGhQEJNd524xzMs98ddyM64VHuh2tXhMQTahzEhnoV1h/aWoVFtpNlI2YODOVq9xpdaUSFH8NwGMGS+rHp5WPNgP7OdXWB3t/cOjjd47QyByGHl3wy01WqkEPHDUyXYRYeNhOKDZ3kY2l3gMzNwegjzXb+YLq7cEsbsVKkQv3kmOmGt9nk+DBBzyMwFM4/ikZ++tJC6kYYzG7pNmhyl7c9NJ7v+BwYNi4LwXrdXz2E4SCGbCsN+GJDIKFFb1l2X1ShmDYfqrQ/16FjaCrnMAs6nD9cA2a09fxPlAGnOuet5CaxlkUm4i2iCdMPLd+rSGuknwhy4n1JFb+9yut07IzSYnBgnJU2JdQAw8HWdSbpZdxAZZnTQuZFOOLySkC+fOlqAxVLyJNyL+W+BvmMHoyWXrrTempZ5+Mr9tMwJCSbaVBcLCOiuoJ67aFSPM18J9iE7ntMfr9XCkDBRbKLfuKfEebg80rS6TTAD89nFqb8WZxPAKNU6lEAVk/6jF6D+xPRRLWaYkxtJYBHWCW4VpOUsw7ZV63XNV95eIxG3+F4bWgai6maw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(33656002)(122000001)(66446008)(30864003)(6506007)(66946007)(53546011)(110136005)(76116006)(2906002)(7696005)(5660300002)(66476007)(71200400001)(64756008)(66556008)(316002)(38100700002)(26005)(8936002)(38070700005)(52536014)(186003)(8676002)(55016002)(478600001)(9686003)(83380400001)(86362001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3MSUBjUeGOIx8FUkuF/Hubk1IyLjL13ssS5IlerivuVwBbma+Q9aJV6uoXU8?=
 =?us-ascii?Q?Sr/IhAYv+S7TDL4sZMbudRXgvHc41thex4/8Ux37eE7iCcC8U/JbDiOnFDpC?=
 =?us-ascii?Q?g+38axxfOG3q8bSWHz0392g+recHTqA79sMtKEl6mIaU7XE1rT0llGqWtmYS?=
 =?us-ascii?Q?j1+0QtEl8sk9ovMzbEGLS5Ydw6AlzEDD3ig0CoboZdDMbnSz0On/0gmcCQWU?=
 =?us-ascii?Q?7OaxMxJ24dKiy4fhXFF6jeZaUCw2hEQl4Pb+AxIoLnIf9rOO/F5OIyfOVpxw?=
 =?us-ascii?Q?F3gogVZfNXP61b/T3JgN0P+wFzQpj6q+8NrfmFMLmGxeNaAAj/F4NS8q9vCv?=
 =?us-ascii?Q?0Pg7DpRcags3GN51YUYJ+cTYuJoF/P3cshLygRy9xPdhAhzoA/gmH1gauDKH?=
 =?us-ascii?Q?16boNlHHlPbhSIWxy+MpClrDR6gbHXt34YjSsb5f1XYgjh2odea0iMqfL9LI?=
 =?us-ascii?Q?Stcl7XH/zsH/VYQLkaot45xsObINnxUxhuYut4W57YuHBX84SBTNYAPkhsAs?=
 =?us-ascii?Q?mYb7RHy0+Bqwitjzw3fzCRFNqwifx1YbtshD0zfZixQ+vIaOhlnxT7mTViPf?=
 =?us-ascii?Q?5NZlDJ7Cb5LLZi1NbzX9uGvE8Hx+YdsYPDAOJIoteLwc+GeGnYBORk55JLws?=
 =?us-ascii?Q?omfBa+Kc2UrKVuIRymchQuiT1D17YpcTiZAYBMy+UbjBWW+WutN8G+8ZFBno?=
 =?us-ascii?Q?K1ipCXXyoRBDvBrWzD66eBF5k45NM0bCNFoejC9gz10VFK3BRotb0grsoRcu?=
 =?us-ascii?Q?O1nS0J7ZGM7zdElhPjIJnGwEfbSZWCDesXiIIXmHAPyc7Pz9WgteCOg32dOe?=
 =?us-ascii?Q?bp2F2aeJI/5GLZYi/Nqg2T8FLDg8jIXNZi+aPkmEgEbeFNrr1Xm0wlTpas2F?=
 =?us-ascii?Q?zJQmn33BAOxhzK65LZKTzsRb9Sy7XSu+DOif3N1fegR3HgKtGxMrLnVZF2yN?=
 =?us-ascii?Q?aGGiaNNmQMid43kW53Dd4fDIIZzcs+B34Kd3P9bLZ69IvPVoQqPUCJ6a95FQ?=
 =?us-ascii?Q?FnZyLtJHBi5DGnDWLSeak52xawkkKiPAcFU2ijcp697qpuUDWh6VMur70BDB?=
 =?us-ascii?Q?XwVDFedErvA/hOE0SPHobhLlGntG7gI+UECYC4kIKAX1FNyAUCRFIIBUGFrW?=
 =?us-ascii?Q?4d7xTrWi6legpXT6URJlTN8RvqEWXkDF/klAgxn5GwXGmG7lF5uPzn0RP3a8?=
 =?us-ascii?Q?CTVMjdw2vn+u5GmI3c0cD++FLmpzatrsOt/SCU5S7qoGSIsN/AhdjZeQi14y?=
 =?us-ascii?Q?f+pWCHPst9fXKU09EEy+5dLuVSdxnIj+oNs4WjYrPIqvDaoWTNlW7akDhzyB?=
 =?us-ascii?Q?VBTXEHCgsxMmCWn7dEQsIcJE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05dd155b-d9c8-4434-7300-08d971186d64
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2021 09:26:37.6521 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ylOjCPqG6ZB/uGJbt4VLLzwdTbsvgD7iJtQMGEwHuMBh8rqJ1UPZU9OC1OOuQYwV/yuyM3zTWO7mO5JLUHD4kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5209
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: John Clements <john.clements@amd.com>

-----Original Message-----
From: Li, Candice <Candice.Li@amd.com>=20
Sent: Monday, September 6, 2021 4:34 PM
To: amd-gfx@lists.freedesktop.org
Cc: Clements, John <John.Clements@amd.com>; Li, Candice <Candice.Li@amd.com=
>
Subject: [PATCH] drm/amdgpu: Create common PSP TA load function

Creat common PSP TA load function and update PSP ta_mem_context with size i=
nformation.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 280 +++++++-----------------  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  17 +-
 2 files changed, 93 insertions(+), 204 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 54c26432c65b3d..75eed18370eb12 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -901,22 +901,20 @@ int psp_reg_program(struct psp_context *psp, enum psp=
_reg_prog_id reg,  static void psp_prep_ta_load_cmd_buf(struct psp_gfx_cmd_=
resp *cmd,
 				     uint64_t ta_bin_mc,
 				     uint32_t ta_bin_size,
-				     uint64_t ta_shared_mc,
-				     uint32_t ta_shared_size)
+				     struct ta_mem_context *mem_ctx)
 {
 	cmd->cmd_id				=3D GFX_CMD_ID_LOAD_TA;
 	cmd->cmd.cmd_load_ta.app_phy_addr_lo 	=3D lower_32_bits(ta_bin_mc);
 	cmd->cmd.cmd_load_ta.app_phy_addr_hi	=3D upper_32_bits(ta_bin_mc);
 	cmd->cmd.cmd_load_ta.app_len		=3D ta_bin_size;
=20
-	cmd->cmd.cmd_load_ta.cmd_buf_phy_addr_lo =3D lower_32_bits(ta_shared_mc);
-	cmd->cmd.cmd_load_ta.cmd_buf_phy_addr_hi =3D upper_32_bits(ta_shared_mc);
-	cmd->cmd.cmd_load_ta.cmd_buf_len	 =3D ta_shared_size;
+	cmd->cmd.cmd_load_ta.cmd_buf_phy_addr_lo =3D lower_32_bits(mem_ctx->share=
d_mc_addr);
+	cmd->cmd.cmd_load_ta.cmd_buf_phy_addr_hi =3D upper_32_bits(mem_ctx->share=
d_mc_addr);
+	cmd->cmd.cmd_load_ta.cmd_buf_len	 =3D mem_ctx->shared_mem_size;
 }
=20
 static int psp_ta_init_shared_buf(struct psp_context *psp,
-				  struct ta_mem_context *mem_ctx,
-				  uint32_t shared_mem_size)
+				  struct ta_mem_context *mem_ctx)
 {
 	int ret;
=20
@@ -924,8 +922,8 @@ static int psp_ta_init_shared_buf(struct psp_context *p=
sp,
 	* Allocate 16k memory aligned to 4k from Frame Buffer (local
 	* physical) for ta to host memory
 	*/
-	ret =3D amdgpu_bo_create_kernel(psp->adev, shared_mem_size, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM,
+	ret =3D amdgpu_bo_create_kernel(psp->adev, mem_ctx->shared_mem_size,
+				      PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM,
 				      &mem_ctx->shared_bo,
 				      &mem_ctx->shared_mc_addr,
 				      &mem_ctx->shared_buf);
@@ -941,8 +939,7 @@ static void psp_ta_free_shared_buf(struct ta_mem_contex=
t *mem_ctx)
=20
 static int psp_xgmi_init_shared_buf(struct psp_context *psp)  {
-	return psp_ta_init_shared_buf(psp, &psp->xgmi_context.context.mem_context=
,
-				      PSP_XGMI_SHARED_MEM_SIZE);
+	return psp_ta_init_shared_buf(psp,=20
+&psp->xgmi_context.context.mem_context);
 }
=20
 static void psp_prep_ta_invoke_cmd_buf(struct psp_gfx_cmd_resp *cmd, @@ -9=
71,31 +968,27 @@ static int psp_ta_invoke(struct psp_context *psp,
 	return ret;
 }
=20
-static int psp_xgmi_load(struct psp_context *psp)
+static int psp_ta_load(struct psp_context *psp,
+			   struct psp_bin_desc *bin_desc,
+			   struct ta_context *context)
 {
 	int ret;
 	struct psp_gfx_cmd_resp *cmd;
=20
-	/*
-	 * TODO: bypass the loading in sriov for now
-	 */
-
 	cmd =3D acquire_psp_cmd_buf(psp);
=20
-	psp_copy_fw(psp, psp->xgmi.start_addr, psp->xgmi.size_bytes);
+	psp_copy_fw(psp, bin_desc->start_addr, bin_desc->size_bytes);
=20
 	psp_prep_ta_load_cmd_buf(cmd,
 				 psp->fw_pri_mc_addr,
-				 psp->xgmi.size_bytes,
-				 psp->xgmi_context.context.mem_context.shared_mc_addr,
-				 PSP_XGMI_SHARED_MEM_SIZE);
+				 bin_desc->size_bytes,
+				 &context->mem_context);
=20
 	ret =3D psp_cmd_submit_buf(psp, NULL, cmd,
 				 psp->fence_buf_mc_addr);
=20
 	if (!ret) {
-		psp->xgmi_context.context.initialized =3D true;
-		psp->xgmi_context.context.session_id =3D cmd->resp.session_id;
+		context->session_id =3D cmd->resp.session_id;
 	}
=20
 	release_psp_cmd_buf(psp);
@@ -1003,6 +996,11 @@ static int psp_xgmi_load(struct psp_context *psp)
 	return ret;
 }
=20
+static int psp_xgmi_load(struct psp_context *psp) {
+	return psp_ta_load(psp, &psp->xgmi, &psp->xgmi_context.context); }
+
 static int psp_xgmi_unload(struct psp_context *psp)  {
 	return psp_ta_unload(psp, psp->xgmi_context.context.session_id);
@@ -1051,6 +1049,8 @@ int psp_xgmi_initialize(struct psp_context *psp, bool=
 set_extended_data, bool lo
 	if (!load_ta)
 		goto invoke;
=20
+	psp->xgmi_context.context.mem_context.shared_mem_size =3D=20
+PSP_XGMI_SHARED_MEM_SIZE;
+
 	if (!psp->xgmi_context.context.initialized) {
 		ret =3D psp_xgmi_init_shared_buf(psp);
 		if (ret)
@@ -1059,7 +1059,9 @@ int psp_xgmi_initialize(struct psp_context *psp, bool=
 set_extended_data, bool lo
=20
 	/* Load XGMI TA */
 	ret =3D psp_xgmi_load(psp);
-	if (ret)
+	if (!ret)
+		psp->xgmi_context.context.initialized =3D true;
+	else
 		return ret;
=20
 invoke:
@@ -1281,57 +1283,12 @@ int psp_xgmi_set_topology_info(struct psp_context *=
psp,  // ras begin  static int psp_ras_init_shared_buf(struct psp_context *=
psp)  {
-	return psp_ta_init_shared_buf(psp, &psp->ras_context.context.mem_context,
-				      PSP_RAS_SHARED_MEM_SIZE);
+	return psp_ta_init_shared_buf(psp,=20
+&psp->ras_context.context.mem_context);
 }
=20
 static int psp_ras_load(struct psp_context *psp)  {
-	int ret;
-	struct psp_gfx_cmd_resp *cmd;
-	struct ta_ras_shared_memory *ras_cmd;
-
-	/*
-	 * TODO: bypass the loading in sriov for now
-	 */
-	if (amdgpu_sriov_vf(psp->adev))
-		return 0;
-
-	psp_copy_fw(psp, psp->ras.start_addr, psp->ras.size_bytes);
-
-	ras_cmd =3D (struct ta_ras_shared_memory *)psp->ras_context.context.mem_c=
ontext.shared_buf;
-
-	if (psp->adev->gmc.xgmi.connected_to_cpu)
-		ras_cmd->ras_in_message.init_flags.poison_mode_en =3D 1;
-	else
-		ras_cmd->ras_in_message.init_flags.dgpu_mode =3D 1;
-
-	cmd =3D acquire_psp_cmd_buf(psp);
-
-	psp_prep_ta_load_cmd_buf(cmd,
-				 psp->fw_pri_mc_addr,
-				 psp->ras.size_bytes,
-				 psp->ras_context.context.mem_context.shared_mc_addr,
-				 PSP_RAS_SHARED_MEM_SIZE);
-
-	ret =3D psp_cmd_submit_buf(psp, NULL, cmd,
-			psp->fence_buf_mc_addr);
-
-	if (!ret) {
-		psp->ras_context.context.session_id =3D cmd->resp.session_id;
-
-		if (!ras_cmd->ras_status)
-			psp->ras_context.context.initialized =3D true;
-		else
-			dev_warn(psp->adev->dev, "RAS Init Status: 0x%X\n", ras_cmd->ras_status=
);
-	}
-
-	release_psp_cmd_buf(psp);
-
-	if (ret || ras_cmd->ras_status)
-		amdgpu_ras_fini(psp->adev);
-
-	return ret;
+	return psp_ta_load(psp, &psp->ras, &psp->ras_context.context);
 }
=20
 static int psp_ras_unload(struct psp_context *psp) @@ -1458,6 +1415,7 @@ s=
tatic int psp_ras_initialize(struct psp_context *psp)
 	int ret;
 	uint32_t boot_cfg =3D 0xFF;
 	struct amdgpu_device *adev =3D psp->adev;
+	struct ta_ras_shared_memory *ras_cmd;
=20
 	/*
 	 * TODO: bypass the initialize in sriov for now @@ -1512,17 +1470,33 @@ s=
tatic int psp_ras_initialize(struct psp_context *psp)
 		}
 	}
=20
+	psp->ras_context.context.mem_context.shared_mem_size =3D=20
+PSP_RAS_SHARED_MEM_SIZE;
+
 	if (!psp->ras_context.context.initialized) {
 		ret =3D psp_ras_init_shared_buf(psp);
 		if (ret)
 			return ret;
 	}
=20
+	ras_cmd =3D (struct ta_ras_shared_memory *)psp->ras_context.context.mem_c=
ontext.shared_buf;
+	memset(ras_cmd, 0, sizeof(struct ta_ras_shared_memory));
+
+	if (psp->adev->gmc.xgmi.connected_to_cpu)
+		ras_cmd->ras_in_message.init_flags.poison_mode_en =3D 1;
+	else
+		ras_cmd->ras_in_message.init_flags.dgpu_mode =3D 1;
+
 	ret =3D psp_ras_load(psp);
-	if (ret)
-		return ret;
=20
-	return 0;
+	if (!ret && !ras_cmd->ras_status)
+		psp->ras_context.context.initialized =3D true;
+	else {
+		if (ras_cmd->ras_status)
+			dev_warn(psp->adev->dev, "RAS Init Status: 0x%X\n", ras_cmd->ras_status=
);
+		amdgpu_ras_fini(psp->adev);
+	}
+
+	return ret;
 }
=20
 int psp_ras_trigger_error(struct psp_context *psp, @@ -1556,43 +1530,12 @@=
 int psp_ras_trigger_error(struct psp_context *psp,  // HDCP start  static =
int psp_hdcp_init_shared_buf(struct psp_context *psp)  {
-	return psp_ta_init_shared_buf(psp, &psp->hdcp_context.context.mem_context=
,
-				      PSP_HDCP_SHARED_MEM_SIZE);
+	return psp_ta_init_shared_buf(psp,=20
+&psp->hdcp_context.context.mem_context);
 }
=20
 static int psp_hdcp_load(struct psp_context *psp)  {
-	int ret;
-	struct psp_gfx_cmd_resp *cmd;
-
-	/*
-	 * TODO: bypass the loading in sriov for now
-	 */
-	if (amdgpu_sriov_vf(psp->adev))
-		return 0;
-
-	psp_copy_fw(psp, psp->hdcp.start_addr,
-		    psp->hdcp.size_bytes);
-
-	cmd =3D acquire_psp_cmd_buf(psp);
-
-	psp_prep_ta_load_cmd_buf(cmd,
-				 psp->fw_pri_mc_addr,
-				 psp->hdcp.size_bytes,
-				 psp->hdcp_context.context.mem_context.shared_mc_addr,
-				 PSP_HDCP_SHARED_MEM_SIZE);
-
-	ret =3D psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
-
-	if (!ret) {
-		psp->hdcp_context.context.initialized =3D true;
-		psp->hdcp_context.context.session_id =3D cmd->resp.session_id;
-		mutex_init(&psp->hdcp_context.mutex);
-	}
-
-	release_psp_cmd_buf(psp);
-
-	return ret;
+	return psp_ta_load(psp, &psp->hdcp, &psp->hdcp_context.context);
 }
 static int psp_hdcp_initialize(struct psp_context *psp)  { @@ -1610,6 +155=
3,8 @@ static int psp_hdcp_initialize(struct psp_context *psp)
 		return 0;
 	}
=20
+	psp->hdcp_context.context.mem_context.shared_mem_size =3D=20
+PSP_HDCP_SHARED_MEM_SIZE;
+
 	if (!psp->hdcp_context.context.initialized) {
 		ret =3D psp_hdcp_init_shared_buf(psp);
 		if (ret)
@@ -1617,10 +1562,12 @@ static int psp_hdcp_initialize(struct psp_context *=
psp)
 	}
=20
 	ret =3D psp_hdcp_load(psp);
-	if (ret)
-		return ret;
+	if (!ret) {
+		psp->hdcp_context.context.initialized =3D true;
+		mutex_init(&psp->hdcp_context.mutex);
+	}
=20
-	return 0;
+	return ret;
 }
=20
 static int psp_hdcp_unload(struct psp_context *psp) @@ -1673,42 +1620,12 @=
@ static int psp_hdcp_terminate(struct psp_context *psp)  // DTM start  sta=
tic int psp_dtm_init_shared_buf(struct psp_context *psp)  {
-	return psp_ta_init_shared_buf(psp, &psp->dtm_context.context.mem_context,
-				      PSP_DTM_SHARED_MEM_SIZE);
+	return psp_ta_init_shared_buf(psp,=20
+&psp->dtm_context.context.mem_context);
 }
=20
 static int psp_dtm_load(struct psp_context *psp)  {
-	int ret;
-	struct psp_gfx_cmd_resp *cmd;
-
-	/*
-	 * TODO: bypass the loading in sriov for now
-	 */
-	if (amdgpu_sriov_vf(psp->adev))
-		return 0;
-
-	psp_copy_fw(psp, psp->dtm.start_addr, psp->dtm.size_bytes);
-
-	cmd =3D acquire_psp_cmd_buf(psp);
-
-	psp_prep_ta_load_cmd_buf(cmd,
-				 psp->fw_pri_mc_addr,
-				 psp->dtm.size_bytes,
-				 psp->dtm_context.context.mem_context.shared_mc_addr,
-				 PSP_DTM_SHARED_MEM_SIZE);
-
-	ret =3D psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
-
-	if (!ret) {
-		psp->dtm_context.context.initialized =3D true;
-		psp->dtm_context.context.session_id =3D cmd->resp.session_id;
-		mutex_init(&psp->dtm_context.mutex);
-	}
-
-	release_psp_cmd_buf(psp);
-
-	return ret;
+	return psp_ta_load(psp, &psp->dtm, &psp->dtm_context.context);
 }
=20
 static int psp_dtm_initialize(struct psp_context *psp) @@ -1727,6 +1644,8 =
@@ static int psp_dtm_initialize(struct psp_context *psp)
 		return 0;
 	}
=20
+	psp->dtm_context.context.mem_context.shared_mem_size =3D=20
+PSP_DTM_SHARED_MEM_SIZE;
+
 	if (!psp->dtm_context.context.initialized) {
 		ret =3D psp_dtm_init_shared_buf(psp);
 		if (ret)
@@ -1734,10 +1653,12 @@ static int psp_dtm_initialize(struct psp_context *p=
sp)
 	}
=20
 	ret =3D psp_dtm_load(psp);
-	if (ret)
-		return ret;
+	if (!ret) {
+		psp->dtm_context.context.initialized =3D true;
+		mutex_init(&psp->dtm_context.mutex);
+	}
=20
-	return 0;
+	return ret;
 }
=20
 static int psp_dtm_unload(struct psp_context *psp) @@ -1790,36 +1711,12 @@=
 static int psp_dtm_terminate(struct psp_context *psp)  // RAP start  stati=
c int psp_rap_init_shared_buf(struct psp_context *psp)  {
-	return psp_ta_init_shared_buf(psp, &psp->rap_context.context.mem_context,
-				      PSP_RAP_SHARED_MEM_SIZE);
+	return psp_ta_init_shared_buf(psp,=20
+&psp->rap_context.context.mem_context);
 }
=20
 static int psp_rap_load(struct psp_context *psp)  {
-	int ret;
-	struct psp_gfx_cmd_resp *cmd;
-
-	psp_copy_fw(psp, psp->rap.start_addr, psp->rap.size_bytes);
-
-	cmd =3D acquire_psp_cmd_buf(psp);
-
-	psp_prep_ta_load_cmd_buf(cmd,
-				 psp->fw_pri_mc_addr,
-				 psp->rap.size_bytes,
-				 psp->rap_context.context.mem_context.shared_mc_addr,
-				 PSP_RAP_SHARED_MEM_SIZE);
-
-	ret =3D psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
-
-	if (!ret) {
-		psp->rap_context.context.initialized =3D true;
-		psp->rap_context.context.session_id =3D cmd->resp.session_id;
-		mutex_init(&psp->rap_context.mutex);
-	}
-
-	release_psp_cmd_buf(psp);
-
-	return ret;
+	return psp_ta_load(psp, &psp->rap, &psp->rap_context.context);
 }
=20
 static int psp_rap_unload(struct psp_context *psp) @@ -1844,6 +1741,8 @@ s=
tatic int psp_rap_initialize(struct psp_context *psp)
 		return 0;
 	}
=20
+	psp->rap_context.context.mem_context.shared_mem_size =3D=20
+PSP_RAP_SHARED_MEM_SIZE;
+
 	if (!psp->rap_context.context.initialized) {
 		ret =3D psp_rap_init_shared_buf(psp);
 		if (ret)
@@ -1851,7 +1750,10 @@ static int psp_rap_initialize(struct psp_context *ps=
p)
 	}
=20
 	ret =3D psp_rap_load(psp);
-	if (ret)
+	if (!ret) {
+		psp->rap_context.context.initialized =3D true;
+		mutex_init(&psp->rap_context.mutex);
+	} else
 		return ret;
=20
 	ret =3D psp_rap_invoke(psp, TA_CMD_RAP__INITIALIZE, &status); @@ -1923,35=
 +1825,13 @@ int psp_rap_invoke(struct psp_context *psp, uint32_t ta_cmd_id=
, enum ta_rap_stat  static int psp_securedisplay_init_shared_buf(struct psp=
_context *psp)  {
 	return psp_ta_init_shared_buf(
-		psp, &psp->securedisplay_context.context.mem_context,
-		PSP_SECUREDISPLAY_SHARED_MEM_SIZE);
+		psp, &psp->securedisplay_context.context.mem_context);
 }
=20
 static int psp_securedisplay_load(struct psp_context *psp)  {
-	int ret;
-	struct psp_gfx_cmd_resp *cmd =3D acquire_psp_cmd_buf(psp);
-
-	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
-	memcpy(psp->fw_pri_buf, psp->securedisplay.start_addr, psp->securedisplay=
.size_bytes);
-
-	psp_prep_ta_load_cmd_buf(cmd,
-				 psp->fw_pri_mc_addr,
-				 psp->securedisplay.size_bytes,
-				 psp->securedisplay_context.context.mem_context.shared_mc_addr,
-				 PSP_SECUREDISPLAY_SHARED_MEM_SIZE);
-
-	ret =3D psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
-
-	if (!ret) {
-		psp->securedisplay_context.context.initialized =3D true;
-		psp->securedisplay_context.context.session_id =3D cmd->resp.session_id;
-		mutex_init(&psp->securedisplay_context.mutex);
-	}
-
-	release_psp_cmd_buf(psp);
-
-	return ret;
+	return psp_ta_load(psp, &psp->securedisplay,
+			   &psp->securedisplay_context.context);
 }
=20
 static int psp_securedisplay_unload(struct psp_context *psp) @@ -1976,6 +1=
856,9 @@ static int psp_securedisplay_initialize(struct psp_context *psp)
 		return 0;
 	}
=20
+	psp->securedisplay_context.context.mem_context.shared_mem_size =3D
+		PSP_SECUREDISPLAY_SHARED_MEM_SIZE;
+
 	if (!psp->securedisplay_context.context.initialized) {
 		ret =3D psp_securedisplay_init_shared_buf(psp);
 		if (ret)
@@ -1983,7 +1866,10 @@ static int psp_securedisplay_initialize(struct psp_c=
ontext *psp)
 	}
=20
 	ret =3D psp_securedisplay_load(psp);
-	if (ret)
+	if (!ret) {
+		psp->securedisplay_context.context.initialized =3D true;
+		mutex_init(&psp->securedisplay_context.mutex);
+	} else
 		return ret;
=20
 	psp_prep_securedisplay_cmd_buf(psp, &securedisplay_cmd, diff --git a/driv=
ers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp=
.h
index 8ef2d28af92aeb..cc09b9e911199a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -34,17 +34,19 @@
=20
 #define PSP_FENCE_BUFFER_SIZE	0x1000
 #define PSP_CMD_BUFFER_SIZE	0x1000
-#define PSP_XGMI_SHARED_MEM_SIZE 0x4000 -#define PSP_RAS_SHARED_MEM_SIZE 0=
x4000
 #define PSP_1_MEG		0x100000
 #define PSP_TMR_SIZE(adev)	((adev)->asic_type =3D=3D CHIP_ALDEBARAN ? 0x80=
0000 : 0x400000)
-#define PSP_HDCP_SHARED_MEM_SIZE	0x4000
-#define PSP_DTM_SHARED_MEM_SIZE	0x4000
-#define PSP_RAP_SHARED_MEM_SIZE	0x4000
-#define PSP_SECUREDISPLAY_SHARED_MEM_SIZE	0x4000
-#define PSP_SHARED_MEM_SIZE		0x4000
 #define PSP_FW_NAME_LEN		0x24
=20
+enum psp_shared_mem_size {
+	PSP_XGMI_SHARED_MEM_SIZE			=3D 0x4000,
+	PSP_RAS_SHARED_MEM_SIZE				=3D 0x4000,
+	PSP_HDCP_SHARED_MEM_SIZE			=3D 0x4000,
+	PSP_DTM_SHARED_MEM_SIZE				=3D 0x4000,
+	PSP_RAP_SHARED_MEM_SIZE				=3D 0x4000,
+	PSP_SECUREDISPLAY_SHARED_MEM_SIZE	=3D 0x4000,
+};
+
 struct psp_context;
 struct psp_xgmi_node_info;
 struct psp_xgmi_topology_info;
@@ -140,6 +142,7 @@ struct ta_mem_context {
 	struct amdgpu_bo		*shared_bo;
 	uint64_t		shared_mc_addr;
 	void			*shared_buf;
+	enum psp_shared_mem_size	shared_mem_size;
 };
=20
 struct ta_context {
--
2.17.1
