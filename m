Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFB7C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Dec 2023 16:48:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE06510EADD;
	Fri,  8 Dec 2023 16:48:41 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36D0910EADE
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Dec 2023 16:48:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWbqs0GOWtHtLYXCJPJbThMVzkoMqNLsFbAmHyoCuuswu0qbOpUn2hfoyZjNh+rW+OImWB8o1d4QcxQq4Rm6KAzSds0SOAeSANFBm6reqosII9ITX3qfue/2bXYea8ZK+XNTJOfxRFAZcWudSNBVXuWSCUg9ePDPzHRHuKRJX/ujy8Lmvni5gKRw21Qcn3ItfGBBiDu4V2Fvj1vfHdAp8VDhlqeXl5vusYxN9D114VTlOKTrTlxAXDGz3QtqQkTK5khhvJSezEWGWX6hr+EmQUHwp+4Rs4+uCYGAHNQfb95kumK4bhOTb0+aj9ElRtRAvU3aBV7HCTYdeU17wqgB5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXqSKuiEnrsc2kh1K5ZjxmJJ3LAQbj3A5xV+qIEHN1A=;
 b=Iv8ATT2WYjsfzXiKDZ8MSRKDUblS6Ve1rAZJxk9hrQ4GCKTVRNOW4LejAddSi/n98IZcCDj2c6EZuU058+YDE4r1e7QzglsygoEMq4vAItMAW70ZpvRraPSK03mFZ2SOlCZ8kDLPfXn42NPCUQq3jCdzYZWJubRQfKSUZaFpyck53RR/rrrsDt+evAX/kbUhPLUtd0gLeW2N8mo54gQRzEqAg6hb8FspQm1W6z6cpbn0jUeW9WAc7qKThBZkiZ6OKHkrMdsRH+P/+e3zJk8qtJm+jcK7+nAuE3dDjRbtOStiIMup95JqbAEKI9TBNefh93NbZvn49Kr437dTeHI80A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXqSKuiEnrsc2kh1K5ZjxmJJ3LAQbj3A5xV+qIEHN1A=;
 b=guHJn60hwVImzwqm05Do3ZlySraxtu2UuvUUUpNWPoIawUowO6y++bd/JsFP0OM9FotpAiKXf597yjX4X4Ke40pGtX4w/a06GiSwCSSjbYnRvxcHDhyJCX0O/olaBxq4eMI3guX3oHY3chLPFAJx7HVMLjB5S5Q0f42EhYD2WVg=
Received: from BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17)
 by BN9PR12MB5243.namprd12.prod.outlook.com (2603:10b6:408:100::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 16:48:37 +0000
Received: from BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::7a27:67a0:3021:7d4b]) by BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::7a27:67a0:3021:7d4b%4]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 16:48:37 +0000
From: "Luo, Zhigang" <Zhigang.Luo@amd.com>
To: "Chander, Vignesh" <Vignesh.Chander@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: xgmi_fill_topology_info
Thread-Topic: [PATCH] drm/amdgpu: xgmi_fill_topology_info
Thread-Index: AQHaKW9zjXhxC0t94kO4xirD8Mv/ybCfmV0A
Date: Fri, 8 Dec 2023 16:48:37 +0000
Message-ID: <BL1PR12MB5317DF8A994F3BEC05F0C194F18AA@BL1PR12MB5317.namprd12.prod.outlook.com>
References: <20231208004211.3720802-1-Vignesh.Chander@amd.com>
In-Reply-To: <20231208004211.3720802-1-Vignesh.Chander@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=30fd84bb-4c48-4f33-a26f-db9d35ff7c59;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-12-08T16:46:40Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5317:EE_|BN9PR12MB5243:EE_
x-ms-office365-filtering-correlation-id: f2c6e1ca-ff92-44a4-9f0f-08dbf80d8612
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KVU9FfZH5Km3zngVjtO8XtMb2EpY0R0zcwgyvLPJGJRYov5KTf7OJfZwNKAFEsXjWJK6yjmeOOj0CpEJmsylvLU2vNNQoOnjWZxn3SnljrGHyz6g90K30gsvjEryeI1o0ehZPV6WXDBKy0H7o2kdQqM836/H0jtKa3Or7KZ3yOWddMTw612kch/0Knha3mTyXmNOihFIURkN6r2nnPXTCMo9mnP/eLNBJyA0Q/SLusnCSy/CLIYfuATOnS7qKef/KELJlRiuGZl5bD7khqGKSUO5QPHHSDWuwGTY1M5Y1j4oTk8o8+nudUPBI+hnynmKjhOoi06pg8uG/0s29//OKkfXf8Ssa8NZDVHuT5lzwxXtWLzmsJnafCuSAlpnXaP9Xv6nWvDTExEhlOzyZpZrqOEdayeVQE6+39OA5vt8xvdt+T+cov5U281gebE3uazwIzs4gZjlNeryT2tMoDNa2TY8IpulwbhHLqTxn89NsNTnmnPXXz+EGPvxk7Ndw5W+yWJysl0lENtzd2FO3TwHjj8jCwOY+3vHdghJ4YlYbwk7ysENU0IfhChhyUhpHa5wLdRLicpZjTdv/Nxj/EA+GroFt8jMDHtinib4pHGuvMjJz4u4Ye6P2YSLrSfuAEt1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5317.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(366004)(346002)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(7696005)(53546011)(6506007)(71200400001)(478600001)(52536014)(5660300002)(66446008)(66946007)(76116006)(2906002)(66556008)(64756008)(66476007)(110136005)(316002)(54906003)(4326008)(8676002)(8936002)(83380400001)(55016003)(38070700009)(122000001)(38100700002)(41300700001)(33656002)(9686003)(26005)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SIImS08GR3An1pyRcedxwAcVwQMeli0O6Drw7xZBqE9v7UjRYx7LM/ws8/HA?=
 =?us-ascii?Q?MJSGKjac8gufYoWrK8Gd83mJW1JHFqXUuuXnCE/pzjJQ2lrYSqo98LfrFH45?=
 =?us-ascii?Q?HkjMF1ytLIJGTBofLKRU3JVczRFt1/TIPZo8H3zjLRmzpEJ7lCwhpVGqEOe0?=
 =?us-ascii?Q?DuYXtYWEs8iF+AqaGAobyIX5EJ3gdGxzAPOhpoKwxZfUmrcQMH7IB8DqYfBv?=
 =?us-ascii?Q?HgMn2OKojj+xPpmCKzct4/5lGsySEuEjoJ4i1S73ave2zjuseAMlYoqEDPSJ?=
 =?us-ascii?Q?mFBSE0+2UTiPbTzie9d4UQuQwQGikDBYHC7Z3PscP+rNxjphwvIUmJnQqw/S?=
 =?us-ascii?Q?FBVsNeb/HVz1ffaMT3c2KdAixJLGTHiiXctcv7ZlhqYy2mq1ZUgwhr2t1poJ?=
 =?us-ascii?Q?L7KCBJPjUw4yYs6IacRmYvOJvgl/LrjY8d/uKhKE1AB1bqZRrSAJzVYOID4m?=
 =?us-ascii?Q?0busoI8fKwg+JsewLyaQBUk/xpZkH2Zo0Y25G6Nq7vyVG6HQ6zaaEPbfZ3fa?=
 =?us-ascii?Q?NAn2yaG5LVkfAvkHa5b5d3GsX16IjuAMgmxJvSRy8LYlMTuS+b9rLZbiKnXK?=
 =?us-ascii?Q?XeS61bgPV4N+mS/GOsTniN2SxBm7ho4TlB8TPJ9Qc1ITVyyfeCGaPCchW7Xy?=
 =?us-ascii?Q?jSmp5ht75+NNHP/cdrLAMEUURfyhtYkC8uKdpSofgAYIzcMSwTyCjhdBTFdD?=
 =?us-ascii?Q?aKrb8STgQhTo8llzAd971W3OitpNEv8PqkJGjow20E9pQ0ZMToyP6f33W6+z?=
 =?us-ascii?Q?OpInVQeZoyhnd0V089w95JzC43s65d6MwQXtl8Y0qmEBo88wc3nPsBTaW2sq?=
 =?us-ascii?Q?eOgTuNXea68OC6lKqXtbDOIHM4MBltP4sU3NkI0m3rmgKvyg0SsDif1iPDFK?=
 =?us-ascii?Q?n963vR37J8T2jbi8uzu1ueJ03TTqjz1h3koJPX6+1yzGbkGPhehDncd6SwBR?=
 =?us-ascii?Q?F4Njyt05iPpd1E55L2Xve6s5iS5CYifmvl4igegQn8wvV+UZegaXwNe45EPD?=
 =?us-ascii?Q?o48OqAaOklQF1GBrnuwBaQAnlyCW8YQWWUPIHRzPHbnzb1qah2V4vVe3BQk2?=
 =?us-ascii?Q?4fTJ19YHee6E9HT9bF26i/T2uV/cTXcMyZXbrb9E+3GFp/ftBL+x0DG+r6GS?=
 =?us-ascii?Q?aFoP/L5xd72HeWtGNJbJlSNd5bsKf6rHWXWcZRNk0R/bvlAIpt3Pctn2AwDq?=
 =?us-ascii?Q?8kqk/cBG6J/haweXvhfTLzR1PJGpvr3hYW9+ER07StIs5sUio1rFCM64Bdxj?=
 =?us-ascii?Q?RetuSh+g+A6hvyUkV5GVA7RAfLsXJ9K5KURtmPX9Zq8X2VlYEnfKCbhY7o1H?=
 =?us-ascii?Q?mxi9Q9Adqs/wdef5kg3pAX7uGRZaKayy9YCi8WwjgIbrIyILzaZmbEpXCL07?=
 =?us-ascii?Q?enIWN9Tae40CHSwDzenwFMTeEzWF9Ugl21JHyhKVY/LO4P1P+BqznMO96t77?=
 =?us-ascii?Q?gOO+WvshIYSfgMt5+0/8l7G37ZDyFCWjMl79agfnUeS21Q0m55pHWdesIhm2?=
 =?us-ascii?Q?AaQgIkxMY5VI3hTjwF+m3lxUQ3GVdKnBOF0IGBxdVywHa+frT0GG1vrTNDH2?=
 =?us-ascii?Q?wyCgm9StK8jYawACFKY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5317.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c6e1ca-ff92-44a4-9f0f-08dbf80d8612
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2023 16:48:37.0598 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /0H123wtNMSW2Nn3sP4EI4KtK1jaWLdtgQ91AvXmwK5sbon6b0sYLNm+K8Ss33cl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5243
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Kim, Jonathan" <Jonathan.Kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Zhigang Luo <zhigang.luo@amd.com>

-----Original Message-----
From: Chander, Vignesh <Vignesh.Chander@amd.com>
Sent: Thursday, December 7, 2023 7:42 PM
To: amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Luo, Zhigang <Zhigang.Luo@amd.com>; K=
im, Jonathan <Jonathan.Kim@amd.com>; Chander, Vignesh <Vignesh.Chander@amd.=
com>
Subject: [PATCH] drm/amdgpu: xgmi_fill_topology_info

1. Use the mirrored topology info to fill links for VF.
The new solution is required to simplify and optimize host driver logic.
Only use the new solution for VFs that support full duplex and extended_pee=
r_link_info otherwise the info would be incomplete.

2. avoid calling extended_link_info on VF as its not supported

Signed-off-by: Vignesh Chander <Vignesh.Chander@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  |  4 +-  drivers/gpu/drm/amd/amdg=
pu/amdgpu_xgmi.c | 58 ++++++++++++++++++++----
 2 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index a21045d018f2..1bf975b8d083 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1433,8 +1433,8 @@ int psp_xgmi_get_topology_info(struct psp_context *ps=
p,
                         get_extended_data) ||
                        amdgpu_ip_version(psp->adev, MP0_HWIP, 0) =3D=3D
                                IP_VERSION(13, 0, 6);
-               bool ta_port_num_support =3D psp->xgmi_context.xgmi_ta_caps=
 &
-                                               EXTEND_PEER_LINK_INFO_CMD_F=
LAG;
+               bool ta_port_num_support =3D amdgpu_sriov_vf(psp->adev) ? 0=
 :
+                               psp->xgmi_context.xgmi_ta_caps & EXTEND_PEE=
R_LINK_INFO_CMD_FLAG;

                /* popluate the shared output buffer rather than the cmd in=
put buffer
                 * with node_ids as the input for GET_PEER_LINKS command ex=
ecution.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index 44d8c1a11e1b..dd82d73daed6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -823,6 +823,28 @@ static int amdgpu_xgmi_initialize_hive_get_data_partit=
ion(struct amdgpu_hive_inf
        return 0;
 }

+void amdgpu_xgmi_fill_topology_info(struct amdgpu_device *adev,
+       struct amdgpu_device *peer_adev)
+{
+       struct psp_xgmi_topology_info *top_info =3D &adev->psp.xgmi_context=
.top_info;
+       struct psp_xgmi_topology_info *peer_info =3D
+&peer_adev->psp.xgmi_context.top_info;
+
+       for (int i =3D 0; i < peer_info->num_nodes; i++) {
+               if (peer_info->nodes[i].node_id =3D=3D adev->gmc.xgmi.node_=
id) {
+                       for (int j =3D 0; j < top_info->num_nodes; j++) {
+                               if (top_info->nodes[j].node_id =3D=3D peer_=
adev->gmc.xgmi.node_id) {
+                                       peer_info->nodes[i].num_hops =3D to=
p_info->nodes[j].num_hops;
+                                       peer_info->nodes[i].is_sharing_enab=
led =3D
+                                                       top_info->nodes[j].=
is_sharing_enabled;
+                                       peer_info->nodes[i].num_links =3D
+                                                       top_info->nodes[j].=
num_links;
+                                       return;
+                               }
+                       }
+               }
+       }
+}
+
 int amdgpu_xgmi_add_device(struct amdgpu_device *adev)  {
        struct psp_xgmi_topology_info *top_info; @@ -897,18 +919,38 @@ int =
amdgpu_xgmi_add_device(struct amdgpu_device *adev)
                                goto exit_unlock;
                }

-               /* get latest topology info for each device from psp */
-               list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.=
head) {
-                       ret =3D psp_xgmi_get_topology_info(&tmp_adev->psp, =
count,
-                                       &tmp_adev->psp.xgmi_context.top_inf=
o, false);
+               if (amdgpu_sriov_vf(adev) &&
+                       psp->xgmi_context.xgmi_ta_caps & EXTEND_PEER_LINK_I=
NFO_CMD_FLAG) {
+                       /* only get topology for VF being init if it can su=
pport full duplex */
+                       ret =3D psp_xgmi_get_topology_info(&adev->psp, coun=
t,
+                                               &adev->psp.xgmi_context.top=
_info, false);
                        if (ret) {
-                               dev_err(tmp_adev->dev,
+                               dev_err(adev->dev,
                                        "XGMI: Get topology failure on devi=
ce %llx, hive %llx, ret %d",
-                                       tmp_adev->gmc.xgmi.node_id,
-                                       tmp_adev->gmc.xgmi.hive_id, ret);
-                               /* To do : continue with some node failed o=
r disable the whole hive */
+                                       adev->gmc.xgmi.node_id,
+                                       adev->gmc.xgmi.hive_id, ret);
+                               /* To do: continue with some node failed or=
 disable the whole
+hive*/
                                goto exit_unlock;
                        }
+
+                       /* fill the topology info for peers instead of gett=
ing from PSP */
+                       list_for_each_entry(tmp_adev, &hive->device_list, g=
mc.xgmi.head) {
+                               amdgpu_xgmi_fill_topology_info(adev, tmp_ad=
ev);
+                       }
+               } else {
+                       /* get latest topology info for each device from ps=
p */
+                       list_for_each_entry(tmp_adev, &hive->device_list, g=
mc.xgmi.head) {
+                               ret =3D psp_xgmi_get_topology_info(&tmp_ade=
v->psp, count,
+                                       &tmp_adev->psp.xgmi_context.top_inf=
o, false);
+                               if (ret) {
+                                       dev_err(tmp_adev->dev,
+                                               "XGMI: Get topology failure=
 on device %llx, hive %llx, ret %d",
+                                               tmp_adev->gmc.xgmi.node_id,
+                                               tmp_adev->gmc.xgmi.hive_id,=
 ret);
+                                       /* To do : continue with some node =
failed or disable the whole hive */
+                                       goto exit_unlock;
+                               }
+                       }
                }

                /* get topology again for hives that support extended data =
*/

base-commit: 44cb338138f7670ce2e1f8b9ef14e32c6ace282c
--
2.25.1

