Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFDF4C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 06:32:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48015113841;
	Wed, 24 Apr 2024 06:32:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yNhnAPXS";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41AD9113841
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 06:32:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzCkq/w+CcpPeukrEbxSFj/l+hmeOkenOOp2zuxvCorju+axpFSJAFnnSiGt0smW2RKIYw4TQhIBRMiqXo1fT4kxuoYTsTjSpDMoC4Lky/PJdQRxvW3hh6OpBxVdtFPH/pk7WN/DmHtpOzT8JZAsfhMZtSYLJLoYxDvKhCtPl5AiXCgSgaEeRcJa6m3P/yjQ71cBcbNKyDOuCvktTZkUFa+/+h39K7LQrvhQ2QBRRgmH2FWEUfNMYItc16TWDojenQUzEeJNFskD4I+bS0NBcwh3PP9Qo6Rcj22sD26Low/KfaZ8ve2ZTYdAmJKCcecqpgdYZTzySYZLHmOnZoEHDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZxmjdH9L7YME4JK6L9hyePm2GSHQdc+LKaDSCcb0Ks=;
 b=QubGUH/7Z550gZAdQnLC9GHLOG/HP/6NY7mgmMLRtzhz53TAy+5RBB+JICOtpE3OYp8BNfzZIxmKroy9QG8kr3zbJEotpLGJsVa4hQ+63qcWXmqD64HkOkWpnZTNDrUA3gMN4j4CGqW0+lQCq1tP0jJFkmV18GzZGcMFzaSg1hk75I1Ho5fwmTAq8aE4o28L0+u1l6ye+zrrDwBlOQDU9IGbKRvDRu1+PUSBh7ZPjJEWTcERprV3Bop5HPRQejwr6COcS0/5KYBdVTiSd3weCV685FXgXH0Ry4ycyOkDLIaU+yPQDTF2vnpeCX0FAYR7H9frpTv0P2Do0Xa/s6ycNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZxmjdH9L7YME4JK6L9hyePm2GSHQdc+LKaDSCcb0Ks=;
 b=yNhnAPXS9ip2RCxTJs8FEOLPjj3nLbezMciJg75y4POvBrW4zSoVrnN2tjkzQ/x7Veapdwx+gwWE624F1g9Mtwv4LRV/F8/9EKfzJrEZtlV8p0DMxs7SYK/ANM4z6qGQN30MuWNmrO27sk3NODpaBbbrFPru/Qw5gBRao1cLPe4=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by PH7PR12MB6442.namprd12.prod.outlook.com (2603:10b6:510:1fa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 06:32:16 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::6d24:19fb:11d3:b00e]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::6d24:19fb:11d3:b00e%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 06:32:16 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>
Subject: RE: [PATCH 3/4] drm/amdgpu: Using uninitialized value new_state.jpeg
 when calling adev->vcn.pause_dpg_mode
Thread-Topic: [PATCH 3/4] drm/amdgpu: Using uninitialized value new_state.jpeg
 when calling adev->vcn.pause_dpg_mode
Thread-Index: AQHalfIcCJn1peoas063MUBZhIIR1rF29FDQ
Date: Wed, 24 Apr 2024 06:32:16 +0000
Message-ID: <DM4PR12MB5152E336B383A22D150C3FA5E3102@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20240424024955.727542-1-jesse.zhang@amd.com>
In-Reply-To: <20240424024955.727542-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7b52acf0-5058-4a08-954e-9c21d9ad35fc;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-24T06:24:46Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|PH7PR12MB6442:EE_
x-ms-office365-filtering-correlation-id: e5599517-5bf0-482c-9d88-08dc6428490b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?KbYFGJw5gEsugN/mJX8BKnr4Hkgvg9frAyMYlJUqiQyo6lpoNyuCLtWuHjbJ?=
 =?us-ascii?Q?/HTmDJ+XH09t4VLmbFIOGSv38cAmr4gFSt9kA1m+T2ogq3OO/ugzTIqM/iCr?=
 =?us-ascii?Q?fVfK2XUfdWhzyWKgOr4o1BAMxvpnra2Ewlj11Z5yxuer2xjcWB4bm/xtdVAz?=
 =?us-ascii?Q?VzUYAArwqr6BMxFtY+p3kt+dn7dG4vFuCj+Y5/qziOrpKv6zrnJ6VoQNrKNo?=
 =?us-ascii?Q?jTD9lDs5G+KkF4yzIJRu/7I4KebzjAUalwST3Af65S0yFg+ZLwHDJT4LXGPb?=
 =?us-ascii?Q?pnypC/uMg5vDgW+Ni2a+/ySYZ6WcQLBoquq3AzI/sgBgB9ZZtmQ4qfNH0HIJ?=
 =?us-ascii?Q?3BVoZ0aNafq/VhmF/IHKdHfcz/DafQKGrJ38/cedgknnEw+p/TkRdYOz2F72?=
 =?us-ascii?Q?rOg5ogva7UQY3UAmxDvmKrtDT0RHxR3ZF0vZqtIuLT2j4j2BK3vr7iap8CGN?=
 =?us-ascii?Q?B6DImucQmEL6ZdCnv3V99GIuBIajCToth283djuK0dq//Daq7UtC1Uv3DnbA?=
 =?us-ascii?Q?nHN0cFqPWHQSx9dCU1tkzRpQM0YGWQJcKlUu2/M9JfFuTn8lTLMNl387GTTG?=
 =?us-ascii?Q?vLRVVFWB+PEeJJN7COJkm3voBPPxuJ5SalHtLK+NbcxHhGs4+XXwnU0Q+JZa?=
 =?us-ascii?Q?Ry3OnESlhTmn1+QSlGAZBrqES3LdDOBQtqEk+BkR67xE15SrXFXT6f9Y7WSQ?=
 =?us-ascii?Q?6YY4h5PUKxTNsmt+cXJJDq4be46LY7pO3sMXKXNMQWq6mbPDIJqAQJbodBbp?=
 =?us-ascii?Q?iLCNErgC62dMoHCpEbpYePQz+1Y07tVAGZHDtI4JzL2vK2g8y3c2w9kfozTH?=
 =?us-ascii?Q?iady55QNaL83g8Y1D84jdxYbAFgbCLtdSXwZD1qgxjB3fPlv1yiZGnH8nVU/?=
 =?us-ascii?Q?KIPfSq97DfoPH0CW2CCTviTK3HlwXkEs1Db62z5GmCruXggSsAwoMvcNRvZN?=
 =?us-ascii?Q?W13wYDCGJRoTtDpFPe8RNVaYYjLMoG41u59TYsOEoebXpcz0aImg111Lpahv?=
 =?us-ascii?Q?HM8OAnOnu5X2KBdWZYUjaY8YdJWA++zaAd+U25+aO+v/nHNxE+MMfor22FEq?=
 =?us-ascii?Q?onHn3ojM+0+n1lBqUykhd8o3WCje03jm2iwqAcSem8kSp9IZCxDF5nVdCmGv?=
 =?us-ascii?Q?y+Oty61w5plaZ7MmLbKlCTi8rmBV0DclhMj8qKddl0r0pflu2D5TCzfFOzAW?=
 =?us-ascii?Q?8AH6Q7+WFlqDjGb3NOcfHF8VnxDrwuxaOmndnXIXPfC7qrgDF9zYuZjvYB4N?=
 =?us-ascii?Q?fxGnEv0eaO1FhgreMb1P7uPf0a5D/bugkVWtgxyN3tqgRabPKD6v1f2Og8GP?=
 =?us-ascii?Q?NEcsYELt2RgqGWP66pknSkI51CB12Flq+msTkw6ztrOW3g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YzWbuSbfXvn8pD2wJ9Z9lmMV5tYekTl2DRqBkkZY5QJ8IMBzc08Exq7SJOEP?=
 =?us-ascii?Q?FE3gCk7pak3JSFSvGQZ1P2G3R3Fw4sZGB92R1ieYUOtaiYlszZtaJVZDKkvN?=
 =?us-ascii?Q?a2T0rX+M+RbP1vIoP5XimnFMnlI/JlkphkXtiXWEWVc9oKTWMcxbys7beQOJ?=
 =?us-ascii?Q?17qPkaeGqN8bvs3eCTMJmlM8E8pf8eFoyGxOhFf6mZVtAnNLTXZOuuLkpc1B?=
 =?us-ascii?Q?muw1hc6dpyr4T1Qn1UIxoCkOhRtEqyPUlOJlrX1LgQj3Dep6BWlM0lcIAvHl?=
 =?us-ascii?Q?8KxeE5VWpDRoA/FvLdTsbr/hUBcfRT5sHB9O6OH0UUd9jdxgiUXnvViTlHqo?=
 =?us-ascii?Q?2rWdyfvDNcBWQFiR/TXWzuy0d/m4IBH4i846KWqBeDlfYtOQfHMGmnFODaEE?=
 =?us-ascii?Q?BgsEWtsMQz0L9ZaX33u7oPDRiGuwkZ2lYKG5vBu5K1rxMhul2V3dxBizcT81?=
 =?us-ascii?Q?ubjEM5gVGw0Ee9nXjooe4jdwjO6Qmt9PpWk+Y2nWtO0qvdfIb2lxXMttktUt?=
 =?us-ascii?Q?rycqCXIDW+pY3S3l3nlN9QDAp2hGFgZMe9lui1shk0ccXiSk+vtgwxFh4ywQ?=
 =?us-ascii?Q?0MG1OcLl2bmAHA+r5U+sJbbNtzj7dYmJkzB83PhZmGMRtbCrpij6KYViPFdJ?=
 =?us-ascii?Q?H18sZnICImK5kVoG3liuuzS+jnM7QCLP18P7RhwxxX8ywXE/SqTUaLcLcvuV?=
 =?us-ascii?Q?4/K15DOhRWO90LoQ20AeMTeMf/v3czAwxhLYp1VY4aNS0lEE12cNl0F2X/XR?=
 =?us-ascii?Q?fV/DE/ilv/xUqXTbP6VkP1JJrxnSwSMGnfEuUtKjlVcfJu5PU3GG2vi+ilQq?=
 =?us-ascii?Q?ns4RHWkW/anO6tOZVcm8n8yR7Yp7Au5mIKUMSJzbd2g+KL53+UEHCRkS5i9N?=
 =?us-ascii?Q?jpji+AGfDZ0NsV56cvOR8wUgc8RoXT6WCUa0OM6f81vIePwt9GO1BrugHlyy?=
 =?us-ascii?Q?x1zwf0lgdUWtPoMq14aGtFK7o2ryoj4kppRZE3sJ7nfmIukVPbo7Rgkl3ZDg?=
 =?us-ascii?Q?XGt6uv24eVI//iHO4URp3cAWey1lxpaLPppa+KBDzBrwGRZy+wdvZcM7rlkR?=
 =?us-ascii?Q?RoEOlmtYXWLpf4isRonQ0Olc6ZNgVnZiBOK3YSZYE9kqvf4btYBEcPjG+WXG?=
 =?us-ascii?Q?8VBaMrNW8MJDvdA3HnnEPU9srvd3HhmibmjLNN5mtI6P2JIy8xn6RyDj6FDr?=
 =?us-ascii?Q?H4gr+8SVhYK9HWg+LN62w91lQEDIO+CAHxn3M+EGFbHHEz+S4pKIbMcfsp+K?=
 =?us-ascii?Q?2EWSbyrjn4MLWkxt0ClGOMKFa/Tal7oo3rXtmvYnt+VBKv8DcWUMA2EEttn/?=
 =?us-ascii?Q?goLHvxzUncgqV6Lictr65g4gfbhbRpcTj5dtCHITyYq0hTAym1GvuA6MNPPj?=
 =?us-ascii?Q?PiEYMvwUhkmpDs9ztNlkY4LA2/0FzFRHW5raiF5UCNbqqJBuTmDfCGVgj9Vl?=
 =?us-ascii?Q?c+gwviT1a/rbT+hEjtNFoJtf7EQoYNexrUO9ohIa3Xuc+w0gJmqlKQr5IXwQ?=
 =?us-ascii?Q?JS3bcXy2L74NSwSrfgEnDDIikvvexxHYfPGcwyd01WZnP1Q1lPQzUugdIhV7?=
 =?us-ascii?Q?7c5Jz1HNd6r+0eF0yD0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5599517-5bf0-482c-9d88-08dc6428490b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 06:32:16.6395 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QmWL7Eq2NgPrUS6IOITIGFoNg5IC4/ZotzhhnBzvZe9NyCWVSmeBoGobcvUcD7bEP24Ip7HUb+IgaYUOR3Kq2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6442
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

[AMD Official Use Only - General]

Please ignore this patch:

For vcn_v1, it override the idle work handler and initialize new_state.jpeg=
   at the function vcn_v1_0_idle_work_handler.

/* Override the work func */
 adev->vcn.idle_work.work.func =3D vcn_v1_0_idle_work_handler;

-----Original Message-----
From: jesse.zhang@amd.com <jesse.zhang@amd.com>
Sent: Wednesday, April 24, 2024 10:50 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang, Jesse(Jie) <J=
esse.Zhang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: Using uninitialized value new_state.jpeg w=
hen calling adev->vcn.pause_dpg_mode

From: Jesse Zhang <jesse.zhang@amd.com>

Initialize the new_state.jpeg before it used

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c
index 677eb141554e..13125ddd5e86 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -410,6 +410,11 @@ static void amdgpu_vcn_idle_work_handler(struct work_s=
truct *work)
                        else
                                new_state.fw_based =3D VCN_DPG_STATE__UNPAU=
SE;

+                       if (amdgpu_fence_count_emitted(adev->jpeg.inst->rin=
g_dec))
+                               new_state.jpeg =3D VCN_DPG_STATE__PAUSE;
+                       else
+                               new_state.jpeg =3D VCN_DPG_STATE__UNPAUSE;
+
                        adev->vcn.pause_dpg_mode(adev, j, &new_state);
                }

--
2.25.1

