Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A9BCF11D0
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Oct 2024 11:36:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 283D310E2B8;
	Thu, 10 Oct 2024 11:36:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i92pOwLY";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2079.outbound.protection.outlook.com [40.107.212.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24C5310E2B8
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Oct 2024 11:36:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o9+zNLxQVNAKGPKSWXq+vBTui7rMvHPZS9OWIeeTkCnFiDG0kmZ6NrUH77dGWXM2bF2Rw+Lr6qigIsLQ/3MQN1QFCtPSt6K9Yp5X0/XcpXZml6XTRU9WzZkQMbzlIYc5fyVdXigkT95LP5gauKMcc8FIxT9gK8pPoH6s1brnyqOT55dKFDqnCGRL6dv8VLerHBM+73Q/QtldLvgC4YA5BNFOQTYTab7OdsKFhJcTxpQq8naVw48ScDlDQgBFem0/8xzDcFGNZ+jPqZGv9Pao6yctr03xxuRua7vJDLcPJgh3SHpRLbAYWOlH+8gvO6G7iFJxLEErW5zzD7ugmZt++g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QfERqL3TWlTOiWiOqcPoDEWOIMAsVhClkkhp71AfvU=;
 b=jXDSID6dNJlnQpDfVqdNRrr7qMCPRu50p1Qo+2lVRqMBh1SQN7dZVOmiSC+Co8/ZZIeIacR/SoM715ENaZ1Yd4/6z8L4/fJipJCGXnAJFHeFWF7gE4z287agAT9NBqK4n9hxR9/c2XSYKTFwCrn/pXvdmC4Xt2cBGYyvKJDmw5KEDaS/lgbiubZFX/KpJ7lrOhnsD1hHHIqOfpfai4PCfOpPOUVXNCfQM+Hbsaq8LtZlY2UAdEMbwcVxj+fE/rN9TXD78ggBJ3r9Z6rAv6oQA4/f5nTaAoBdsOkr2ihS4hh4ZZzHaFi/sNacbjvwMGDFuL0bSez84/gmtM+M3Da6rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QfERqL3TWlTOiWiOqcPoDEWOIMAsVhClkkhp71AfvU=;
 b=i92pOwLYThkGxXRHHpR7z0r45qKy3DvOL9TKY0o7bV2Koz6mKyzcC/U6JhpXAIF8sRKk3zgKtMcD4RWt0ZtuN06XOnGOl9sLpDvaweyVmNKT5Lv61zCFFaK/KMOlAwDiPg3M7zhUdx70U/11DnvxLBMqTawIVuiT5IZsI+zJXYw=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by PH8PR12MB6940.namprd12.prod.outlook.com (2603:10b6:510:1bf::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 11:36:53 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%5]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 11:36:53 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: update the driver-fw interface file for smu
 v14.0.2/3
Thread-Topic: [PATCH] drm/amd/pm: update the driver-fw interface file for smu
 v14.0.2/3
Thread-Index: AQHbGvf0Fg/MOAMRNEutapcXD8Qq9LJ/2znw
Date: Thu, 10 Oct 2024 11:36:53 +0000
Message-ID: <PH7PR12MB5997DB55BD0DA7C0D6B76F3A82782@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20241010093651.2112363-1-kenneth.feng@amd.com>
In-Reply-To: <20241010093651.2112363-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=f22081aa-fcec-4598-9b30-4f50c5195ec4;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-10T11:36:01Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|PH8PR12MB6940:EE_
x-ms-office365-filtering-correlation-id: 2bef21ec-b730-4a8c-6caa-08dce91fd6b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?DZqGxX5DrrOSKEYEs+3/rfKNhMVId8k+Dp9PGFFREMJZQhBzeLo2v2QVl5iq?=
 =?us-ascii?Q?Eyw1ATuqcNSNX0Nf20XYQSiU5qMvj9NtMerEWnA0DMNzNn+wCQfhhcgBr+6k?=
 =?us-ascii?Q?KBkekxAvbMNHKgVhW8yCsHJW8HoW2PTs/NZiEaNDjuTJmhXt4HvU0NCNzhc2?=
 =?us-ascii?Q?mOCKY+2awL5Z52CXzF6GpoAMBBwf5pIV3Q418wknh1ngaFpSsU0D/+O3SGOC?=
 =?us-ascii?Q?g+83yInJ3EgWbKkroB5kaXgMXVh0JXuu+H/CXNdLg/3Tv20Cr9oJm8Rsuo8u?=
 =?us-ascii?Q?vXDm0A0431+2L/bzzaYLyL9zasYaHxSn5c4o2W5X2y8cMeX6acep9t/kNzkx?=
 =?us-ascii?Q?Oqq2DIOT6h/6dSICX546aYzm/Eue5qWDEGt2yM7XYUEPWFcwKGIFWhtppTj/?=
 =?us-ascii?Q?rHqA2ck+nDSF04OwTxa4cWMjGfmWUK8xMvTIA70hzSVxsIy0lyuWW1RLudpS?=
 =?us-ascii?Q?2JrzRmJ7ByUp1yEENiuTVW+1tuSWo5wQTn6wrHgAcz3kFxeS1ZwyCa08tdXy?=
 =?us-ascii?Q?sq1PyXh33M9ZaTKWuvTYWuGhzyyC/Dt+Q53ZJgXU4+k0pm+t9kSrgp5kVrex?=
 =?us-ascii?Q?ng4ezfT76TFKkJhyMypArhMrcWq2rW7zcAUJCv2mkxt1GjUjyMCAK2ZAnSeB?=
 =?us-ascii?Q?CUcoAGD6JgQ66AXPfpm54MIL2dGc0piUrYx9tpPeXKM7624hnXsjB+AYFazU?=
 =?us-ascii?Q?20HozLZ0ZIorsyIG2/URyjwoCBXAw+D8BDs1flqwrfTo+xHnoCYvwOENRjGe?=
 =?us-ascii?Q?qHH3fM5F/4ZskAVLbjONbeZq84fZ97Ldvg6PRgsK5GR3cZakTIL5XnawsfdY?=
 =?us-ascii?Q?r303Ljqx0vXOySTfsraFAcxwHoIkBKLV4kGs44qOKXVWnY7FHofpjTP2Y9h2?=
 =?us-ascii?Q?h7hkr5UqaAGhCKokZuOYOSLexoQNWjO5oL8vRgDuHZHIEy2jnvkd4Jmp/YB0?=
 =?us-ascii?Q?+ifklf/rXX7PQSm9pjHNkR91DqUe+1XfEKDNn64wOWKBSrVAxk8yyPG+rRoz?=
 =?us-ascii?Q?9ZFuJFHjy5uEoT4HaDS74YhqpuzztQ+xOHFBwWA5seGtJFhkjL+ZkQKuU5ON?=
 =?us-ascii?Q?RetY8zye2ekq6BQlN+nTJX1v5ogaGfIFnp9fJDkWp5C87WIT48VLKUryTrTb?=
 =?us-ascii?Q?DL2MZxKmrIN07JD2ocsRR5ouqP9aAvRSEtCddaahStTB7JMKHkcbQoBOZ5s+?=
 =?us-ascii?Q?ir099cDiawFDtHT0fJMAo7LR6ZXFefvskzTNMS9v0k8MZYuh5LS1wwFGTKiX?=
 =?us-ascii?Q?FI6mz1JVOYOzceTV62idUSepQdZNOBCR1jtyo94YEV8XJZ3st0Rv0RDuoEgx?=
 =?us-ascii?Q?M4ue98ph5m9eNm/Awi/DdaE7/1j5RvOk0nV/Zkf5zq1UYA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XVLfxga956paImNoJeSZZIrGMGoPnOeWcq2ezS0Mh1B1Ff+ZKPW1KlUGnE4v?=
 =?us-ascii?Q?g0MIICNTPHVAEGpQ5iPyWhjAb3vEKMBKcUP2zOZCqjT5GnU3P+mMJolzgH8C?=
 =?us-ascii?Q?ujPfJLcp5AGwaO40J6uHIrp2Osg/WBgnNWT4KutdaT5XwjpY++xT0y303ugj?=
 =?us-ascii?Q?bPnZfQMlYp7LZQ4avkuf/W0c1fnUhH+rP/8n88PL+3Wrr5sfgAYMpGRykzWl?=
 =?us-ascii?Q?pr6z+uMiK5EZfffECk1D9t2We/Hyd+0ZHfLebvWQ82QfPLfYMAG43ATUOFPe?=
 =?us-ascii?Q?xmwUHZtVAyXVHS82zJpi/Fx23cgyXVFGXaXQ4BSqKu1maJ3JQd3f7qL5mp69?=
 =?us-ascii?Q?oe21gHn8QBtlsK44mD5DkCBqTF/L+9/rLleXXtD597KM9jUCP3aTQkLukqYZ?=
 =?us-ascii?Q?BdnQ39NtjiRas941yvEW8HFp5w3AarWgENGeljpyFF/hh1wdGKRJ49qaiWE7?=
 =?us-ascii?Q?MJ9fKoMEkICmsVo/sLhGiSwkLuz4txv25SU0YGlsELQ8EIID7vT98nGG2cW2?=
 =?us-ascii?Q?8Jb5Vxyzjad4EU+fHxjNHJ+FSIJoaz/9RYV+NInDFJvQNw/wXdepDxPHYGAn?=
 =?us-ascii?Q?c5SYLa7x3gBrQyGiNTN8VL4oXsHa8+LAvI/I8XNgQM4MhN0c8tSgjr2zgw/Y?=
 =?us-ascii?Q?ubSIFYi3csrr+lvb9/4+H8yebMT5zr73TbrxpJWW3mJjvvE3A14Nw7innAuR?=
 =?us-ascii?Q?0denlLw5cMMJwew8RjZQ9lmqMbcYopf0XgsLwBDjt0T6K6GfsLtN9utCU1xp?=
 =?us-ascii?Q?vKBP4427Xo2mYhp22t97NVd33006LAfBsD3BtkvW6CBRyFhK0GbdPR29wnn/?=
 =?us-ascii?Q?jgh+shFTDtFUfMabu/o9xBL2Y3/x5K5kQk4Sf7B4cjzyGx7k4hgU+L+w8RaW?=
 =?us-ascii?Q?spd5ydABXsgJmhjDy5ZIR4DK0mkkT4zUE5iJ7OSEWDuvUMCQpC8ifSfoz2Q6?=
 =?us-ascii?Q?cqUmXA07mgu8c2naC03eA7r+yHBqBOmEXWKeY90Jm9045+J0TbHPL4loOXL0?=
 =?us-ascii?Q?AdLNzIBBJ9QiMVnzMsR3aJXP2odcg1LCJlzGQfBok647VuKegR3/R/PG+czc?=
 =?us-ascii?Q?VxubqXyC1kSvrot4msJNd1wzPEErVAURwqYH/CkAMLG8vQVn5pjA+oqnjDX/?=
 =?us-ascii?Q?jzwHp6eRWt6Y+jfExx0oM+d5Rhlc7MDR3cDFiVcDn1mSL2PRuXcToE8S13pP?=
 =?us-ascii?Q?Yc3794WSbMX1IRY1KB4jpSeX+r4q3+LBvJHcDKxC1kSguYKh91ZHFJZkGeMf?=
 =?us-ascii?Q?kIF3VuwJfTJJqfV7gKKEflPVlI4pIo0p0Us+Rtbr9eJRwZE7IInV5l1EVC3X?=
 =?us-ascii?Q?mK9eqdFsHWjVDfUy3mpZ8zI/BT5AdHMJTbU365kWIjUPp95/04jPbe+5uZOa?=
 =?us-ascii?Q?CNhM0rnhtc9Qsqtm9+w4bkSSMWq0TBNyYyjNElIFPvjLDpwHGoU486Bwj8Pq?=
 =?us-ascii?Q?R0+9BvQjQjYLK0qXyZIX5WXg8ssC2dtf6ywwYd/aqR6G/NWlZJuY52jhqxHO?=
 =?us-ascii?Q?vNH3m7X+TSC9JUYm3BtHFNj2axwctis9ztHa5WufKuJFPPFQgAI7QEY6a/uG?=
 =?us-ascii?Q?Wllc4TOPJIGjHVhxepU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bef21ec-b730-4a8c-6caa-08dce91fd6b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 11:36:53.5322 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dy09sTZmN4ZcRulJXgJ7eCqii5rl2w4paCgEobkruuGUG4q5tNKhzOSBVG/evZFH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6940
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: Kenneth Feng <kenneth.feng@amd.com>
Sent: Thursday, October 10, 2024 5:37 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Feng, Kenneth <Kenneth.Feng=
@amd.com>
Subject: [PATCH] drm/amd/pm: update the driver-fw interface file for smu v1=
4.0.2/3

update the driver-fw interface file for smu v14.0.2/3

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h | 132 +++++++++++-------
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h  |   2 +-
 2 files changed, 85 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0=
.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h
index ee457a6f0813..c2fd0a4a13e5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h
@@ -25,7 +25,7 @@
 #define SMU14_DRIVER_IF_V14_0_H

 //Increment this version if SkuTable_t or BoardTable_t change -#define PPT=
ABLE_VERSION 0x18
+#define PPTABLE_VERSION 0x1B

 #define NUM_GFXCLK_DPM_LEVELS    16
 #define NUM_SOCCLK_DPM_LEVELS    8
@@ -145,7 +145,7 @@ typedef enum {
 } FEATURE_BTC_e;

 // Debug Overrides Bitmask
-#define DEBUG_OVERRIDE_DISABLE_VOLT_LINK_VCN_FCLK      0x00000001
+#define DEBUG_OVERRIDE_NOT_USE                                    0x000000=
01
 #define DEBUG_OVERRIDE_DISABLE_VOLT_LINK_DCN_FCLK      0x00000002
 #define DEBUG_OVERRIDE_DISABLE_VOLT_LINK_MP0_FCLK      0x00000004
 #define DEBUG_OVERRIDE_DISABLE_VOLT_LINK_VCN_DCFCLK    0x00000008
@@ -161,6 +161,7 @@ typedef enum {
 #define DEBUG_OVERRIDE_ENABLE_SOC_VF_BRINGUP_MODE      0x00002000
 #define DEBUG_OVERRIDE_ENABLE_PER_WGP_RESIENCY         0x00004000
 #define DEBUG_OVERRIDE_DISABLE_MEMORY_VOLTAGE_SCALING  0x00008000
+#define DEBUG_OVERRIDE_DFLL_BTC_FCW_LOG                0x00010000

 // VR Mapping Bit Defines
 #define VR_MAPPING_VR_SELECT_MASK  0x01 @@ -391,6 +392,21 @@ typedef struc=
t {
   EccInfo_t  EccInfo[24];
 } EccInfoTable_t;

+#define EPCS_HIGH_POWER                  600
+#define EPCS_NORMAL_POWER                450
+#define EPCS_LOW_POWER                   300
+#define EPCS_SHORTED_POWER               150
+#define EPCS_NO_BOOTUP                   0
+
+typedef enum{
+  EPCS_SHORTED_LIMIT,
+  EPCS_LOW_POWER_LIMIT,
+  EPCS_NORMAL_POWER_LIMIT,
+  EPCS_HIGH_POWER_LIMIT,
+  EPCS_NOT_CONFIGURED,
+  EPCS_STATUS_COUNT,
+} EPCS_STATUS_e;
+
 //D3HOT sequences
 typedef enum {
   BACO_SEQUENCE,
@@ -662,7 +678,7 @@ typedef enum {
 } PP_GRTAVFS_FW_SEP_FUSE_e;

 #define PP_NUM_RTAVFS_PWL_ZONES 5
-
+#define PP_NUM_PSM_DIDT_PWL_ZONES 3

 // VBIOS or PPLIB configures telemetry slope and offset. Only slope expect=
ed to be set for SVI3  // Slope Q1.7, Offset Q1.2 @@ -746,10 +762,10 @@ typ=
edef struct {
   uint16_t               Padding;

   //Frequency changes
-  int16_t                GfxclkFmin;           // MHz
-  int16_t                GfxclkFmax;           // MHz
-  uint16_t               UclkFmin;             // MHz
-  uint16_t               UclkFmax;             // MHz
+  int16_t                GfxclkFoffset;
+  uint16_t               Padding1;
+  uint16_t               UclkFmin;
+  uint16_t               UclkFmax;
   uint16_t               FclkFmin;
   uint16_t               FclkFmax;

@@ -770,19 +786,23 @@ typedef struct {
   uint8_t                MaxOpTemp;

   uint8_t                AdvancedOdModeEnabled;
-  uint8_t                Padding1[3];
+  uint8_t                Padding2[3];

   uint16_t               GfxVoltageFullCtrlMode;
   uint16_t               SocVoltageFullCtrlMode;
   uint16_t               GfxclkFullCtrlMode;
   uint16_t               UclkFullCtrlMode;
   uint16_t               FclkFullCtrlMode;
-  uint16_t               Padding2;
+  uint16_t               Padding3;

   int16_t                GfxEdc;
   int16_t                GfxPccLimitControl;

-  uint32_t               Spare[10];
+  uint16_t               GfxclkFmaxVmax;
+  uint8_t                GfxclkFmaxVmaxTemperature;
+  uint8_t                Padding4[1];
+
+  uint32_t               Spare[9];
   uint32_t               MmHubPadding[8]; // SMU internal use. Adding here=
 instead of external as a workaround
 } OverDriveTable_t;

@@ -802,8 +822,8 @@ typedef struct {
   uint16_t               VddSocVmax;

   //gfxclk
-  int16_t                GfxclkFmin;           // MHz
-  int16_t                GfxclkFmax;           // MHz
+  int16_t                GfxclkFoffset;
+  uint16_t               Padding;
   //uclk
   uint16_t               UclkFmin;             // MHz
   uint16_t               UclkFmax;             // MHz
@@ -828,7 +848,7 @@ typedef struct {
   uint8_t                FanZeroRpmEnable;
   //temperature
   uint8_t                MaxOpTemp;
-  uint8_t                Padding[2];
+  uint8_t                Padding1[2];

   //Full Ctrl
   uint16_t               GfxVoltageFullCtrlMode;
@@ -839,7 +859,7 @@ typedef struct {
   //EDC
   int16_t                GfxEdc;
   int16_t                GfxPccLimitControl;
-  int16_t                Padding1;
+  int16_t                Padding2;

   uint32_t               Spare[5];
 } OverDriveLimits_t;
@@ -987,8 +1007,9 @@ typedef struct {
   uint16_t BaseClockDc;
   uint16_t GameClockDc;
   uint16_t BoostClockDc;
-
-  uint32_t Reserved[4];
+  uint16_t MaxReportedClock;
+  uint16_t Padding;
+  uint32_t Reserved[3];
 } DriverReportedClocks_t;

 typedef struct {
@@ -1132,7 +1153,7 @@ typedef struct {
   uint32_t      DcModeMaxFreq     [PPCLK_COUNT            ];     // In MHz

   uint16_t      GfxclkAibFmax;
-  uint16_t      GfxclkFreqCap;
+  uint16_t      GfxDpmPadding;

   //GFX Idle Power Settings
   uint16_t      GfxclkFgfxoffEntry;   // Entry in RLC stage (PLL), in Mhz
@@ -1172,8 +1193,7 @@ typedef struct {
   uint32_t        DvoFmaxLowScaler; //Unitless float

   // GFX DCS
-  uint16_t      DcsGfxOffVoltage;     //Voltage in mV(Q2) applied to VDDGF=
X when entering DCS GFXOFF phase
-  uint16_t      PaddingDcs;
+  uint32_t      PaddingDcs;

   uint16_t      DcsMinGfxOffTime;     //Minimum amount of time PMFW shuts =
GFX OFF as part of GFX DCS phase
   uint16_t      DcsMaxGfxOffTime;      //Maximum amount of time PMFW can s=
hut GFX OFF as part of GFX DCS phase at a stretch.
@@ -1205,8 +1225,7 @@ typedef struct {
   uint16_t      DalDcModeMaxUclkFreq;
   uint8_t       PaddingsMem[2];
   //FCLK Section
-  uint16_t      FclkDpmDisallowPstateFreq;  //Frequency which FW will targ=
et when indicated that display config cannot support P-state. Set to 0 use =
FW calculated value
-  uint16_t      PaddingFclk;
+  uint32_t      PaddingFclk;

   // Link DPM Settings
   uint8_t       PcieGenSpeed[NUM_LINK_LEVELS];           ///< 0:PciE-gen1 =
1:PciE-gen2 2:PciE-gen3 3:PciE-gen4 4:PciE-gen5
@@ -1215,12 +1234,19 @@ typedef struct {

   // SECTION: VDD_GFX AVFS
   uint8_t       OverrideGfxAvfsFuses;
-  uint8_t       GfxAvfsPadding[3];
+  uint8_t       GfxAvfsPadding[1];
+  uint16_t      DroopGBStDev;

   uint32_t      SocHwRtAvfsFuses[PP_GRTAVFS_HW_FUSE_COUNT];   //new added =
for Soc domain
   uint32_t      GfxL2HwRtAvfsFuses[PP_GRTAVFS_HW_FUSE_COUNT]; //see fusedo=
c for encoding
   //uint32_t      GfxSeHwRtAvfsFuses[PP_GRTAVFS_HW_FUSE_COUNT];
-  uint32_t      spare_HwRtAvfsFuses[PP_GRTAVFS_HW_FUSE_COUNT];
+
+  uint16_t      PsmDidt_Vcross[PP_NUM_PSM_DIDT_PWL_ZONES-1];
+  uint32_t      PsmDidt_StaticDroop_A[PP_NUM_PSM_DIDT_PWL_ZONES];
+  uint32_t      PsmDidt_StaticDroop_B[PP_NUM_PSM_DIDT_PWL_ZONES];
+  uint32_t      PsmDidt_DynDroop_A[PP_NUM_PSM_DIDT_PWL_ZONES];
+  uint32_t      PsmDidt_DynDroop_B[PP_NUM_PSM_DIDT_PWL_ZONES];
+  uint32_t      spare_HwRtAvfsFuses[19];

   uint32_t      SocCommonRtAvfs[PP_GRTAVFS_FW_COMMON_FUSE_COUNT];
   uint32_t      GfxCommonRtAvfs[PP_GRTAVFS_FW_COMMON_FUSE_COUNT];
@@ -1246,11 +1272,7 @@ typedef struct {
   uint32_t      dGbV_dT_vmin;
   uint32_t      dGbV_dT_vmax;

-  //Unused: PMFW-9370
-  uint32_t      V2F_vmin_range_low;
-  uint32_t      V2F_vmin_range_high;
-  uint32_t      V2F_vmax_range_low;
-  uint32_t      V2F_vmax_range_high;
+  uint32_t      PaddingV2F[4];

   AvfsDcBtcParams_t DcBtcGfxParams;
   QuadraticInt_t    SSCurve_GFX;
@@ -1327,18 +1349,18 @@ typedef struct {
   uint16_t        PsmDidtReleaseTimer;
   uint32_t        PsmDidtStallPattern; //Will be written to both pattern 1=
 and didt_static_level_prog
   // CAC EDC
-  uint32_t        Leakage_C0; // in IEEE float
-  uint32_t        Leakage_C1; // in IEEE float
-  uint32_t        Leakage_C2; // in IEEE float
-  uint32_t        Leakage_C3; // in IEEE float
-  uint32_t        Leakage_C4; // in IEEE float
-  uint32_t        Leakage_C5; // in IEEE float
-  uint32_t        GFX_CLK_SCALAR; // in IEEE float
-  uint32_t        GFX_CLK_INTERCEPT; // in IEEE float
-  uint32_t        GFX_CAC_M; // in IEEE float
-  uint32_t        GFX_CAC_B; // in IEEE float
-  uint32_t        VDD_GFX_CurrentLimitGuardband; // in IEEE float
-  uint32_t        DynToTotalCacScalar; // in IEEE
+  uint32_t        CacEdcCacLeakageC0;
+  uint32_t        CacEdcCacLeakageC1;
+  uint32_t        CacEdcCacLeakageC2;
+  uint32_t        CacEdcCacLeakageC3;
+  uint32_t        CacEdcCacLeakageC4;
+  uint32_t        CacEdcCacLeakageC5;
+  uint32_t        CacEdcGfxClkScalar;
+  uint32_t        CacEdcGfxClkIntercept;
+  uint32_t        CacEdcCac_m;
+  uint32_t        CacEdcCac_b;
+  uint32_t        CacEdcCurrLimitGuardband;
+  uint32_t        CacEdcDynToTotalCacRatio;
   // GFX EDC XVMIN
   uint32_t        XVmin_Gfx_EdcThreshScalar;
   uint32_t        XVmin_Gfx_EdcEnableFreq;
@@ -1467,7 +1489,7 @@ typedef struct {
   uint8_t      VddqOffEnabled;
   uint8_t      PaddingUmcFlags[2];

-  uint32_t    PostVoltageSetBacoDelay; // in microseconds. Amount of time =
FW will wait after power good is established or PSI0 command is issued
+  uint32_t    Paddign1;
   uint32_t    BacoEntryDelay; // in milliseconds. Amount of time FW will w=
ait to trigger BACO entry after receiving entry notification from OS

   uint8_t     FuseWritePowerMuxPresent;
@@ -1530,7 +1552,7 @@ typedef struct {
   int16_t     FuzzyFan_ErrorSetDelta;
   int16_t     FuzzyFan_ErrorRateSetDelta;
   int16_t     FuzzyFan_PwmSetDelta;
-  uint16_t    FuzzyFan_Reserved;
+  uint16_t    FanPadding2;

   uint16_t    FwCtfLimit[TEMP_COUNT];

@@ -1547,9 +1569,10 @@ typedef struct {
   uint16_t    FanSpare[1];
   uint8_t     FanIntakeSensorSupport;
   uint8_t     FanIntakePadding;
-  uint32_t    FanAmbientPerfBoostThreshold;
   uint32_t    FanSpare2[12];

+  uint32_t ODFeatureCtrlMask;
+
   uint16_t TemperatureLimit_Hynix; // In degrees Celsius. Memory temperatu=
re limit associated with Hynix
   uint16_t TemperatureLimit_Micron; // In degrees Celsius. Memory temperat=
ure limit associated with Micron
   uint16_t TemperatureFwCtfLimit_Hynix; @@ -1637,7 +1660,7 @@ typedef stru=
ct {
   uint16_t AverageDclk0Frequency  ;
   uint16_t AverageVclk1Frequency  ;
   uint16_t AverageDclk1Frequency  ;
-  uint16_t PCIeBusy               ;
+  uint16_t AveragePCIeBusy        ;
   uint16_t dGPU_W_MAX             ;
   uint16_t padding                ;

@@ -1665,12 +1688,12 @@ typedef struct {

   uint16_t AverageGfxActivity    ;
   uint16_t AverageUclkActivity   ;
-  uint16_t Vcn0ActivityPercentage  ;
+  uint16_t AverageVcn0ActivityPercentage;
   uint16_t Vcn1ActivityPercentage  ;

   uint32_t EnergyAccumulator;
   uint16_t AverageSocketPower;
-  uint16_t MovingAverageTotalBoardPower;
+  uint16_t AverageTotalBoardPower;

   uint16_t AvgTemperature[TEMP_COUNT];
   uint16_t AvgTemperatureFanIntake;
@@ -1684,7 +1707,8 @@ typedef struct {


   uint8_t  ThrottlingPercentage[THROTTLER_COUNT];
-  uint8_t  padding1[3];
+  uint8_t  VmaxThrottlingPercentage;
+  uint8_t  padding1[2];

   //metrics for D3hot entry/exit and driver ARM msgs
   uint32_t D3HotEntryCountPerMode[D3HOT_SEQUENCE_COUNT];
@@ -1693,7 +1717,7 @@ typedef struct {

   uint16_t ApuSTAPMSmartShiftLimit;
   uint16_t ApuSTAPMLimit;
-  uint16_t MovingAvgApuSocketPower;
+  uint16_t AvgApuSocketPower;

   uint16_t AverageUclkActivity_MAX;

@@ -1823,6 +1847,17 @@ typedef struct {
 #define TABLE_TRANSFER_FAILED     0xFF
 #define TABLE_TRANSFER_PENDING    0xAB

+#define TABLE_PPT_FAILED                          0x100
+#define TABLE_TDC_FAILED                          0x200
+#define TABLE_TEMP_FAILED                         0x400
+#define TABLE_FAN_TARGET_TEMP_FAILED              0x800
+#define TABLE_FAN_STOP_TEMP_FAILED               0x1000
+#define TABLE_FAN_START_TEMP_FAILED              0x2000
+#define TABLE_FAN_PWM_MIN_FAILED                 0x4000
+#define TABLE_ACOUSTIC_TARGET_RPM_FAILED         0x8000
+#define TABLE_ACOUSTIC_LIMIT_RPM_FAILED         0x10000
+#define TABLE_MGPU_ACOUSTIC_TARGET_RPM_FAILED   0x20000
+
 // Table types
 #define TABLE_PPTABLE            0
 #define TABLE_COMBO_PPTABLE           1
@@ -1849,5 +1884,6 @@ typedef struct {
 #define IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING  0x7
 #define IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL        0x8
 #define IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY        0x9
+#define IH_INTERRUPT_CONTEXT_ID_DYNAMIC_TABLE       0xA

 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_v14_0.h
index 46b456590a08..727d5b405435 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
@@ -28,7 +28,7 @@
 #define SMU14_DRIVER_IF_VERSION_INV 0xFFFFFFFF  #define SMU14_DRIVER_IF_VE=
RSION_SMU_V14_0_0 0x7  #define SMU14_DRIVER_IF_VERSION_SMU_V14_0_1 0x6 -#de=
fine SMU14_DRIVER_IF_VERSION_SMU_V14_0_2 0x26
+#define SMU14_DRIVER_IF_VERSION_SMU_V14_0_2 0x2E

 #define FEATURE_MASK(feature) (1ULL << feature)

--
2.34.1

