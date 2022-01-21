Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 098CCC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 20:35:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D44010E433;
	Fri, 21 Jan 2022 20:35:08 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59F0510E433
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jan 2022 20:35:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rd01eQpb99AjzFgFs2UGoDAoKdd87JvGIaxxoOu+yl2ysKi88OVkv5IpPhuvcXI7seoXK35Slw1COnVWNOSJtLfa0CdkunKvUQ1181scR1Y/xOQWJaQ3HNlwkkPM8PLLilkAuMitb5Xa6M0C6lQc4qdKWJJQxlJOjKyFDuk++qWKEfXgGsGAYDJK112o+bQyrXV3sdbHmxB+3kuDFkPwxXeW/s8ca7U9t+m0zIVfCA+GKJ1TJHXjY6D4gm03j4t3OXVzQGsCwkLq+yYmzNwvh2laT/13JBxx1EC2hxAfRsfPHGOAHb1RLxGSO6HCNdkGzT4w/0PU7w5WZbhqBAaMNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r61F/+3/dtKiLMVK4nCkYk1iPMHTOCmU7gcaQS7BLk0=;
 b=d29ypyITxQQh5MQ0SFFwtTuH59QpmJ31R+jr1UOH5IPAhH488qey/Z7P7eQ3BkBDs67bqrBeS7+UksV7yoCVWZxsa1MfrLpGmpwsbQ6tAcDJEGqfb3Ju19sBRDRwOE8j60sf5GVG39NPfd1H6inWPmxmsUHSf+e3WqF8ddf2V2HH6SGdlJAJo4D+e1ahy3xVQSX3l54Zlh7q9r4B9K8rg7/FG7tnoKtfe7oUzt7y1OGeCRsm0DCbXrLiT8nVjURFlNRi0IY8TbsoaZYiYMZ8ldVwFwxP7JxGhpf69FaqruPu8O+10YTFjTrNarRIuwWcSWpjpZo1iVFZuujxPqeR3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r61F/+3/dtKiLMVK4nCkYk1iPMHTOCmU7gcaQS7BLk0=;
 b=MnEQy8+OgdFM3A3cv9O9roqDBMZ6KrNfsChZYQY9E8zaugqaeM5ILnP7TPx/g9ayStU7MicFRNph+HyTSkNyoRKzoecYXds/fS+k5j8VFyptDpxp48pD+pWrnN+ryNyGQkDyJ8oNA9ex9u/BPzD0Phku95xsXS9SbVtDybQp06I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by BL0PR12MB5555.namprd12.prod.outlook.com (2603:10b6:208:1c2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Fri, 21 Jan
 2022 20:35:05 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089%8]) with mapi id 15.20.4909.010; Fri, 21 Jan 2022
 20:35:05 +0000
Message-ID: <146b13d5-f883-6aff-2f3a-0570d9041bf3@amd.com>
Date: Fri, 21 Jan 2022 21:34:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
Subject: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::20) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7dae922b-10a5-4469-4a45-08d9dd1d81d9
X-MS-TrafficTypeDiagnostic: BL0PR12MB5555:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB5555FAAE711C7288C996EF70F25B9@BL0PR12MB5555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:773;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SYleW7ZOZtoDaCWxwzHvs/o+QciNLIxzF04qmQ5JwbwtZU49c7T0hJhZiFyb6N1NjyITV/Z46X1tvc5NzZ/qh651KFGHXeKMTWZgjvCxIKkcXVEVi75/u6+GEBsBizd4ZjnkN8sx3Ef2rLF6YzyGE+v1/4iEMpyV2xGI87QmjwubeNUPBlhzuLlSKQqS/4VtKvpNASfJxQzZXxHbw6aG8WDSQl5X1gXOH+MjFlLoAlOpyjsstEw/4g8sYwrlkDcNffpRpuirCWMPvnXBW/X0aGOUr4sw2JI1fEBFEeDhDmLdKVjLvO/iX2RECzgWIGG6pRJYBpPDxHJCbq/W7JKRBhf5e0TllYmS9MsNZ9phgeZ2RF4K2/H17KW+NTwcSizra/Sf3IZxkpApw+hS71t1MHF+ePAnGJtV70kCeI1GeUrVWkNhIpBMG27ulEv/mKG4PagY8ll2csKU7fUjLr6d/NfezA4Ab142d56bld2jA8pADFflCOdhyqp3ngcr/rnM/UEH6SS1hOGKQpnUc0ldRPzUvMNbkDD5wY8XTFbAqd5JD/xM4ZSXGPZl+EWM7Z45kC3VefwVP7RH9Tqz49OyJlM8Mifzv4TgeKYx8Pc963Hq7a5XUAKZTqmsCLPd5lcmiYiQ9uCgYePprL/RB13nvgsut9CritWWm2zBObGn8wl2WHGtA0sw3YhsnEBlVWMb0wnAn//4XFF2SWDvIeXxsjTp9nhsXLKbuY+ZTOyH6ag=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(186003)(54906003)(31686004)(316002)(5660300002)(508600001)(26005)(6512007)(6666004)(66556008)(66476007)(66946007)(83380400001)(36756003)(8676002)(38100700002)(31696002)(2906002)(86362001)(53546011)(6486002)(6916009)(6506007)(2616005)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXpZa2kvWGx2NHIxRkhoM2QvNU01dURvbWUxd09BSmRXODhnMFpHUUo2ZjhB?=
 =?utf-8?B?Qk5BS0YzMEZaZ0NGWUFySDBQYWQwVmd4K0FjYytqeTFBZGl3UmhNWm9YSjBL?=
 =?utf-8?B?andlL3FsdHRvbFFzVis5eFJSb1RaanUvdW5sSlBCZFFKd1dDZndqeFdPS2Fu?=
 =?utf-8?B?WS9ObFR3dGhTWVpoeUhoYitxWk9KZklKeFZ1dXNObVNsZWEzZkpmcGM2MFVi?=
 =?utf-8?B?anlZWCsycUFpNHluSWp6RWczUHNUbjllN1N4RXBreWhub3NVNk5wV3o4UkxJ?=
 =?utf-8?B?OGVvR1ltUGczdVUxSmN2LzgyM25xbWx0NmRVbGFIVHVoeXgxZ20xdEhCZHQ5?=
 =?utf-8?B?ajBURHV3R3lEN25uVlBEWFd6aFJEVCtVM2RkVFlWdUx6cllOcGVDQ1A4S3FY?=
 =?utf-8?B?NEhPWGhmdERpa0hrRVZLUFVETExBTytZc2wveEp5Q3BRUnFDNzdhOVVobFJ3?=
 =?utf-8?B?b2JqN01kQUUxZVZMVWFBNUdnWTVFRG9vRFpBM0cyOHlsc1RWYTJQTSt6VW4y?=
 =?utf-8?B?ZWdBMDlaUUNweXY0NEdmMXR3Ylg0LzhBOUl4Ym5nenBDektmWUtYT1J6bWJx?=
 =?utf-8?B?SW9IUkRscGJGZzFaT0hTNW5xbjFzLzcvR1p3SVZYZUtIaVppRStiM0FlTFJJ?=
 =?utf-8?B?YUVLNm51eWd4cGtmUlZDTTdwK25ONDZobHorTTRTbGxRSFErSC9XMTUwOG55?=
 =?utf-8?B?Z0xMaldyVDFQZXU3QjJMK0J1OW9LWGM4UTU4OHlVWGM1TFUwZkV2ZERjdnZp?=
 =?utf-8?B?UkxvTEZmd2Q1KzArM2ZZRkd5TUdrVkxwSkRFMlRhOUlSTGZrOHp6ak9aQnFG?=
 =?utf-8?B?VjQrcHhablVYODAyVlpDNVB5cnlGV1RHM3RiN3FBRGRBdmdnVTNRUkU3dml3?=
 =?utf-8?B?OFk5MXhHZ0ZpSmZaYjRNcyt6dEJaRDR1YllCTVJWZFBUWGJidDhIRUt0TGM3?=
 =?utf-8?B?N0o0aVE4UjdIb1dRQ3NkOStqcVZRcnlZUGloUm9yT1NGdFY5empiV0ZGdWw2?=
 =?utf-8?B?OGhTOEc3YWR1QjZIMGRHbjlCWHNZTWlMMWhxcUpRSDJiU3ZyT2lSZ2R1N1Z2?=
 =?utf-8?B?d29DQzZZczRGZE45NmRrUE82MTlnRVdrc25OZlIyZHNnVmxFcDFmeVRYc2Zq?=
 =?utf-8?B?S2M3MGJRUEpkbTVna3VyQjB0eG5hU3MydlFGdTZYNDhXVXRZN093eGJLemwr?=
 =?utf-8?B?bkxrUUVXQjlxb1F0R0ExblpmeU5pbGN3VGZ0bnQ2OTQ2bVF1eXE3L21UWHRF?=
 =?utf-8?B?UVpHUXFrVXhvaGZLWE5sZmROWkZocXQrdWZvT2RQcTkyYWNhSzhSWGVydFQ5?=
 =?utf-8?B?L1lsc3JiSzdEakloWmZMdit2S2JQR00vZ2NVbFo4S005bWNOQWw4blVCT3cx?=
 =?utf-8?B?bmVuVm43MDlUMWthWGxoV0R5ZGxDdDJPcTdHYUg0dDVDcHhlSzdmd0lhdHBn?=
 =?utf-8?B?ZVJ3Vjd4SFZhODNkK3pkWldFWlRIS3pBQ2lRak05bjB1ODYwODZhbWdsN0RI?=
 =?utf-8?B?aVI2RUVubEc2WktyYm5Yc2ljend5WVFqcDFVVC91NzN3cDA3NzgvcTF5UDNq?=
 =?utf-8?B?eGJpZkE1bTNKMHpubnhDOVgxQnhaQWpXa3c0b0JOMlNNdGw0WGszNXhKNmdr?=
 =?utf-8?B?WVlGbnMzRkdMOGVBWDU4TDlXa0E1am1uSE93SDBTSjVDQ3k0ZktSTmtIMFJ0?=
 =?utf-8?B?TmZyaU1xU25GanRCMFJvaytRL0ZaSlVuUjFSQ1dIT29Lay9WV0RsaDBOUGdZ?=
 =?utf-8?B?bUdYYm1IT0Jkem5HRUUzZ2RHS3M3OGJuVDZ4WEhjUzlDd3MwM2RkdXdtV0J1?=
 =?utf-8?B?UGR1WHVaMzhPbG5lUi9vcnBFVDM1d2plaGIyWDczYkJGS1I4NW14Zm5mSjQr?=
 =?utf-8?B?WnhHa0RWTm9KcDFiNEtjT3FlSVpZQU1jcUpDZDlKZjFZQkU4TCtYRnNocUxN?=
 =?utf-8?B?c3J5TXRCaDIzNUtyRDdrUTJBRVZFZDQ3ODZzbG9kTDNJWDNadmFDalFIYTNl?=
 =?utf-8?B?SXE1b0NRVUdDYWtCUmNCUEhMUVFGNDFMTVp0VDJXT1NacGFmdC82ZWNCTHJF?=
 =?utf-8?B?TTdDY3hUL0NtVkxxcGY4L3pxb3Jya28vNkgvZ2REK2dWZVJ4Z2swZTh0Z3RI?=
 =?utf-8?B?UEdwbEFOb3g3K0srcW5QUGNka2RyT0M4SVdMT3N4blNIY1hTMGY3WU9vaXJS?=
 =?utf-8?Q?VsgVjGFI6nQYAGR1ta2/gdg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dae922b-10a5-4469-4a45-08d9dd1d81d9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 20:35:05.5051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fpZbxjEqGdwk7AuCPRVHjljSDm7FxK4MR1u6ukJQBjoVH8+Ly17Z0UV0nNnmXz1C+BejMaXKhscXuOGxISHtVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5555
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

 From 899ec6060eb7d8a3d4d56ab439e4e6cdd74190a4 Mon Sep 17 00:00:00 2001
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
Date: Fri, 21 Jan 2022 14:19:42 +0530
Subject: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler

This patch adds a GPU reset handler for Navi ASIC family, which
typically dumps some of the registersand sends a trace event.

V2: Accomodated call to work function to send uevent

Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
  drivers/gpu/drm/amd/amdgpu/nv.c | 28 ++++++++++++++++++++++++++++
  1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c 
b/drivers/gpu/drm/amd/amdgpu/nv.c
index 01efda4398e5..ada35d4c5245 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -528,10 +528,38 @@ nv_asic_reset_method(struct amdgpu_device *adev)
  	}
  }

+static void amdgpu_reset_dumps(struct amdgpu_device *adev)
+{
+	int r = 0, i;
+
+	/* original raven doesn't have full asic reset */
+	if ((adev->apu_flags & AMD_APU_IS_RAVEN) &&
+		!(adev->apu_flags & AMD_APU_IS_RAVEN2))
+		return;
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (!adev->ip_blocks[i].status.valid)
+			continue;
+		if (!adev->ip_blocks[i].version->funcs->reset_reg_dumps)
+			continue;
+		r = adev->ip_blocks[i].version->funcs->reset_reg_dumps(adev);
+
+		if (r)
+			DRM_ERROR("reset_reg_dumps of IP block <%s> failed %d\n",
+					adev->ip_blocks[i].version->funcs->name, r);
+	}
+
+	/* Schedule work to send uevent */
+	if (!queue_work(system_unbound_wq, &adev->gpu_reset_work))
+		DRM_ERROR("failed to add GPU reset work\n");
+
+	dump_stack();
+}
+
  static int nv_asic_reset(struct amdgpu_device *adev)
  {
  	int ret = 0;

+	amdgpu_reset_dumps(adev);
  	switch (nv_asic_reset_method(adev)) {
  	case AMD_RESET_METHOD_PCI:
  		dev_info(adev->dev, "PCI reset\n");
-- 
2.32.0

