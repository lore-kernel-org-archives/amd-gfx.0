Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D6DAC43334
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jun 2022 17:25:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32F9D112893;
	Wed,  8 Jun 2022 17:25:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95928112797
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jun 2022 17:25:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n42ishQ2HCF6Qs5t9NocZoPVnQOWxsJ6U+6MVlCXDppJvFXAHpFz+e5WYr+o9vCW5t2Ct2n3niOQi6FARo3Hy4F59KxVQOqdCl6XtWTOP68HlPTQ3zygtl0w4Bzzz+KR7IRQNzSdN3zmgKxfz6Y4LugkqkJRVRMxelgpYkNVZodf1yb4PSw1n+prx9zGtTsSKGCl4vYtNZ78jzYS/lzAnki3HMMHHNtMZM7ItiOAMWJ0WDRBtfOqIt38u5+6Nyan8BdnU12HVCNdcavbLWlp6TOjynt1iFfuSJ4sRH+d4KNtzuM0nAJ98kjvBbGvtAEdqjUkLUImFfbl+Vp1W4WO0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vvLYGe6uBjLY9zHjU2zawaRX2SAx9nEeySg7Vl8F1Y=;
 b=WsEcLjlDJM4F9xXOP+RBmG3vzZATa7Ga+uQg4T6yGi1gGw3ROT/qEy04IIZyM/2WcCn14CLDxYTBgJaTej7e395lWNgp9GmXq+95s+qkmx/xyZGv382K82m2j2sMDN7z2MQPPbBhiddCbJANUXh0rpuZsB+PhmQEJcsXbi2cIp0JwX9SKsoaL3hkQ/enm5d1hCfiAk1WuXYmk0G6oUcPM+RvI5+oF6KrrlGZYLTdqigwR/BQgPJ/b7UIZwQsEZIWGOdYDXnbeExL0Xq/Zbx/EMlXH8sUcQd03q0qKq1Y19ZKZyM49WgiKfxEh0cvgTM2Dns6Y5QgeDWYZPrXsae2mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vvLYGe6uBjLY9zHjU2zawaRX2SAx9nEeySg7Vl8F1Y=;
 b=aetCwm8kwo5GddS4sElkokWXBVDtsYrVvAILXgGxcj1qBKgeHRdRS2wK4/yAQR/JW8SYaZWGtkiqdvojVKSYPjE6qBZ3nTAa6UVnMGw15DU64TA4pgUeg6IAjbvchDT79CAHtpQiwJ3uaGuWARX2700ksurfo8HLbCGTOESJcJ8=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by BL1PR12MB5921.namprd12.prod.outlook.com (2603:10b6:208:398::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Wed, 8 Jun
 2022 17:25:03 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::71bf:7a78:d4dd:4d94]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::71bf:7a78:d4dd:4d94%9]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 17:25:03 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: Use pre-allocated temp struct for
 bounding box update
Thread-Topic: [PATCH] drm/amd/display: Use pre-allocated temp struct for
 bounding box update
Thread-Index: AQHYe1e0WsdEXxIhCUqD0dldr8XqLa1FwfqO
Date: Wed, 8 Jun 2022 17:25:03 +0000
Message-ID: <CH0PR12MB5284B33BD8FA4AB237FC1D668BA49@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <20220608164856.1870594-1-sunpeng.li@amd.com>
In-Reply-To: <20220608164856.1870594-1-sunpeng.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-08T17:25:02.805Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e0a686e-b262-4317-4f74-08da4973d2ce
x-ms-traffictypediagnostic: BL1PR12MB5921:EE_
x-microsoft-antispam-prvs: <BL1PR12MB5921F87B02A454A548D11E768BA49@BL1PR12MB5921.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ssMfL5NK0kcdHN3ehzrBaSmfOJHd/DhfCQREL5V7viZNLwQPoboLFGWfVBzY0dIwjcYe7VGJkfRi+U1GEo0R1v+K+F6AlaxQKmtaS08sFyNUxByhlSfoSgXs4Ma8VUAovLe/JwM33L2+Md/oWezlM+2jsqSyf1i+fVNPH2k96zKprUi6ngvzlAAgrG6q0lHEqF4k/iahZVTHlwa/ALf0Bx5fGReFja/fL9Edei1UfFFYHpMOA8GNMnxwy+Erlvsv3SF1V+voNCE242QenILX3B04ookA7BxuPAGI8kkk8JzxtrNPQY79HVLmTKTcTsTONFmqb8EF8tE0f5Ytrxh7MXwN6hUvjhYt7ECZoEBPj6ZHZpwMy+21w4VvYBQHGMlRXT+AGKEyA8UMy2ARodBYDXX5A+wacCbsVBudB0kM/mK7y5ENyQPoWFQyQLjKgIwpbqmZmPxhCF5zDe0ji85uRwpuMhFX1wOuuCeQkWPoBCccuh2wm+ZmYSdkWVwt9CMQMhMDgNWl5Gz8JTgzT9drLLjPxNmMIgVvfkd7Jfap/M1+iauYUH57cssANy27xkbvlPhDWdK5BVOxIEHCHJ0lg+z4Iu1+cpmAS5VXgWtotjfvLUkdfmMSRgc/Njzqx6oT9rLPqPB7wkIoVv4uaHesi0CijEMPEV+e7lXR/SstS+nqkFPREjpspVld3icE5SW3GkU51MyNuYgyr7q2e27T/Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(19627405001)(26005)(186003)(9686003)(83380400001)(66446008)(53546011)(33656002)(6506007)(7696005)(316002)(8676002)(91956017)(4326008)(64756008)(66946007)(66476007)(76116006)(110136005)(66556008)(54906003)(5660300002)(52536014)(55016003)(8936002)(508600001)(38070700005)(38100700002)(71200400001)(30864003)(86362001)(122000001)(15650500001)(2906002)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fSmqybq7ASA3sfg28qgVzn8do6yz0uvT0cTbI0FEqz2w7ry1ehNKzsFPuNvH?=
 =?us-ascii?Q?TvTQYwMQtWcKKfPHVIMGxwxPuoU4l+PLu+WfYNPepDrWKJDbvlaFp5g9QhWJ?=
 =?us-ascii?Q?fx1yYvAJ2sGSjBhF2Z2O0CqSFsgIW1nYc+G5QYqs2I8bC8ZMBuK9a0HcJVdT?=
 =?us-ascii?Q?GvFa8fWKBoMgkyarWZ0gTud62gxaeiecwYIZK5v/MDmEKPFxUQnR9ppS/5G3?=
 =?us-ascii?Q?2Tb6T20VgwNjLmT7H05tjlmViDdHFEwwPrMnSfzi4sc3wAwxvds/sIbtIHYf?=
 =?us-ascii?Q?tN4S0umm++mnGywFbwEvksIYRTQlm3NmAtaBXYssNFxsKu3sMtSOSIbqrm1a?=
 =?us-ascii?Q?lLzkJKil8wfSpwfTWC6a6lZLBoayIU8Q6a8j5ViERvzo4GM6dSncySHa/cw+?=
 =?us-ascii?Q?ZzOG3mqrDl0lCKc3J1s63+kkQMyLcd/R4MEw5vg9YY4hmWqoDKhiOUG9IjEA?=
 =?us-ascii?Q?IiKuflecegdH4tIPBeb1eWoHeT6K+bGMHNX411Wqf845RMKS8v2RLHh1dK7G?=
 =?us-ascii?Q?iMrvMPtTPRqHNLOlbTjdFjqTIF5wbkM9xy4ker3i9wguBKqLxiGx+n/Ba1jw?=
 =?us-ascii?Q?zVXg3pOCKhAoHpqEiZ+bF9QNa2fTSpArCuiYf5SCZtlPfuyZBcFfMaNEGeH8?=
 =?us-ascii?Q?MHGcTpK7K8Jn/KNQ4w3p0Ebw5Sjy87cHGGGaIJb4Ebed0sWtNC7jk0tLSuL8?=
 =?us-ascii?Q?8CZ+PGQx+Avsi26ylgG7I5T0XJrX9wZgPwPcrz0oBFF0HlGIofvr4KNaTA02?=
 =?us-ascii?Q?6YgX5U+QLAwZsz7a50NcgHzVFsYDb7YjXNUP1Jy5sNgxDrkxxkqDL/WaxdzL?=
 =?us-ascii?Q?nhT2ZoGWRa8OK5/SRx1zXYHUBbMn3JYkcI3dlLjT/DVIaLL/yJnPhJd4+DJn?=
 =?us-ascii?Q?7ZqO8ALg057rtaUnJjSUtYzJrxjoQnzealUphrqOTLL5FMDEyG8f/lRl485k?=
 =?us-ascii?Q?5cgE9Zlf4hbqmLvUw5t7NgIp//aB0dr1NVJhvoKo6V/loFrbrV+aHccPGO1m?=
 =?us-ascii?Q?2GOPEzw7fRP1iBDzXA0B65Q8PzgETkJpY3GnSZGSiPkH639OHy+6bcHnncrf?=
 =?us-ascii?Q?T/jtizChCenhgvaknM8hsYU02Ei8IfcF8VN2bppeYRlr7xFNvBcbQEnVcC1j?=
 =?us-ascii?Q?8XyniYnIkhPiiNeDbGtTS+ZEOgnf+xd2D+tBP+QYGM1cPYiY8znow4Ql5pMq?=
 =?us-ascii?Q?wvus2c0dVhIH0idHlcbE16PrVkTRclViUGtuCygPq0IDzY165tbKk37yGhkR?=
 =?us-ascii?Q?4gLkwNwm1HNOvv0hap7DfTK8HF2AiH7OF5YuzWPQvRGYMU6vC8k+qSB62Doj?=
 =?us-ascii?Q?AV5GzRcRZBszGsetLsl1bk9y1+cVPhG4xDg41/wBePYrzpj5Pb5EuvK23WV3?=
 =?us-ascii?Q?soBtq/Gn4mUQyJWIdat4Hobs92aik1ILkBmS2Wh2LOtujIA9OuZmm1fMnzbi?=
 =?us-ascii?Q?kArf7BAR4TtmhLdn/zqtOp7AmMkiksnIPehiZxsK7AGVOWXmKPWEqnKwneqg?=
 =?us-ascii?Q?W6kzkzze9vVuyuhjUljnmzsfUA/pBjwr4WFBHr5m0hIYIxcUbs2yWbBuelIW?=
 =?us-ascii?Q?VO4CaefmRYMoJL1KCDBY5N4AwWkzE0jj678OGRD6E7X7rZZvNu3i7/n9uCbb?=
 =?us-ascii?Q?+7vicg+q+2BEipjsdjJMpITKghg4EbZUfCmCTPx+zAyBYWwnXfqMXS5PTRpV?=
 =?us-ascii?Q?4HEDCWq8GlxBVZTtddNzxuGNqH6Uo7tQnleY+ePsHV42SLxJ?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB5284B33BD8FA4AB237FC1D668BA49CH0PR12MB5284namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0a686e-b262-4317-4f74-08da4973d2ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 17:25:03.2680 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JNYLd5wLPdzIBQH5WS0050qydxKZUqTcou0hbNimeTH8+WaHTrN5q0Yv/UsbfGD6U08811MpqOYINVdMpEnqnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5921
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
Cc: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CH0PR12MB5284B33BD8FA4AB237FC1D668BA49CH0PR12MB5284namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Isnt it cleaner to revert the original patch which removed the temporary va=
riable and then instead allocate the clock_limits array on heap, and later =
freed at the end of the function?

--

Regards,
Jay
________________________________
From: Li, Sun peng (Leo) <Sunpeng.Li@amd.com>
Sent: Wednesday, June 8, 2022 12:48 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Pillai, Aurabindo <Aurabindo.=
Pillai@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Li, Sun peng=
 (Leo) <Sunpeng.Li@amd.com>
Subject: [PATCH] drm/amd/display: Use pre-allocated temp struct for boundin=
g box update

From: Leo Li <sunpeng.li@amd.com>

[Why]

There is a theoretical problem in prior patches for reducing the stack
size of *update_bw_bounding_box() functions.

By modifying the soc.clock_limits[n] struct directly, this can cause
unintended behavior as the for loop attempts to swap rows in
clock_limits[n]. A temporary struct is still required to make sure we
stay functinoally equivalent.

[How]

Add a temporary clock_limits table to the SOC struct, and use it when
swapping rows.

Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  | 33 +++++-----
 .../amd/display/dc/dml/dcn301/dcn301_fpu.c    | 36 ++++++-----
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  | 64 +++++++++++--------
 .../amd/display/dc/dml/display_mode_structs.h |  5 ++
 4 files changed, 82 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers=
/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index c2fec0d85da4..e247b2270b1d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -2015,9 +2015,8 @@ void dcn21_update_bw_bounding_box(struct dc *dc, stru=
ct clk_bw_params *bw_params

         ASSERT(clk_table->num_entries);
         /* Copy dcn2_1_soc.clock_limits to clock_limits to avoid copying o=
ver null states later */
-       for (i =3D 0; i < dcn2_1_soc.num_states + 1; i++) {
-               dcn2_1_soc.clock_limits[i] =3D dcn2_1_soc.clock_limits[i];
-       }
+       memcpy(&dcn2_1_soc._clock_tmp, &dcn2_1_soc.clock_limits,
+              sizeof(dcn2_1_soc.clock_limits));

         for (i =3D 0; i < clk_table->num_entries; i++) {
                 /* loop backwards*/
@@ -2032,22 +2031,26 @@ void dcn21_update_bw_bounding_box(struct dc *dc, st=
ruct clk_bw_params *bw_params
                 if (i =3D=3D 1)
                         k++;

-               dcn2_1_soc.clock_limits[k].state =3D k;
-               dcn2_1_soc.clock_limits[k].dcfclk_mhz =3D clk_table->entrie=
s[i].dcfclk_mhz;
-               dcn2_1_soc.clock_limits[k].fabricclk_mhz =3D clk_table->ent=
ries[i].fclk_mhz;
-               dcn2_1_soc.clock_limits[k].socclk_mhz =3D clk_table->entrie=
s[i].socclk_mhz;
-               dcn2_1_soc.clock_limits[k].dram_speed_mts =3D clk_table->en=
tries[i].memclk_mhz * 2;
+               dcn2_1_soc._clock_tmp[k].state =3D k;
+               dcn2_1_soc._clock_tmp[k].dcfclk_mhz =3D clk_table->entries[=
i].dcfclk_mhz;
+               dcn2_1_soc._clock_tmp[k].fabricclk_mhz =3D clk_table->entri=
es[i].fclk_mhz;
+               dcn2_1_soc._clock_tmp[k].socclk_mhz =3D clk_table->entries[=
i].socclk_mhz;
+               dcn2_1_soc._clock_tmp[k].dram_speed_mts =3D clk_table->entr=
ies[i].memclk_mhz * 2;

-               dcn2_1_soc.clock_limits[k].dispclk_mhz =3D dcn2_1_soc.clock=
_limits[closest_clk_lvl].dispclk_mhz;
-               dcn2_1_soc.clock_limits[k].dppclk_mhz =3D dcn2_1_soc.clock_=
limits[closest_clk_lvl].dppclk_mhz;
-               dcn2_1_soc.clock_limits[k].dram_bw_per_chan_gbps =3D dcn2_1=
_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
-               dcn2_1_soc.clock_limits[k].dscclk_mhz =3D dcn2_1_soc.clock_=
limits[closest_clk_lvl].dscclk_mhz;
-               dcn2_1_soc.clock_limits[k].dtbclk_mhz =3D dcn2_1_soc.clock_=
limits[closest_clk_lvl].dtbclk_mhz;
-               dcn2_1_soc.clock_limits[k].phyclk_d18_mhz =3D dcn2_1_soc.cl=
ock_limits[closest_clk_lvl].phyclk_d18_mhz;
-               dcn2_1_soc.clock_limits[k].phyclk_mhz =3D dcn2_1_soc.clock_=
limits[closest_clk_lvl].phyclk_mhz;
+               dcn2_1_soc._clock_tmp[k].dispclk_mhz =3D dcn2_1_soc.clock_l=
imits[closest_clk_lvl].dispclk_mhz;
+               dcn2_1_soc._clock_tmp[k].dppclk_mhz =3D dcn2_1_soc.clock_li=
mits[closest_clk_lvl].dppclk_mhz;
+               dcn2_1_soc._clock_tmp[k].dram_bw_per_chan_gbps =3D dcn2_1_s=
oc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
+               dcn2_1_soc._clock_tmp[k].dscclk_mhz =3D dcn2_1_soc.clock_li=
mits[closest_clk_lvl].dscclk_mhz;
+               dcn2_1_soc._clock_tmp[k].dtbclk_mhz =3D dcn2_1_soc.clock_li=
mits[closest_clk_lvl].dtbclk_mhz;
+               dcn2_1_soc._clock_tmp[k].phyclk_d18_mhz =3D dcn2_1_soc.cloc=
k_limits[closest_clk_lvl].phyclk_d18_mhz;
+               dcn2_1_soc._clock_tmp[k].phyclk_mhz =3D dcn2_1_soc.clock_li=
mits[closest_clk_lvl].phyclk_mhz;

                 k++;
         }
+
+       memcpy(&dcn2_1_soc.clock_limits, &dcn2_1_soc._clock_tmp,
+              sizeof(dcn2_1_soc.clock_limits));
+
         if (clk_table->num_entries) {
                 dcn2_1_soc.num_states =3D clk_table->num_entries + 1;
                 /* fill in min DF PState */
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c b/drive=
rs/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
index 62cf283d9f41..e4863f0bf0f6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
@@ -254,6 +254,9 @@ void dcn301_update_bw_bounding_box(struct dc *dc, struc=
t clk_bw_params *bw_param

         dc_assert_fp_enabled();

+       memcpy(&dcn3_01_soc._clock_tmp, &dcn3_01_soc.clock_limits,
+              sizeof(dcn3_01_soc.clock_limits));
+
         /* Default clock levels are used for diags, which may lead to over=
clocking. */
         if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
                 dcn3_01_ip.max_num_otg =3D pool->base.res_cap->num_timing_=
generator;
@@ -270,29 +273,32 @@ void dcn301_update_bw_bounding_box(struct dc *dc, str=
uct clk_bw_params *bw_param
                                 }
                         }

-                       dcn3_01_soc.clock_limits[i].state =3D i;
-                       dcn3_01_soc.clock_limits[i].dcfclk_mhz =3D clk_tabl=
e->entries[i].dcfclk_mhz;
-                       dcn3_01_soc.clock_limits[i].fabricclk_mhz =3D clk_t=
able->entries[i].fclk_mhz;
-                       dcn3_01_soc.clock_limits[i].socclk_mhz =3D clk_tabl=
e->entries[i].socclk_mhz;
-                       dcn3_01_soc.clock_limits[i].dram_speed_mts =3D clk_=
table->entries[i].memclk_mhz * 2;
-
-                       dcn3_01_soc.clock_limits[i].dispclk_mhz =3D dcn3_01=
_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
-                       dcn3_01_soc.clock_limits[i].dppclk_mhz =3D dcn3_01_=
soc.clock_limits[closest_clk_lvl].dppclk_mhz;
-                       dcn3_01_soc.clock_limits[i].dram_bw_per_chan_gbps =
=3D dcn3_01_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
-                       dcn3_01_soc.clock_limits[i].dscclk_mhz =3D dcn3_01_=
soc.clock_limits[closest_clk_lvl].dscclk_mhz;
-                       dcn3_01_soc.clock_limits[i].dtbclk_mhz =3D dcn3_01_=
soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
-                       dcn3_01_soc.clock_limits[i].phyclk_d18_mhz =3D dcn3=
_01_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
-                       dcn3_01_soc.clock_limits[i].phyclk_mhz =3D dcn3_01_=
soc.clock_limits[closest_clk_lvl].phyclk_mhz;
+                       dcn3_01_soc._clock_tmp[i].state =3D i;
+                       dcn3_01_soc._clock_tmp[i].dcfclk_mhz =3D clk_table-=
>entries[i].dcfclk_mhz;
+                       dcn3_01_soc._clock_tmp[i].fabricclk_mhz =3D clk_tab=
le->entries[i].fclk_mhz;
+                       dcn3_01_soc._clock_tmp[i].socclk_mhz =3D clk_table-=
>entries[i].socclk_mhz;
+                       dcn3_01_soc._clock_tmp[i].dram_speed_mts =3D clk_ta=
ble->entries[i].memclk_mhz * 2;
+
+                       dcn3_01_soc._clock_tmp[i].dispclk_mhz =3D dcn3_01_s=
oc.clock_limits[closest_clk_lvl].dispclk_mhz;
+                       dcn3_01_soc._clock_tmp[i].dppclk_mhz =3D dcn3_01_so=
c.clock_limits[closest_clk_lvl].dppclk_mhz;
+                       dcn3_01_soc._clock_tmp[i].dram_bw_per_chan_gbps =3D=
 dcn3_01_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
+                       dcn3_01_soc._clock_tmp[i].dscclk_mhz =3D dcn3_01_so=
c.clock_limits[closest_clk_lvl].dscclk_mhz;
+                       dcn3_01_soc._clock_tmp[i].dtbclk_mhz =3D dcn3_01_so=
c.clock_limits[closest_clk_lvl].dtbclk_mhz;
+                       dcn3_01_soc._clock_tmp[i].phyclk_d18_mhz =3D dcn3_0=
1_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
+                       dcn3_01_soc._clock_tmp[i].phyclk_mhz =3D dcn3_01_so=
c.clock_limits[closest_clk_lvl].phyclk_mhz;
                 }

                 if (clk_table->num_entries) {
                         dcn3_01_soc.num_states =3D clk_table->num_entries;
                         /* duplicate last level */
-                       dcn3_01_soc.clock_limits[dcn3_01_soc.num_states] =
=3D dcn3_01_soc.clock_limits[dcn3_01_soc.num_states - 1];
-                       dcn3_01_soc.clock_limits[dcn3_01_soc.num_states].st=
ate =3D dcn3_01_soc.num_states;
+                       dcn3_01_soc._clock_tmp[dcn3_01_soc.num_states] =3D =
dcn3_01_soc.clock_limits[dcn3_01_soc.num_states - 1];
+                       dcn3_01_soc._clock_tmp[dcn3_01_soc.num_states].stat=
e =3D dcn3_01_soc.num_states;
                 }
         }

+       memcpy(&dcn3_01_soc.clock_limits, &dcn3_01_soc._clock_tmp,
+              sizeof(dcn3_01_soc.clock_limits));
+
         dcn3_01_soc.dispclk_dppclk_vco_speed_mhz =3D dc->clk_mgr->dentist_=
vco_freq_khz / 1000.0;
         dc->dml.soc.dispclk_dppclk_vco_speed_mhz =3D dc->clk_mgr->dentist_=
vco_freq_khz / 1000.0;

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drivers=
/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
index 6da702923226..7be3476989ce 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
@@ -580,6 +580,9 @@ void dcn31_update_bw_bounding_box(struct dc *dc, struct=
 clk_bw_params *bw_params

         dc_assert_fp_enabled();

+       memcpy(&dcn3_1_soc._clock_tmp, &dcn3_1_soc.clock_limits,
+              sizeof(dcn3_1_soc.clock_limits));
+
         // Default clock levels are used for diags, which may lead to over=
clocking.
         if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
                 int max_dispclk_mhz =3D 0, max_dppclk_mhz =3D 0;
@@ -607,32 +610,35 @@ void dcn31_update_bw_bounding_box(struct dc *dc, stru=
ct clk_bw_params *bw_params
                                 }
                         }

-                       dcn3_1_soc.clock_limits[i].state =3D i;
+                       dcn3_1_soc._clock_tmp[i].state =3D i;

                         /* Clocks dependent on voltage level. */
-                       dcn3_1_soc.clock_limits[i].dcfclk_mhz =3D clk_table=
->entries[i].dcfclk_mhz;
-                       dcn3_1_soc.clock_limits[i].fabricclk_mhz =3D clk_ta=
ble->entries[i].fclk_mhz;
-                       dcn3_1_soc.clock_limits[i].socclk_mhz =3D clk_table=
->entries[i].socclk_mhz;
-                       dcn3_1_soc.clock_limits[i].dram_speed_mts =3D clk_t=
able->entries[i].memclk_mhz * 2 * clk_table->entries[i].wck_ratio;
+                       dcn3_1_soc._clock_tmp[i].dcfclk_mhz =3D clk_table->=
entries[i].dcfclk_mhz;
+                       dcn3_1_soc._clock_tmp[i].fabricclk_mhz =3D clk_tabl=
e->entries[i].fclk_mhz;
+                       dcn3_1_soc._clock_tmp[i].socclk_mhz =3D clk_table->=
entries[i].socclk_mhz;
+                       dcn3_1_soc._clock_tmp[i].dram_speed_mts =3D clk_tab=
le->entries[i].memclk_mhz * 2 * clk_table->entries[i].wck_ratio;

                         /* Clocks independent of voltage level. */
-                       dcn3_1_soc.clock_limits[i].dispclk_mhz =3D max_disp=
clk_mhz ? max_dispclk_mhz :
+                       dcn3_1_soc._clock_tmp[i].dispclk_mhz =3D max_dispcl=
k_mhz ? max_dispclk_mhz :
                                 dcn3_1_soc.clock_limits[closest_clk_lvl].d=
ispclk_mhz;

-                       dcn3_1_soc.clock_limits[i].dppclk_mhz =3D max_dppcl=
k_mhz ? max_dppclk_mhz :
+                       dcn3_1_soc._clock_tmp[i].dppclk_mhz =3D max_dppclk_=
mhz ? max_dppclk_mhz :
                                 dcn3_1_soc.clock_limits[closest_clk_lvl].d=
ppclk_mhz;

-                       dcn3_1_soc.clock_limits[i].dram_bw_per_chan_gbps =
=3D dcn3_1_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
-                       dcn3_1_soc.clock_limits[i].dscclk_mhz =3D dcn3_1_so=
c.clock_limits[closest_clk_lvl].dscclk_mhz;
-                       dcn3_1_soc.clock_limits[i].dtbclk_mhz =3D dcn3_1_so=
c.clock_limits[closest_clk_lvl].dtbclk_mhz;
-                       dcn3_1_soc.clock_limits[i].phyclk_d18_mhz =3D dcn3_=
1_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
-                       dcn3_1_soc.clock_limits[i].phyclk_mhz =3D dcn3_1_so=
c.clock_limits[closest_clk_lvl].phyclk_mhz;
+                       dcn3_1_soc._clock_tmp[i].dram_bw_per_chan_gbps =3D =
dcn3_1_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
+                       dcn3_1_soc._clock_tmp[i].dscclk_mhz =3D dcn3_1_soc.=
clock_limits[closest_clk_lvl].dscclk_mhz;
+                       dcn3_1_soc._clock_tmp[i].dtbclk_mhz =3D dcn3_1_soc.=
clock_limits[closest_clk_lvl].dtbclk_mhz;
+                       dcn3_1_soc._clock_tmp[i].phyclk_d18_mhz =3D dcn3_1_=
soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
+                       dcn3_1_soc._clock_tmp[i].phyclk_mhz =3D dcn3_1_soc.=
clock_limits[closest_clk_lvl].phyclk_mhz;
                 }
                 if (clk_table->num_entries) {
                         dcn3_1_soc.num_states =3D clk_table->num_entries;
                 }
         }

+       memcpy(&dcn3_1_soc.clock_limits, &dcn3_1_soc._clock_tmp,
+              sizeof(dcn3_1_soc.clock_limits));
+
         dcn3_1_soc.dispclk_dppclk_vco_speed_mhz =3D dc->clk_mgr->dentist_v=
co_freq_khz / 1000.0;
         dc->dml.soc.dispclk_dppclk_vco_speed_mhz =3D dc->clk_mgr->dentist_=
vco_freq_khz / 1000.0;

@@ -705,6 +711,9 @@ void dcn316_update_bw_bounding_box(struct dc *dc, struc=
t clk_bw_params *bw_param

         dc_assert_fp_enabled();

+       memcpy(&dcn3_16_soc._clock_tmp, &dcn3_16_soc.clock_limits,
+              sizeof(dcn3_16_soc.clock_limits));
+
         // Default clock levels are used for diags, which may lead to over=
clocking.
         if (!IS_DIAG_DC(dc->ctx->dce_environment)) {

@@ -736,37 +745,40 @@ void dcn316_update_bw_bounding_box(struct dc *dc, str=
uct clk_bw_params *bw_param
                                 closest_clk_lvl =3D dcn3_16_soc.num_states=
 - 1;
                         }

-                       dcn3_16_soc.clock_limits[i].state =3D i;
+                       dcn3_16_soc._clock_tmp[i].state =3D i;

                         /* Clocks dependent on voltage level. */
-                       dcn3_16_soc.clock_limits[i].dcfclk_mhz =3D clk_tabl=
e->entries[i].dcfclk_mhz;
+                       dcn3_16_soc._clock_tmp[i].dcfclk_mhz =3D clk_table-=
>entries[i].dcfclk_mhz;
                         if (clk_table->num_entries =3D=3D 1 &&
-                               dcn3_16_soc.clock_limits[i].dcfclk_mhz < dc=
n3_16_soc.clock_limits[closest_clk_lvl].dcfclk_mhz) {
+                           dcn3_16_soc._clock_tmp[i].dcfclk_mhz < dcn3_16_=
soc.clock_limits[closest_clk_lvl].dcfclk_mhz) {
                                 /*SMU fix not released yet*/
-                               dcn3_16_soc.clock_limits[i].dcfclk_mhz =3D =
dcn3_16_soc.clock_limits[closest_clk_lvl].dcfclk_mhz;
+                               dcn3_16_soc._clock_tmp[i].dcfclk_mhz =3D dc=
n3_16_soc.clock_limits[closest_clk_lvl].dcfclk_mhz;
                         }
-                       dcn3_16_soc.clock_limits[i].fabricclk_mhz =3D clk_t=
able->entries[i].fclk_mhz;
-                       dcn3_16_soc.clock_limits[i].socclk_mhz =3D clk_tabl=
e->entries[i].socclk_mhz;
-                       dcn3_16_soc.clock_limits[i].dram_speed_mts =3D clk_=
table->entries[i].memclk_mhz * 2 * clk_table->entries[i].wck_ratio;
+                       dcn3_16_soc._clock_tmp[i].fabricclk_mhz =3D clk_tab=
le->entries[i].fclk_mhz;
+                       dcn3_16_soc._clock_tmp[i].socclk_mhz =3D clk_table-=
>entries[i].socclk_mhz;
+                       dcn3_16_soc._clock_tmp[i].dram_speed_mts =3D clk_ta=
ble->entries[i].memclk_mhz * 2 * clk_table->entries[i].wck_ratio;

                         /* Clocks independent of voltage level. */
-                       dcn3_16_soc.clock_limits[i].dispclk_mhz =3D max_dis=
pclk_mhz ? max_dispclk_mhz :
+                       dcn3_16_soc._clock_tmp[i].dispclk_mhz =3D max_dispc=
lk_mhz ? max_dispclk_mhz :
                                 dcn3_16_soc.clock_limits[closest_clk_lvl].=
dispclk_mhz;

-                       dcn3_16_soc.clock_limits[i].dppclk_mhz =3D max_dppc=
lk_mhz ? max_dppclk_mhz :
+                       dcn3_16_soc._clock_tmp[i].dppclk_mhz =3D max_dppclk=
_mhz ? max_dppclk_mhz :
                                 dcn3_16_soc.clock_limits[closest_clk_lvl].=
dppclk_mhz;

-                       dcn3_16_soc.clock_limits[i].dram_bw_per_chan_gbps =
=3D dcn3_16_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
-                       dcn3_16_soc.clock_limits[i].dscclk_mhz =3D dcn3_16_=
soc.clock_limits[closest_clk_lvl].dscclk_mhz;
-                       dcn3_16_soc.clock_limits[i].dtbclk_mhz =3D dcn3_16_=
soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
-                       dcn3_16_soc.clock_limits[i].phyclk_d18_mhz =3D dcn3=
_16_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
-                       dcn3_16_soc.clock_limits[i].phyclk_mhz =3D dcn3_16_=
soc.clock_limits[closest_clk_lvl].phyclk_mhz;
+                       dcn3_16_soc._clock_tmp[i].dram_bw_per_chan_gbps =3D=
 dcn3_16_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
+                       dcn3_16_soc._clock_tmp[i].dscclk_mhz =3D dcn3_16_so=
c.clock_limits[closest_clk_lvl].dscclk_mhz;
+                       dcn3_16_soc._clock_tmp[i].dtbclk_mhz =3D dcn3_16_so=
c.clock_limits[closest_clk_lvl].dtbclk_mhz;
+                       dcn3_16_soc._clock_tmp[i].phyclk_d18_mhz =3D dcn3_1=
6_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
+                       dcn3_16_soc._clock_tmp[i].phyclk_mhz =3D dcn3_16_so=
c.clock_limits[closest_clk_lvl].phyclk_mhz;
                 }
                 if (clk_table->num_entries) {
                         dcn3_16_soc.num_states =3D clk_table->num_entries;
                 }
         }

+       memcpy(&dcn3_16_soc.clock_limits, &dcn3_16_soc._clock_tmp,
+              sizeof(dcn3_16_soc.clock_limits));
+
         if (max_dispclk_mhz) {
                 dcn3_16_soc.dispclk_dppclk_vco_speed_mhz =3D max_dispclk_m=
hz * 2;
                 dc->dml.soc.dispclk_dppclk_vco_speed_mhz =3D max_dispclk_m=
hz * 2;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/dr=
ivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
index 74afa10e70f8..2bdf60846762 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
@@ -161,6 +161,11 @@ struct _vcs_dpi_voltage_scaling_st {

 struct _vcs_dpi_soc_bounding_box_st {
         struct _vcs_dpi_voltage_scaling_st clock_limits[DC__VOLTAGE_STATES=
];
+       /*
+        * This is a temporary stash for updating @clock_limits with the PM=
FW
+        * clock table. Do not use outside of *update_bw_boudning_box funct=
ions.
+        */
+       struct _vcs_dpi_voltage_scaling_st _clock_tmp[DC__VOLTAGE_STATES];
         unsigned int num_states;
         double sr_exit_time_us;
         double sr_enter_plus_exit_time_us;
--
2.36.1


--_000_CH0PR12MB5284B33BD8FA4AB237FC1D668BA49CH0PR12MB5284namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
Isnt it cleaner to revert the original patch which removed the temporary va=
riable and then instead allocate the clock_limits array on heap, and later =
freed at the end of the function?
<br>
</div>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
--</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Jay<br>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Li, Sun peng (Leo) &l=
t;Sunpeng.Li@amd.com&gt;<br>
<b>Sent:</b> Wednesday, June 8, 2022 12:48 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Pillai, Aurabind=
o &lt;Aurabindo.Pillai@amd.com&gt;; Siqueira, Rodrigo &lt;Rodrigo.Siqueira@=
amd.com&gt;; Li, Sun peng (Leo) &lt;Sunpeng.Li@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display: Use pre-allocated temp struct for =
bounding box update</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Leo Li &lt;sunpeng.li@amd.com&gt;<br>
<br>
[Why]<br>
<br>
There is a theoretical problem in prior patches for reducing the stack<br>
size of *update_bw_bounding_box() functions.<br>
<br>
By modifying the soc.clock_limits[n] struct directly, this can cause<br>
unintended behavior as the for loop attempts to swap rows in<br>
clock_limits[n]. A temporary struct is still required to make sure we<br>
stay functinoally equivalent.<br>
<br>
[How]<br>
<br>
Add a temporary clock_limits table to the SOC struct, and use it when<br>
swapping rows.<br>
<br>
Signed-off-by: Leo Li &lt;sunpeng.li@amd.com&gt;<br>
---<br>
&nbsp;.../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c&nbsp; | 33 +++++-----<br=
>
&nbsp;.../amd/display/dc/dml/dcn301/dcn301_fpu.c&nbsp;&nbsp;&nbsp; | 36 +++=
+++-----<br>
&nbsp;.../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c&nbsp; | 64 +++++++++++--=
------<br>
&nbsp;.../amd/display/dc/dml/display_mode_structs.h |&nbsp; 5 ++<br>
&nbsp;4 files changed, 82 insertions(+), 56 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers=
/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c<br>
index c2fec0d85da4..e247b2270b1d 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c<br>
@@ -2015,9 +2015,8 @@ void dcn21_update_bw_bounding_box(struct dc *dc, stru=
ct clk_bw_params *bw_params<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ASSERT(clk_table-&gt;num_e=
ntries);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Copy dcn2_1_soc.clock_l=
imits to clock_limits to avoid copying over null states later */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; dcn2_1_soc.num_s=
tates + 1; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dcn2_1_soc.clock_limits[i] =3D dcn2_1_soc.clock_limits[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(&amp;dcn2_1_soc._clock_tmp, &a=
mp;dcn2_1_soc.clock_limits,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; sizeof(dcn2_1_soc.clock_limits));<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; clk_t=
able-&gt;num_entries; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* loop backwards*/<br>
@@ -2032,22 +2031,26 @@ void dcn21_update_bw_bounding_box(struct dc *dc, st=
ruct clk_bw_params *bw_params<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (i =3D=3D 1)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; k++;<=
br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dcn2_1_soc.clock_limits[k].state =3D k;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dcn2_1_soc.clock_limits[k].dcfclk_mhz =3D clk_table-&gt;entries[=
i].dcfclk_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dcn2_1_soc.clock_limits[k].fabricclk_mhz =3D clk_table-&gt;entri=
es[i].fclk_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dcn2_1_soc.clock_limits[k].socclk_mhz =3D clk_table-&gt;entries[=
i].socclk_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dcn2_1_soc.clock_limits[k].dram_speed_mts =3D clk_table-&gt;entr=
ies[i].memclk_mhz * 2;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dcn2_1_soc._clock_tmp[k].state =3D k;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dcn2_1_soc._clock_tmp[k].dcfclk_mhz =3D clk_table-&gt;entries[i]=
.dcfclk_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dcn2_1_soc._clock_tmp[k].fabricclk_mhz =3D clk_table-&gt;entries=
[i].fclk_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dcn2_1_soc._clock_tmp[k].socclk_mhz =3D clk_table-&gt;entries[i]=
.socclk_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dcn2_1_soc._clock_tmp[k].dram_speed_mts =3D clk_table-&gt;entrie=
s[i].memclk_mhz * 2;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dcn2_1_soc.clock_limits[k].dispclk_mhz =3D dcn2_1_soc.clock_limi=
ts[closest_clk_lvl].dispclk_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dcn2_1_soc.clock_limits[k].dppclk_mhz =3D dcn2_1_soc.clock_limit=
s[closest_clk_lvl].dppclk_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dcn2_1_soc.clock_limits[k].dram_bw_per_chan_gbps =3D dcn2_1_soc.=
clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dcn2_1_soc.clock_limits[k].dscclk_mhz =3D dcn2_1_soc.clock_limit=
s[closest_clk_lvl].dscclk_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dcn2_1_soc.clock_limits[k].dtbclk_mhz =3D dcn2_1_soc.clock_limit=
s[closest_clk_lvl].dtbclk_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dcn2_1_soc.clock_limits[k].phyclk_d18_mhz =3D dcn2_1_soc.clock_l=
imits[closest_clk_lvl].phyclk_d18_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dcn2_1_soc.clock_limits[k].phyclk_mhz =3D dcn2_1_soc.clock_limit=
s[closest_clk_lvl].phyclk_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dcn2_1_soc._clock_tmp[k].dispclk_mhz =3D dcn2_1_soc.clock_limits=
[closest_clk_lvl].dispclk_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dcn2_1_soc._clock_tmp[k].dppclk_mhz =3D dcn2_1_soc.clock_limits[=
closest_clk_lvl].dppclk_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dcn2_1_soc._clock_tmp[k].dram_bw_per_chan_gbps =3D dcn2_1_soc.cl=
ock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dcn2_1_soc._clock_tmp[k].dscclk_mhz =3D dcn2_1_soc.clock_limits[=
closest_clk_lvl].dscclk_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dcn2_1_soc._clock_tmp[k].dtbclk_mhz =3D dcn2_1_soc.clock_limits[=
closest_clk_lvl].dtbclk_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dcn2_1_soc._clock_tmp[k].phyclk_d18_mhz =3D dcn2_1_soc.clock_lim=
its[closest_clk_lvl].phyclk_d18_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dcn2_1_soc._clock_tmp[k].phyclk_mhz =3D dcn2_1_soc.clock_limits[=
closest_clk_lvl].phyclk_mhz;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; k++;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(&amp;dcn2_1_soc.clock_limits, =
&amp;dcn2_1_soc._clock_tmp,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; sizeof(dcn2_1_soc.clock_limits));<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (clk_table-&gt;num_entr=
ies) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dcn2_1_soc.num_states =3D clk_table-&gt;num_entries +=
 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* fill in min DF PState */<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c b/drive=
rs/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c<br>
index 62cf283d9f41..e4863f0bf0f6 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c<br>
@@ -254,6 +254,9 @@ void dcn301_update_bw_bounding_box(struct dc *dc, struc=
t clk_bw_params *bw_param<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc_assert_fp_enabled();<br=
>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(&amp;dcn3_01_soc._clock_tmp, &=
amp;dcn3_01_soc.clock_limits,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; sizeof(dcn3_01_soc.clock_limits));<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Default clock levels ar=
e used for diags, which may lead to overclocking. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!IS_DIAG_DC(dc-&gt;ctx=
-&gt;dce_environment)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dcn3_01_ip.max_num_otg =3D pool-&gt;base.res_cap-&gt;=
num_timing_generator;<br>
@@ -270,29 +273,32 @@ void dcn301_update_bw_bounding_box(struct dc *dc, str=
uct clk_bw_params *bw_param<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_01_soc.cloc=
k_limits[i].state =3D i;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_01_soc.cloc=
k_limits[i].dcfclk_mhz =3D clk_table-&gt;entries[i].dcfclk_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_01_soc.cloc=
k_limits[i].fabricclk_mhz =3D clk_table-&gt;entries[i].fclk_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_01_soc.cloc=
k_limits[i].socclk_mhz =3D clk_table-&gt;entries[i].socclk_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_01_soc.cloc=
k_limits[i].dram_speed_mts =3D clk_table-&gt;entries[i].memclk_mhz * 2;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_01_soc.cloc=
k_limits[i].dispclk_mhz =3D dcn3_01_soc.clock_limits[closest_clk_lvl].dispc=
lk_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_01_soc.cloc=
k_limits[i].dppclk_mhz =3D dcn3_01_soc.clock_limits[closest_clk_lvl].dppclk=
_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_01_soc.cloc=
k_limits[i].dram_bw_per_chan_gbps =3D dcn3_01_soc.clock_limits[closest_clk_=
lvl].dram_bw_per_chan_gbps;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_01_soc.cloc=
k_limits[i].dscclk_mhz =3D dcn3_01_soc.clock_limits[closest_clk_lvl].dscclk=
_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_01_soc.cloc=
k_limits[i].dtbclk_mhz =3D dcn3_01_soc.clock_limits[closest_clk_lvl].dtbclk=
_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_01_soc.cloc=
k_limits[i].phyclk_d18_mhz =3D dcn3_01_soc.clock_limits[closest_clk_lvl].ph=
yclk_d18_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_01_soc.cloc=
k_limits[i].phyclk_mhz =3D dcn3_01_soc.clock_limits[closest_clk_lvl].phyclk=
_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_01_soc._clo=
ck_tmp[i].state =3D i;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_01_soc._clo=
ck_tmp[i].dcfclk_mhz =3D clk_table-&gt;entries[i].dcfclk_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_01_soc._clo=
ck_tmp[i].fabricclk_mhz =3D clk_table-&gt;entries[i].fclk_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_01_soc._clo=
ck_tmp[i].socclk_mhz =3D clk_table-&gt;entries[i].socclk_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_01_soc._clo=
ck_tmp[i].dram_speed_mts =3D clk_table-&gt;entries[i].memclk_mhz * 2;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_01_soc._clo=
ck_tmp[i].dispclk_mhz =3D dcn3_01_soc.clock_limits[closest_clk_lvl].dispclk=
_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_01_soc._clo=
ck_tmp[i].dppclk_mhz =3D dcn3_01_soc.clock_limits[closest_clk_lvl].dppclk_m=
hz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_01_soc._clo=
ck_tmp[i].dram_bw_per_chan_gbps =3D dcn3_01_soc.clock_limits[closest_clk_lv=
l].dram_bw_per_chan_gbps;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_01_soc._clo=
ck_tmp[i].dscclk_mhz =3D dcn3_01_soc.clock_limits[closest_clk_lvl].dscclk_m=
hz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_01_soc._clo=
ck_tmp[i].dtbclk_mhz =3D dcn3_01_soc.clock_limits[closest_clk_lvl].dtbclk_m=
hz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_01_soc._clo=
ck_tmp[i].phyclk_d18_mhz =3D dcn3_01_soc.clock_limits[closest_clk_lvl].phyc=
lk_d18_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_01_soc._clo=
ck_tmp[i].phyclk_mhz =3D dcn3_01_soc.clock_limits[closest_clk_lvl].phyclk_m=
hz;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (clk_table-&gt;num_entries) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_=
01_soc.num_states =3D clk_table-&gt;num_entries;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* du=
plicate last level */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_01_soc.cloc=
k_limits[dcn3_01_soc.num_states] =3D dcn3_01_soc.clock_limits[dcn3_01_soc.n=
um_states - 1];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_01_soc.cloc=
k_limits[dcn3_01_soc.num_states].state =3D dcn3_01_soc.num_states;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_01_soc._clo=
ck_tmp[dcn3_01_soc.num_states] =3D dcn3_01_soc.clock_limits[dcn3_01_soc.num=
_states - 1];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_01_soc._clo=
ck_tmp[dcn3_01_soc.num_states].state =3D dcn3_01_soc.num_states;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(&amp;dcn3_01_soc.clock_limits,=
 &amp;dcn3_01_soc._clock_tmp,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; sizeof(dcn3_01_soc.clock_limits));<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_01_soc.dispclk_dppclk=
_vco_speed_mhz =3D dc-&gt;clk_mgr-&gt;dentist_vco_freq_khz / 1000.0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;dml.soc.dispclk_dpp=
clk_vco_speed_mhz =3D dc-&gt;clk_mgr-&gt;dentist_vco_freq_khz / 1000.0;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drivers=
/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c<br>
index 6da702923226..7be3476989ce 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c<br>
@@ -580,6 +580,9 @@ void dcn31_update_bw_bounding_box(struct dc *dc, struct=
 clk_bw_params *bw_params<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc_assert_fp_enabled();<br=
>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(&amp;dcn3_1_soc._clock_tmp, &a=
mp;dcn3_1_soc.clock_limits,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; sizeof(dcn3_1_soc.clock_limits));<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Default clock levels ar=
e used for diags, which may lead to overclocking.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!IS_DIAG_DC(dc-&gt;ctx=
-&gt;dce_environment)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int max_dispclk_mhz =3D 0, max_dppclk_mhz =3D 0;<br>
@@ -607,32 +610,35 @@ void dcn31_update_bw_bounding_box(struct dc *dc, stru=
ct clk_bw_params *bw_params<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_1_soc.clock=
_limits[i].state =3D i;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_1_soc._cloc=
k_tmp[i].state =3D i;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Cl=
ocks dependent on voltage level. */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_1_soc.clock=
_limits[i].dcfclk_mhz =3D clk_table-&gt;entries[i].dcfclk_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_1_soc.clock=
_limits[i].fabricclk_mhz =3D clk_table-&gt;entries[i].fclk_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_1_soc.clock=
_limits[i].socclk_mhz =3D clk_table-&gt;entries[i].socclk_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_1_soc.clock=
_limits[i].dram_speed_mts =3D clk_table-&gt;entries[i].memclk_mhz * 2 * clk=
_table-&gt;entries[i].wck_ratio;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_1_soc._cloc=
k_tmp[i].dcfclk_mhz =3D clk_table-&gt;entries[i].dcfclk_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_1_soc._cloc=
k_tmp[i].fabricclk_mhz =3D clk_table-&gt;entries[i].fclk_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_1_soc._cloc=
k_tmp[i].socclk_mhz =3D clk_table-&gt;entries[i].socclk_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_1_soc._cloc=
k_tmp[i].dram_speed_mts =3D clk_table-&gt;entries[i].memclk_mhz * 2 * clk_t=
able-&gt;entries[i].wck_ratio;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Cl=
ocks independent of voltage level. */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_1_soc.clock=
_limits[i].dispclk_mhz =3D max_dispclk_mhz ? max_dispclk_mhz :<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_1_soc._cloc=
k_tmp[i].dispclk_mhz =3D max_dispclk_mhz ? max_dispclk_mhz :<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_1_soc.clock_limits[closest_=
clk_lvl].dispclk_mhz;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_1_soc.clock=
_limits[i].dppclk_mhz =3D max_dppclk_mhz ? max_dppclk_mhz :<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_1_soc._cloc=
k_tmp[i].dppclk_mhz =3D max_dppclk_mhz ? max_dppclk_mhz :<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_1_soc.clock_limits[closest_=
clk_lvl].dppclk_mhz;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_1_soc.clock=
_limits[i].dram_bw_per_chan_gbps =3D dcn3_1_soc.clock_limits[closest_clk_lv=
l].dram_bw_per_chan_gbps;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_1_soc.clock=
_limits[i].dscclk_mhz =3D dcn3_1_soc.clock_limits[closest_clk_lvl].dscclk_m=
hz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_1_soc.clock=
_limits[i].dtbclk_mhz =3D dcn3_1_soc.clock_limits[closest_clk_lvl].dtbclk_m=
hz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_1_soc.clock=
_limits[i].phyclk_d18_mhz =3D dcn3_1_soc.clock_limits[closest_clk_lvl].phyc=
lk_d18_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_1_soc.clock=
_limits[i].phyclk_mhz =3D dcn3_1_soc.clock_limits[closest_clk_lvl].phyclk_m=
hz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_1_soc._cloc=
k_tmp[i].dram_bw_per_chan_gbps =3D dcn3_1_soc.clock_limits[closest_clk_lvl]=
.dram_bw_per_chan_gbps;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_1_soc._cloc=
k_tmp[i].dscclk_mhz =3D dcn3_1_soc.clock_limits[closest_clk_lvl].dscclk_mhz=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_1_soc._cloc=
k_tmp[i].dtbclk_mhz =3D dcn3_1_soc.clock_limits[closest_clk_lvl].dtbclk_mhz=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_1_soc._cloc=
k_tmp[i].phyclk_d18_mhz =3D dcn3_1_soc.clock_limits[closest_clk_lvl].phyclk=
_d18_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_1_soc._cloc=
k_tmp[i].phyclk_mhz =3D dcn3_1_soc.clock_limits[closest_clk_lvl].phyclk_mhz=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (clk_table-&gt;num_entries) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_=
1_soc.num_states =3D clk_table-&gt;num_entries;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(&amp;dcn3_1_soc.clock_limits, =
&amp;dcn3_1_soc._clock_tmp,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; sizeof(dcn3_1_soc.clock_limits));<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_1_soc.dispclk_dppclk_=
vco_speed_mhz =3D dc-&gt;clk_mgr-&gt;dentist_vco_freq_khz / 1000.0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;dml.soc.dispclk_dpp=
clk_vco_speed_mhz =3D dc-&gt;clk_mgr-&gt;dentist_vco_freq_khz / 1000.0;<br>
&nbsp;<br>
@@ -705,6 +711,9 @@ void dcn316_update_bw_bounding_box(struct dc *dc, struc=
t clk_bw_params *bw_param<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc_assert_fp_enabled();<br=
>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(&amp;dcn3_16_soc._clock_tmp, &=
amp;dcn3_16_soc.clock_limits,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; sizeof(dcn3_16_soc.clock_limits));<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Default clock levels ar=
e used for diags, which may lead to overclocking.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!IS_DIAG_DC(dc-&gt;ctx=
-&gt;dce_environment)) {<br>
&nbsp;<br>
@@ -736,37 +745,40 @@ void dcn316_update_bw_bounding_box(struct dc *dc, str=
uct clk_bw_params *bw_param<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; closest_clk_lvl =3D dcn3_16_soc.=
num_states - 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_16_soc.cloc=
k_limits[i].state =3D i;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_16_soc._clo=
ck_tmp[i].state =3D i;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Cl=
ocks dependent on voltage level. */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_16_soc.cloc=
k_limits[i].dcfclk_mhz =3D clk_table-&gt;entries[i].dcfclk_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_16_soc._clo=
ck_tmp[i].dcfclk_mhz =3D clk_table-&gt;entries[i].dcfclk_mhz;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (c=
lk_table-&gt;num_entries =3D=3D 1 &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_16_soc.clock_limits[i].dcfclk_mhz &lt;=
 dcn3_16_soc.clock_limits[closest_clk_lvl].dcfclk_mhz) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; dcn3_16_soc._clock_tmp[i].dcfclk_mhz &lt; dcn3_16_soc.clock_limits[=
closest_clk_lvl].dcfclk_mhz) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*SMU fix not released yet*/<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_16_soc.clock_limits[i].dcfclk_mhz =3D =
dcn3_16_soc.clock_limits[closest_clk_lvl].dcfclk_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_16_soc._clock_tmp[i].dcfclk_mhz =3D dc=
n3_16_soc.clock_limits[closest_clk_lvl].dcfclk_mhz;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_16_soc.cloc=
k_limits[i].fabricclk_mhz =3D clk_table-&gt;entries[i].fclk_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_16_soc.cloc=
k_limits[i].socclk_mhz =3D clk_table-&gt;entries[i].socclk_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_16_soc.cloc=
k_limits[i].dram_speed_mts =3D clk_table-&gt;entries[i].memclk_mhz * 2 * cl=
k_table-&gt;entries[i].wck_ratio;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_16_soc._clo=
ck_tmp[i].fabricclk_mhz =3D clk_table-&gt;entries[i].fclk_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_16_soc._clo=
ck_tmp[i].socclk_mhz =3D clk_table-&gt;entries[i].socclk_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_16_soc._clo=
ck_tmp[i].dram_speed_mts =3D clk_table-&gt;entries[i].memclk_mhz * 2 * clk_=
table-&gt;entries[i].wck_ratio;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Cl=
ocks independent of voltage level. */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_16_soc.cloc=
k_limits[i].dispclk_mhz =3D max_dispclk_mhz ? max_dispclk_mhz :<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_16_soc._clo=
ck_tmp[i].dispclk_mhz =3D max_dispclk_mhz ? max_dispclk_mhz :<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_16_soc.clock_limits[closest=
_clk_lvl].dispclk_mhz;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_16_soc.cloc=
k_limits[i].dppclk_mhz =3D max_dppclk_mhz ? max_dppclk_mhz :<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_16_soc._clo=
ck_tmp[i].dppclk_mhz =3D max_dppclk_mhz ? max_dppclk_mhz :<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_16_soc.clock_limits[closest=
_clk_lvl].dppclk_mhz;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_16_soc.cloc=
k_limits[i].dram_bw_per_chan_gbps =3D dcn3_16_soc.clock_limits[closest_clk_=
lvl].dram_bw_per_chan_gbps;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_16_soc.cloc=
k_limits[i].dscclk_mhz =3D dcn3_16_soc.clock_limits[closest_clk_lvl].dscclk=
_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_16_soc.cloc=
k_limits[i].dtbclk_mhz =3D dcn3_16_soc.clock_limits[closest_clk_lvl].dtbclk=
_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_16_soc.cloc=
k_limits[i].phyclk_d18_mhz =3D dcn3_16_soc.clock_limits[closest_clk_lvl].ph=
yclk_d18_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_16_soc.cloc=
k_limits[i].phyclk_mhz =3D dcn3_16_soc.clock_limits[closest_clk_lvl].phyclk=
_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_16_soc._clo=
ck_tmp[i].dram_bw_per_chan_gbps =3D dcn3_16_soc.clock_limits[closest_clk_lv=
l].dram_bw_per_chan_gbps;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_16_soc._clo=
ck_tmp[i].dscclk_mhz =3D dcn3_16_soc.clock_limits[closest_clk_lvl].dscclk_m=
hz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_16_soc._clo=
ck_tmp[i].dtbclk_mhz =3D dcn3_16_soc.clock_limits[closest_clk_lvl].dtbclk_m=
hz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_16_soc._clo=
ck_tmp[i].phyclk_d18_mhz =3D dcn3_16_soc.clock_limits[closest_clk_lvl].phyc=
lk_d18_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_16_soc._clo=
ck_tmp[i].phyclk_mhz =3D dcn3_16_soc.clock_limits[closest_clk_lvl].phyclk_m=
hz;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (clk_table-&gt;num_entries) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_=
16_soc.num_states =3D clk_table-&gt;num_entries;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(&amp;dcn3_16_soc.clock_limits,=
 &amp;dcn3_16_soc._clock_tmp,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; sizeof(dcn3_16_soc.clock_limits));<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (max_dispclk_mhz) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dcn3_16_soc.dispclk_dppclk_vco_speed_mhz =3D max_disp=
clk_mhz * 2;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dc-&gt;dml.soc.dispclk_dppclk_vco_speed_mhz =3D max_d=
ispclk_mhz * 2;<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/dr=
ivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h<br>
index 74afa10e70f8..2bdf60846762 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h<br>
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h<br>
@@ -161,6 +161,11 @@ struct _vcs_dpi_voltage_scaling_st {<br>
&nbsp;<br>
&nbsp;struct _vcs_dpi_soc_bounding_box_st {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct _vcs_dpi_voltage_sc=
aling_st clock_limits[DC__VOLTAGE_STATES];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * This is a temporary stash for=
 updating @clock_limits with the PMFW<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * clock table. Do not use outsi=
de of *update_bw_boudning_box functions.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct _vcs_dpi_voltage_scaling_st _c=
lock_tmp[DC__VOLTAGE_STATES];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int num_states;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; double sr_exit_time_us;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; double sr_enter_plus_exit_=
time_us;<br>
-- <br>
2.36.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB5284B33BD8FA4AB237FC1D668BA49CH0PR12MB5284namp_--
