Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D2A6C4167B
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Dec 2023 04:30:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2CDE10E076;
	Mon, 11 Dec 2023 04:30:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D56FD10E076
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Dec 2023 04:30:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6EkHlhKKjfS1P+sMrh/1e1CbNa8Jxub9wHIoS7R2zWr/xpX2lFCzpzRYRljopVdTBOKzcpOUkWIkRDkChHQkLuH3G0NLYBH/1Ufb1hJgPmdhZOO6nv+RrgausyEEGf1UKBm2ftxnd5FhhOcGYqMXnkkFzZULPATW0cwbx+mzPylJ0snzd3kJuE94y3hhZ6iB84c7Ysna7DkInxFX4V0Ob0t0UMJOhPhMFd+I01nTmwWqvo8A+4Zpxb0gbqr4HTaINpZwVXiNgLzFL+Hrk1t+FPa850MKe9L6sJLjTnNxbFIdW/k3iAoX2S4vrU6116YydGYBnpABcDQSfLnfofIcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P22I+KYSb2hOriqiS/hOgMBV5gnPKHkiin8SSSpn2fo=;
 b=n8l48esVTJqgI4NVQzLyWidE3adMahB+PLwLFfLoqj7+gTKhHRaLt9O4RpA7sg1lO25BAkE/LelS6IWQ3Sk2yTOEgx04Ha5Y68DMx8uD4ORpho76d/NRnxBFxqk+n5Hm09315YfbU5YbcYYmQsw9jtjrMKTCtRLaVVA7Y8laGEYpxl2Cy9U/gxJJZD9Y1mi+HziW2PLLkgD/LXwvB4OYMruGq/Ncf+OWqpjyxJ328zLkz6HEC6M9EJ0oBdDV4kMg477Hw829rhAALxoEVJNFMAAC33pPjIvJ6mW3AGqu4J5U3h0o7sOJpMNcgy7+RnnhqOsPwpC8n0Q7ZtIX8b2HJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P22I+KYSb2hOriqiS/hOgMBV5gnPKHkiin8SSSpn2fo=;
 b=YimL60+Z5OY88nSfAEM1smhv2OUIPTTr9/ekPsoY3FEN4Hym1+1sAfOLVgEGKXWoMKp3aDwybhulaih+E1c5b0FA0JSPg2c1QwZDpFb9hR0asa+DjT8dUaK0mPtZYNwwXOEelgLeTtVqHB2YznpKqknB5qOLjGrmAfEV5MKuZP4=
Received: from BY5PR12MB4194.namprd12.prod.outlook.com (2603:10b6:a03:210::7)
 by IA0PR12MB7625.namprd12.prod.outlook.com (2603:10b6:208:439::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 04:29:57 +0000
Received: from BY5PR12MB4194.namprd12.prod.outlook.com
 ([fe80::d0a9:48b7:231a:f627]) by BY5PR12MB4194.namprd12.prod.outlook.com
 ([fe80::d0a9:48b7:231a:f627%5]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 04:29:56 +0000
From: "Wang, Beyond" <Wang.Beyond@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu: fix ftrace event amdgpu_bo_move always move
 on same heap
Thread-Topic: [PATCH 1/1] drm/amdgpu: fix ftrace event amdgpu_bo_move always
 move on same heap
Thread-Index: Ador6TE2cFR2D4XYTXS9O0BsI989ow==
Date: Mon, 11 Dec 2023 04:29:55 +0000
Message-ID: <BY5PR12MB41949AE4BD8E4178962FFDE5F78FA@BY5PR12MB4194.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5e85139c-74bc-496e-9f47-7446eda5afa0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-12-11T04:14:22Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4194:EE_|IA0PR12MB7625:EE_
x-ms-office365-filtering-correlation-id: ebc0d933-bd90-465e-c926-08dbfa01d37b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LO2WsDQwMJn3gz9qTwDXFeozxPekMdvY1I22wn+n6py+2mkiNGGXaezob2mTl9ZJKe+JgpQ3TcgKWDFuXrKdDoLcin4Ii2ETkKgTV+j4HSKGfqEDgIpyNP6QNczqOqtpXL4UFkaj4AXyVlmYpwRrRn+zECXmq4KruxLRo7nCDUjsUgnK4h++aSTyO01nPWpvQ5cRQR1xLBFWfdcPTcnNVwTzhQ8fHoILhW9dMfeeFW/zJwtvHYAqwvBYc6qWns1G6/Jjcwp/NA0aRoIEmuLnggL/3zLrWJZ2kC27tDmIH3Ni7uS9zoOTUnZTzxa+VPI7P3giSdX7PGM9RUW4/68witS9hNu6yJ715l1fmOitiqIYi6rSRLudY6MR6KX9MVpr6/omxxYnWhBOLncPLRaJQxfyf7sjJm9yo2HIKIq0oQ9mYO9F+qrn/FQoa2QW1ysm9qdtjFfj/CHOkKPHKgvhqjdeTpkd1EZw5aaUeBz4mS2w12FbypRPJiPnaCoK9acLuZzQHZloAOLpybdupx2zecSncsUpwdBqLgh/OzbzSiFtcbfSb/4Z7jaGymhw9FESfpuy/1BuyBoMkHsajctrOBo57CgNbRpVVP+1Kh5LOn/6qmNkTfxlSYGeu1m18GWL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4194.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(346002)(136003)(366004)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(2906002)(41300700001)(38100700002)(122000001)(33656002)(86362001)(9686003)(26005)(478600001)(71200400001)(6506007)(7696005)(83380400001)(4326008)(52536014)(5660300002)(316002)(6916009)(76116006)(66556008)(66476007)(66446008)(64756008)(66946007)(38070700009)(8936002)(8676002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vx03UcchxOw97XRtm1kexOuq/EuY76wPeQjOcdOPw7QTyD93UM5J+MZWcdGo?=
 =?us-ascii?Q?8qqTMAM/90AAmyMOAAGjCGwFncxncQ+MDkty0jrC6mScJA9mLSqU6vn6Wa0d?=
 =?us-ascii?Q?fwTnhqYCgCGfNh4+wIG3+CFHHK9N4jbHHdpKTsmK1BwDsXYKVBtn8GegeW2+?=
 =?us-ascii?Q?Zc5rSXsYpK0xrsDDpC90GJju80xF5kN6LKAqnZF/1ZQhO5oSw72uWD2QYeu3?=
 =?us-ascii?Q?lt372coKBvQeoW0GHOZV0jeL5tE/eTtSJdgUwatyvGw1KwHX6LCTeyuiuzc6?=
 =?us-ascii?Q?OIEU6bK4J7CkfmT/UzHD01uicrPdBR3TM2SQPsLP6bhWxfNWgSQ5BfEPJgE5?=
 =?us-ascii?Q?PS1VOBd4Y4eJz/0Np65z4J7gEAsktiwgSf1ZkOK0j1LKOKUqzVnqqj7WJdMy?=
 =?us-ascii?Q?ImFwRUSZWLsmj7qFp6A7g9yqHkS+zdeBV9g+2yKLMrI/32yQIoysycVUTIfh?=
 =?us-ascii?Q?eNMDupA0Ztdk0dryGws5rNTLrFerxqV4+/wBs5V9uKfJESfZTbczZ4n94PhQ?=
 =?us-ascii?Q?knl2KeEz9xKUUJ7G/swZkKrQrljwuN4FAKK+kRMjaCvuM3XCYCBBwsyjrlha?=
 =?us-ascii?Q?YPMsmZIQHhT/E+arIzJchfSrIyOCw7zHQQwzUTMtJU0F5za32apBq5tId9wS?=
 =?us-ascii?Q?332fbGFPIFaufLslm4054UfqMKE1ayttsNjXvWsdds4keL24JSJR7ywxgFB+?=
 =?us-ascii?Q?LGRI8Bx7n+OVlOJuNjJiyuENvxoBvD7ou5qNaaS98Cf/xwlra/D8W+StiwCm?=
 =?us-ascii?Q?PMCVhwTp+53AEQK9bOoJgrecGgyETEtiC0+n3uXrXg6WJcxSJ1YW8zUovgTp?=
 =?us-ascii?Q?7iKMi8Gph4qOm2xbDDx16wzTi8L/feQyo/5HReQuiAYHHDqd6Wojx1E3CKfV?=
 =?us-ascii?Q?Ql9JXkDGv9yyJXWhx5B9z11dAnXkiVkyTjoPiAMXOMTnBxbVnG+9GjnMuwLe?=
 =?us-ascii?Q?UsDabsRJKSyn5UA9zkmjt+kGyDFOxBEvgtn8i0j3v79lXOSRHTr5t2UQN/Px?=
 =?us-ascii?Q?ReGliffgqLDfFm/0Q+zXaXiAEHfCopZgbaT0unO4Z0I/+JItzlAnglHdxiGE?=
 =?us-ascii?Q?A2JgOfMsiwHKl+CDZ3WWpN9uuIwcUYPu66HdyPbtgaB4bUQ+xbEnKVn+qLT4?=
 =?us-ascii?Q?pMw2X+W/BSh2VQkSFWSMVDkW1dKIAYtytRlxqKsSVH3zT4toQOY6wa2D+4Ax?=
 =?us-ascii?Q?3eynqzpJ56YlGbXwDYUnRtJ23Yginn/lZBRtnIIZ9yII4ARpd/tamzmhApfF?=
 =?us-ascii?Q?JPJ4WQ+JHNxWPGHkewHNbq3k4eIRPD4qTjfL24G20Xz56cyEyJvPhPCny9hv?=
 =?us-ascii?Q?A6cWHQZM9JG4F4GlFWiNsroweydTwMAbP6aK7CUThG+cMuL5U12lyM6yKHSb?=
 =?us-ascii?Q?8bHvpJ52f/F/Egba9PvElUeWg/BaL/F573O/uWEhpD1qaHb0iJ9vpXnTwHJR?=
 =?us-ascii?Q?CiNgc/TfSngOBtiAH2fFT+YSWRXd70fsbD4Qy+CsG37a5BQ1Z4R97PeRUW93?=
 =?us-ascii?Q?Auw0yC5aen35EeXolFRAUvdkOpDc9cy9g+34DCLLFWipTxH5n3BD3RMruzQn?=
 =?us-ascii?Q?KKT1036FmSScOPnRYVA=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BY5PR12MB41949AE4BD8E4178962FFDE5F78FABY5PR12MB4194namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc0d933-bd90-465e-c926-08dbfa01d37b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2023 04:29:55.2882 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lkvtN7AiciaER7nRT801xZhOrUhDVRXZGreWE4QYg4+vW3cKhhnP2wUaaa5LYQEJrO7FSbwPSzqgE3Dl1JHvPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7625
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
Cc: "Jin, Jason\(Yong\)" <JasonYong.Jin@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BY5PR12MB41949AE4BD8E4178962FFDE5F78FABY5PR12MB4194namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Subject: [PATCH 1/1] drm/amdgpu: fix ftrace event amdgpu_bo_move always mov=
e on same heap

Issue: during evict or validate happened on amdgpu_bo, the 'from' and
'to' is always same in ftrace event of amdgpu_bo_move

where calling the 'trace_amdgpu_bo_move', the comment says move_notify
is called before move happens, but actually it is called after move
happens, here the new_mem is same as bo->resource

Fix: pass old_mem instead when calling amdgpu_bo_move_notify

Signed-off-by: Wang, Beyond Wang.Beyond@amd.com<mailto:Wang.Beyond@amd.com>
---
drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 10 +++++-----
drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  2 +-
drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  2 +-
3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c
index 7416799..0288495 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1282,7 +1282,7 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void=
 *buffer,
  * amdgpu_bo_move_notify - notification about a memory move
  * @bo: pointer to a buffer object
  * @evict: if this move is evicting the buffer from the graphics address s=
pace
- * @new_mem: new information of the bufer object
+ * @old_mem: old information of the buffer object
  *
  * Marks the corresponding &amdgpu_bo buffer object as invalid, also perfo=
rms
  * bookkeeping.
@@ -1290,11 +1290,11 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, vo=
id *buffer,
  */
void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
                           bool evict,
-                          struct ttm_resource *new_mem)
+                          struct ttm_resource *old_mem)
{
        struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->bdev);
        struct amdgpu_bo *abo;
-       struct ttm_resource *old_mem =3D bo->resource;
+       struct ttm_resource *new_mem =3D bo->resource;

        if (!amdgpu_bo_is_amdgpu_bo(bo))
                return;
@@ -1315,10 +1315,10 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object=
 *bo,
                atomic64_inc(&adev->num_evictions);

        /* update statistics */
-       if (!new_mem)
+       if (!old_mem || !new_mem)
                return;

-       /* move_notify is called before move happens */
+       /* move_notify is called after move happens in amdgpu_bo_move */
        trace_amdgpu_bo_move(abo, new_mem->mem_type, old_mem->mem_type);
}

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.h
index 876acde..88be4b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -362,7 +362,7 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *=
buffer,
                           uint64_t *flags);
void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
                           bool evict,
-                          struct ttm_resource *new_mem);
+                          struct ttm_resource *old_mem);
void amdgpu_bo_release_notify(struct ttm_buffer_object *bo);
vm_fault_t amdgpu_bo_fault_reserve_notify(struct ttm_buffer_object *bo);
void amdgpu_bo_fence(struct amdgpu_bo *bo, struct dma_fence *fence,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index 41ed6a3..8cc85d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -579,7 +579,7 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo,=
 bool evict,
out:
        /* update statistics */
        atomic64_add(bo->base.size, &adev->num_bytes_moved);
-       amdgpu_bo_move_notify(bo, evict, new_mem);
+       amdgpu_bo_move_notify(bo, evict, old_mem);
        return 0;
}

--
2.34.1

--_000_BY5PR12MB41949AE4BD8E4178962FFDE5F78FABY5PR12MB4194namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Subject: [PATCH 1/1] drm/amdgpu: fix ftrace event am=
dgpu_bo_move always move on same heap<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Issue: during evict or validate happened on amdgpu_b=
o, the 'from' and<o:p></o:p></p>
<p class=3D"MsoNormal">'to' is always same in ftrace event of amdgpu_bo_mov=
e<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">where calling the 'trace_amdgpu_bo_move', the commen=
t says move_notify<o:p></o:p></p>
<p class=3D"MsoNormal">is called before move happens, but actually it is ca=
lled after move<o:p></o:p></p>
<p class=3D"MsoNormal">happens, here the new_mem is same as bo-&gt;resource=
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Fix: pass old_mem instead when calling amdgpu_bo_mov=
e_notify<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Wang, Beyond <a href=3D"mailto:Wang.B=
eyond@amd.com">
Wang.Beyond@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 10 ++++=
+-----<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |&nbsp; 2=
 +-<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c&nbsp;&nbsp;&=
nbsp; |&nbsp; 2 +-<o:p></o:p></p>
<p class=3D"MsoNormal">3 files changed, 7 insertions(+), 7 deletions(-)<o:p=
></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_objec=
t.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 7416799..0288495 100644<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<o:p=
></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<o:p=
></o:p></p>
<p class=3D"MsoNormal">@@ -1282,7 +1282,7 @@ int amdgpu_bo_get_metadata(str=
uct amdgpu_bo *bo, void *buffer,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; * amdgpu_bo_move_notify - notification about =
a memory move<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; * @bo: pointer to a buffer object<o:p></o:p><=
/p>
<p class=3D"MsoNormal">&nbsp; * @evict: if this move is evicting the buffer=
 from the graphics address space<o:p></o:p></p>
<p class=3D"MsoNormal">- * @new_mem: new information of the bufer object<o:=
p></o:p></p>
<p class=3D"MsoNormal">+ * @old_mem: old information of the buffer object<o=
:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; *<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; * Marks the corresponding &amp;amdgpu_bo buff=
er object as invalid, also performs<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; * bookkeeping.<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -1290,11 +1290,11 @@ int amdgpu_bo_get_metadata(s=
truct amdgpu_bo *bo, void *buffer,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; */<o:p></o:p></p>
<p class=3D"MsoNormal">void amdgpu_bo_move_notify(struct ttm_buffer_object =
*bo,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool evict,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_resource *new_mem)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_resource *old_mem)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct am=
dgpu_device *adev =3D amdgpu_ttm_adev(bo-&gt;bdev);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct am=
dgpu_bo *abo;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_res=
ource *old_mem =3D bo-&gt;resource;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_res=
ource *new_mem =3D bo-&gt;resource;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdg=
pu_bo_is_amdgpu_bo(bo))<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -1315,10 +1315,10 @@ void amdgpu_bo_move_notify(s=
truct ttm_buffer_object *bo,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic64_inc(&amp;adev-&gt;num_evict=
ions);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* update=
 statistics */<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!new_mem)<=
o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!old_mem |=
| !new_mem)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* move_notify=
 is called before move happens */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* move_notify=
 is called after move happens in amdgpu_bo_move */<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_amd=
gpu_bo_move(abo, new_mem-&gt;mem_type, old_mem-&gt;mem_type);<o:p></o:p></p=
>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_objec=
t.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<o:p></o:p></p>
<p class=3D"MsoNormal">index 876acde..88be4b8 100644<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<o:p=
></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<o:p=
></o:p></p>
<p class=3D"MsoNormal">@@ -362,7 +362,7 @@ int amdgpu_bo_get_metadata(struc=
t amdgpu_bo *bo, void *buffer,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t *flags);<o:p></o:p></p>
<p class=3D"MsoNormal">void amdgpu_bo_move_notify(struct ttm_buffer_object =
*bo,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool evict,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_resource *new_mem);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_resource *old_mem);<o:p></o:p></p>
<p class=3D"MsoNormal">void amdgpu_bo_release_notify(struct ttm_buffer_obje=
ct *bo);<o:p></o:p></p>
<p class=3D"MsoNormal">vm_fault_t amdgpu_bo_fault_reserve_notify(struct ttm=
_buffer_object *bo);<o:p></o:p></p>
<p class=3D"MsoNormal">void amdgpu_bo_fence(struct amdgpu_bo *bo, struct dm=
a_fence *fence,<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c=
 b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 41ed6a3..8cc85d3 100644<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<o:p></=
o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<o:p></=
o:p></p>
<p class=3D"MsoNormal">@@ -579,7 +579,7 @@ static int amdgpu_bo_move(struct=
 ttm_buffer_object *bo, bool evict,<o:p></o:p></p>
<p class=3D"MsoNormal">out:<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* update=
 statistics */<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic64_=
add(bo-&gt;base.size, &amp;adev-&gt;num_bytes_moved);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_move=
_notify(bo, evict, new_mem);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_move=
_notify(bo, evict, old_mem);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;=
<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">--<o:p></o:p></p>
<p class=3D"MsoNormal">2.34.1<o:p></o:p></p>
</div>
</div>
</body>
</html>

--_000_BY5PR12MB41949AE4BD8E4178962FFDE5F78FABY5PR12MB4194namp_--
