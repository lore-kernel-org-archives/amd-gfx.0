Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82F4C282C5
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Mar 2025 05:17:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EC6C10E0F7;
	Mon,  3 Mar 2025 05:17:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VbHzTsJt";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4693F10E0F7
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Mar 2025 05:17:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lP+RIpQr2URmbzU10cN0IHwXhylQckfFFmItnmpfZr9e83nYQcoQerH/03jII9+eU53mI2SFqVARkrgFsY23Auka48A4lz25jjqzGKq37jSdcN148HBkJWSsRg0NOszBWmfXCKdErS+Uti8LFM38DT2A2s+5sNeyBXXib4UTw2OCOlBteQ4vsQA6Yu46XXrGGCH2JXE/CEscc2i9wV+wboTBjAEMnbn3HuyedAqf2YvR2oh4HzqAbN16X530xGyt0PgwgoPzFkVofbBOALkan95YBM6STn28/kv6GZuaaUudWfmXJJjCE9YAZespAf/QRmuznZoGO1g8TVeP3jogbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ga6cm23b4TZx+0St2myFjia4HMVDfhgMfYOANxQONK4=;
 b=zGZKa62ZvULfvFBmz3rKHBAYvBIyxtPNViHtI79I+4IItVNsmzdTMLAAU3K0v+lll8hIfSZcgNWYK6KK9TmrEFyftEZBGe3vn1U3pdg9XZkQVeBtNJv/XIpZdBX8JwOfnk4/BrmzyYeAXlQjkgtnlUhfwWjprOVPSxIdTy5LC1PBwIQl0jSGP9JQ6FLWp5MRaQsDDjtc2tqZ8OjrIyTIA0QYSbi/JOdqVmg9aJl0x+3H9aeMcQI6GAsXXU4hD2jHo/nTXdbY6bCeuif7lm8rYDlUzM9nQn/Bl9P0JswzlxeBJagURkQUTPdlmOt7yNEVis8uyEbO+8mBT5YvemMKlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ga6cm23b4TZx+0St2myFjia4HMVDfhgMfYOANxQONK4=;
 b=VbHzTsJt9vbWLUoVCl8xADjw0ek5YctUW1P3f1Wnutvo+XZZ2mpzx9R6pJ8BUKAl9VYjtpfWzpIId4AWY9gRiFiAXnOseaCGDRR1zmJGqmav6ald01P2dSGInWGNtSkQ0f4cnk8QJTe03HNrrqITsdOOEx54TyqEPzXELNjsUSI=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH8PR12MB7136.namprd12.prod.outlook.com (2603:10b6:510:22b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Mon, 3 Mar
 2025 05:17:37 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 05:17:29 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
CC: "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Set PG state to gating for vcn_v_5_0_1
Thread-Topic: [PATCH] drm/amdgpu: Set PG state to gating for vcn_v_5_0_1
Thread-Index: AQHbiRpEvHI/czKCiEuWjfehEv2Xz7Ng5NPA
Date: Mon, 3 Mar 2025 05:17:29 +0000
Message-ID: <BN9PR12MB5257CF6B5C1C03AEE41E1953FCC92@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250227131923.812619-1-asad.kamal@amd.com>
In-Reply-To: <20250227131923.812619-1-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=fe39c76b-1148-44b8-9676-f37c5419df48;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-03T05:17:10Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH8PR12MB7136:EE_
x-ms-office365-filtering-correlation-id: e105e431-4357-4441-ab3c-08dd5a12b1eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?qsOhOVoXk0yBu55JtBPnFYCcKQoPX8nuws78/ZeqyyT2d/7d1jruUwWzTR+J?=
 =?us-ascii?Q?IK65Z6EYzkbM8XH83byHqWKUhiqwRD/f7RlkDOHWOOnCqsDU6cJGEFuXAfIl?=
 =?us-ascii?Q?o3xqTCEx+25Wkt6ad0Ly2wgrhgwN9SdqVD4k7+PJAMOwmlx/GL36QYqGBnG3?=
 =?us-ascii?Q?FIcInIpEgt8E09djbQpTwooFlMRXRgHZm3RVZiDaHDznmXuuE5kEuXV+zOwZ?=
 =?us-ascii?Q?7lbxcLywQwkWmdoTHJj+W0QQ0cPmnSM7LLaWBbOZG5UYDKxbc+wnNiMrXc5W?=
 =?us-ascii?Q?QHzVkJK/lzm3NYo9ghhF54ccYLW7NECL3/8VHT+HC01IndLuKA0qtZESPx+y?=
 =?us-ascii?Q?oa9oix08r3J/Y3pKujYWG2KAsMo87DrdMpOlOeDfghgKuvidPqD+OfdCZZGj?=
 =?us-ascii?Q?ASFjJ5XlfNlmp3UO/RxZ8C9L7Ct+N26Nyb4jqyOI29lVaAT4/ZrzcynTznMO?=
 =?us-ascii?Q?8CWgzdHgAJ/GJsjKSLgjG4FMrwsHND5a2gV+qYKJ1RfibL4veAAy9w8Z2FsR?=
 =?us-ascii?Q?S+ImhSUxCs0Oe2fpYQsiPj7uTOr55M/qmTHbd1vLiA1MdkBI/XuKjOTkPblu?=
 =?us-ascii?Q?gRWg5DJVSeAUj+6/Ts4Vpi2RBLMbmYqOKMfBck7NUNTTGatsezgGvEZiqwZT?=
 =?us-ascii?Q?Ah1H6DXJjca+Rh/KLzoY0D3X0qFK61FGvPYUGfk0HxAv3fY8Ae72e8qY1k6F?=
 =?us-ascii?Q?slhTq4n0054+72qVtmuBjNUXqYkpgBng/yIlMNt+4t5TaAjrLzmuswr90TeA?=
 =?us-ascii?Q?0NyECMo1XPDrTmXp83RFATydLxHIeIbEVS2K0Bmj5OStWdsVzG8mLvjci2lg?=
 =?us-ascii?Q?VZvBEW5t7GogiKWlU3Nn0x3bcvdzIGDYTSHwP1UN1UzAmXRSEjdaFg5Uv24x?=
 =?us-ascii?Q?yZW7vjYp9corToFH98lWo+UbO4RxGV2qSEva4VrpSUL7x9iW033WGVtizf/b?=
 =?us-ascii?Q?JoEcBMlh4FVsjl8rcrADGL/US4ozxAGUGW5X3QdbfB1JaouSAOJIPZoV1Bsi?=
 =?us-ascii?Q?cCV+qBxm6YRXYPGUSiKnisv5UPGgSovki0yNXFJREl8SaZOzq5hAXJu1M0Yz?=
 =?us-ascii?Q?QLk493ifbdmSkcL/zvrZPdT38Tgm+vzSRQ8fm0R0fGXobsWGXwlJblE3syE2?=
 =?us-ascii?Q?tZneMK3Uys2IGCVt066wDJ2P2DHJTE7aZrPj9B41m3VUyGtT2pMat3dztkgk?=
 =?us-ascii?Q?shBzCjTQLtCXhxeEZVJCRukyyVQOs0111bLK4UESVd2DB3fyTvbLvmytK9Vz?=
 =?us-ascii?Q?9YqAvafcBurJ4gq3pbmnPrkNC/m4a3yaWLrEcVoIdo5om9eDhD6QbTEj91Ez?=
 =?us-ascii?Q?eyQogM/s/F5uzemsCBQfjguK0AWU2TANejW+tjnAecb6gU2MFLxdas0T047f?=
 =?us-ascii?Q?SfXZX9/KjXG+DOHbT0+7fVBoxeVnYkrbJWGgGE8TIBc9NnUFvv16oOq7kb8K?=
 =?us-ascii?Q?2tOQtdhwfPI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mP2yk+SozTSEnO2PrtYWFNxt5dPlmSq6kEEGhiyfVFWtxYEkGfmKwhOWcKJP?=
 =?us-ascii?Q?b8/Ka5qDU925btKZCQgirbcpYfT6atrZV9fzMKU63NaGButyn51SkyrI3hrs?=
 =?us-ascii?Q?tmh+BIMjbfwB+aKh2IlgcKwC+0GUVA7tkyXTNg+dAFz/cXicfRqhKG2m1Wa3?=
 =?us-ascii?Q?f+twL/6UvRgIAAKUR6ScupHnH+KaqYdZBywtZwgTHTJizymcNYV2XUOWcQgr?=
 =?us-ascii?Q?tr+4M+e73XMeXZn3zQc0sfEhy2GTG/4XtOYD8csq/4oh7JZQkHxIpsUgBbK2?=
 =?us-ascii?Q?0KqIIjYiz+m2ORJ+9WvmJvYhutZXxQSIB6WVy/z7uzlCMptaI5OlCYWuRslN?=
 =?us-ascii?Q?s07Yd2Qpfsm3EmGLOAXx060gMBqPUiyQebM6TFzRB2HwHZKhpovGwY4w/x3k?=
 =?us-ascii?Q?0SIk4Q7bHEENJgIDoqxP/Bk4IBTfZtPmR4th1UNlsQNlf3q8hwquwPxaeq1M?=
 =?us-ascii?Q?u1paZpTMVwoERZFOm4Oh3uffPxwcglfyZexGHnVmd3kOBu2Ojr36TjotVKUL?=
 =?us-ascii?Q?l2gzeaMl/30zkRCXzXC76ahU7tt5yphu4vSvMejGu9mfrSsZlMN9hEJo4L+/?=
 =?us-ascii?Q?Txl66l07YdtdhPhCMV73uMJOG0Lt14XMErHAxSxvQpUKfspnPrjUodEGx4Ju?=
 =?us-ascii?Q?EiPcp6BHJtgDBb6tUpRiBpfK+Wn1CMs0dhLBdN+UKJOg+Izs+ZaDs7XoyjIr?=
 =?us-ascii?Q?Cz+QwnfdY9ar56iTStFFJj3sj7lg2fz72zVKCH1CSKxDLB7gM5cuuad4Oe/y?=
 =?us-ascii?Q?lbOY0Y/q3uz1aUX7aHafLArGgRLWXelFY8nWEWLRfihJWLPPC7amT1Z3Gq2s?=
 =?us-ascii?Q?ffeJIgzHW/+JD5iTjCRl1/fo9/n0Rh3A2nL02ZHFlx8bQiX008WvLnP4q98o?=
 =?us-ascii?Q?p51U4WzMVd+kD/uhAHCdjSkKBd6iPdc2Eqj1+2x5CUIVQeNvrL9YZp7r7U4/?=
 =?us-ascii?Q?/55sa2Cwl1Dlwp0BULn7y19+4N/gu1VKo4dRhtvHIZ0Sebc0JxZd8FevFXlD?=
 =?us-ascii?Q?PiSyd1Taw+uOruhPMxgWZ9mDF6RcU8tTLkhoQx8qDKfOJ8h/Tb3FKLqZZyG8?=
 =?us-ascii?Q?gT4q4B6AVilBvSUBBwqY5kFRPhtBEx/+TzQo7eH+vOCmUdovP/Xb5guWtAIE?=
 =?us-ascii?Q?4RRw7nx0NRMX+EOz2L1zXjHD71q5GBV7P8YbkSmYnQYakmbztQgGkZUYpd60?=
 =?us-ascii?Q?INNVQU3kPvgpyklEPywlHF/Q09szUiQuO5A5W1tFbwwDMYdrUY0vRuQeqtbc?=
 =?us-ascii?Q?jBv+fLCNYymShiMWUme3a/OwWk3r2idT2/wplr8WP2tuYRdkyQozHRMRRyms?=
 =?us-ascii?Q?jW9fRczsBW/lbynB3Cp9lR95pSBN1R7gKulog3TVTJPHRBNtEHjVCQ8QywWa?=
 =?us-ascii?Q?Igah2d5QxLkDY2vFXBnk2kLin66keViSHhWfuQV9JeN1WRUopvoRPehIgUuH?=
 =?us-ascii?Q?q+WP0oeXSqEazxVNqAjH/D90Oe4DWjGaViYIbzurxZEb0z7np7O4M/x98hAG?=
 =?us-ascii?Q?VRgQbs2sxKw/ai9p5Iozkvbcfd1yXXH3UqqC0Wg5sV1mgJDVFQZlHIy7QG6X?=
 =?us-ascii?Q?O1VT05O7ewSQucSVTd0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e105e431-4357-4441-ab3c-08dd5a12b1eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 05:17:29.7113 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jc87fwGPodUG2ouAWx7s2YvDSDXIxpzIvBHqbBrXxvPP8KHhHE2WBZQAaWzq5Z5Q4kR/AxDLFX+1f/KkRSTU5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7136
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Thursday, February 27, 2025 21:19
To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, =
Morris <Shiwu.Zhang@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Deucher, Al=
exander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Set PG state to gating for vcn_v_5_0_1

For vcn_v_5_0_1, set power state to gating during hw fini. Also there may b=
e scenario where VCN engine hangs during a job execution, then it's not saf=
e to assume that set_pg_state works fine during hw_fini to put the state to=
 gated. After a reset, we can assume that it's in the default state, theref=
ore reset the driver maintained state. Put the default state as gated durin=
g reset as per this assumption.

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v5_0_1.c
index 900702b1a3bb..0273157c2bfd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -224,8 +224,13 @@ static int vcn_v5_0_1_hw_fini(struct amdgpu_ip_block *=
ip_block)
        struct amdgpu_device *adev =3D ip_block->adev;
        int i;

-       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i)
+       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
+               struct amdgpu_vcn_inst *vinst =3D &adev->vcn.inst[i];
+
                cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+               if (vinst->cur_state !=3D AMD_PG_STATE_GATE)
+                       vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
+       }

        return 0;
 }
@@ -268,6 +273,11 @@ static int vcn_v5_0_1_resume(struct amdgpu_ip_block *i=
p_block)
        int r, i;

        for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
+               struct amdgpu_vcn_inst *vinst =3D &adev->vcn.inst[i];
+
+               if (amdgpu_in_reset(adev))
+                       vinst->cur_state =3D AMD_PG_STATE_GATE;
+
                r =3D amdgpu_vcn_resume(ip_block->adev, i);
                if (r)
                        return r;
--
2.46.0

