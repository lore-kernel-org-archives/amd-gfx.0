Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE50DD26D6A
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jan 2026 16:00:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50D0910E8F1;
	Fri,  9 Jan 2026 16:00:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rcKewmDb";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011021.outbound.protection.outlook.com [52.101.62.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CAE910E8F1
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 16:00:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CjUmTxECZnjy4yVwnlIUIz1IBehP73dGofP+pg6vcBYR/eU+PnFuF6wn54Rd91yvOQNLwqyNSuVB2UkXbYMuQInZ+HSeyvCWRpQackPhnttmyS2gf2OoYI/cTBaUU8P0Yc4jD0bDcc78o9uWjfm2Pu5hLs/Ur2i0z0DdcXhX/uy6Zog+1o0vQpCmwOflCP4nDDcDfx1lbuep3j8Eo58+Tj6pFo01A+xoViFuPseZvqQU9sUZfjCVBOeSfybqU2nySlnzOjJWk24GrGGk5eSx+4Gdoqa4wp7xYCQhVnj79n+hTSN6UWJUfcYk0T0uXVHpkYkr9sogxxqBg89bi5kf8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uy4idOxNZOLq+4WXqB+OdVYkmRBIGcKFm2EvOzILpTw=;
 b=xQRi9E4rXtOkBfH69i+zGkQcgrENeIT81r0Ty0UF0Y7smZbh08vox9ilip8Wu7sB7WhJ+JBPh3e3/8p+hvczGEYvoVZUCL0eQHkW9AnwzDiahW826HJAi1JXqZGIDcCmhQD9Wvv8NZhz3t65jl6MFBITftoKXq5zpDKSCdr0poooSOGlDln3O5u87/4ZIT+1vagXbMAGkichL27i2OFwE4QUJDGhUtFN0j+liPpYs3I0clNaJEWLrV0Fk8qbuz9t83jKIW4VJWl8NSyCuTSZPTlSKqlIKeG3Tr1Pjh+e6OnqpbY+LZZB0dp4csUa5mZC9YdukbAybVu/54Lw/tXJsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uy4idOxNZOLq+4WXqB+OdVYkmRBIGcKFm2EvOzILpTw=;
 b=rcKewmDbzQ1HU1O1oxDzggehHGof7gl/TltCR77UmyXJZwtyhQ7L72/pDZRfUJ1qX1Ode8OhKhwvt2pmRwxqeqkall2pOeVMsLRCx3b3voXSH1Z9jwLDSF0rcMnXG4PVknCD82BFjrFJQnefrfO+vOdIwXATlE/eX/GtaObJ49o=
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 MW4PR12MB6997.namprd12.prod.outlook.com (2603:10b6:303:20a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 16:00:35 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.9499.002; Fri, 9 Jan 2026
 16:00:35 +0000
From: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>
To: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: kfd driver supports hot unplug/replug amdgpu
 devices
Thread-Topic: [PATCH] drm/amdkfd: kfd driver supports hot unplug/replug amdgpu
 devices
Thread-Index: AQHcZg73IJaeFB8CLkqxnQ5gPSbD47VF9+hA
Date: Fri, 9 Jan 2026 16:00:34 +0000
Message-ID: <DM4PR12MB6566FD3926C8DAC9183E08FEE382A@DM4PR12MB6566.namprd12.prod.outlook.com>
References: <20251205174647.492240-1-xiaogang.chen@amd.com>
In-Reply-To: <20251205174647.492240-1-xiaogang.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-06T23:13:05.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6566:EE_|MW4PR12MB6997:EE_
x-ms-office365-filtering-correlation-id: 720e38d6-2d1d-42fb-2edb-08de4f98396d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?aaRRmDaCPjjHAsfHJIphiE0O39eZhrCiVZAjPA0JR5F0lvrqgsHO49Jm/W+y?=
 =?us-ascii?Q?UVxx/nD4z1ayDW9G/8/S0pfGnyzDKaltVk1tB03wsisA8VnH+++L9aEaAqhs?=
 =?us-ascii?Q?OYVBkvuL1k5qFh5IJn63R0GQCwPlPRae8suzoRFWHQRqeax3IBQN/Bmd5/KI?=
 =?us-ascii?Q?pHOw4jG9VODQ/x/HU65WqCJj3k90e0yrZp3+dgSGdFFjnH/UFF88ANB1GpAV?=
 =?us-ascii?Q?wC6XrxNNoZq4O//6vvhyDvG/ojvHl97t05CO1HDrRCCXMULH7f2bwzlspq/T?=
 =?us-ascii?Q?Pj+xcytBrrULLVm2QKQ7p1WwGE74PfOTZIuBM7E3FH8WRJRVneqjxz0Vjq3c?=
 =?us-ascii?Q?rqJTd3TOhxLe77iESYGd6unWBo4/RUKkkAF0QvlnincgHQcBA/KOaOyYKqbD?=
 =?us-ascii?Q?D9wgMLhGDZCXvJcZTQI3+iTyb8Zwv3fMsgpRkXC72Q9dSJeAnq+YeeKa8AIe?=
 =?us-ascii?Q?oWsjc6iiG/Dnad1LrlpMFgF/aKKdx9kJNkvh/H1aJLrMuvAn17Zm+stNHx7+?=
 =?us-ascii?Q?+25UMkfeJl7KBShbYKJTh7wrKHvuFErZXg6ELE0YjV9qIdngwUrUs7VnfyxY?=
 =?us-ascii?Q?AEgfLKWOQapf+WWn92Al+z4B66sJq1JBvc17f3WEHtyTnAE57WAIsBAQjpma?=
 =?us-ascii?Q?LAqnjfuwmqVkYdbkmM061t0PC9a2MVhPNWqG+8PuJBUwBXX5ujvYhIHrGbw0?=
 =?us-ascii?Q?RA9s7bMWMCtg+XoZQ0OaJYfSzRByVi4joGHSaq+koKrsVyICGVnHOoRrDIt5?=
 =?us-ascii?Q?o9VvXPo+g2pETPrE0FkGcHdRF9wCCJWvMqVMKaEKgHaIWZnObHShyOkaNGH8?=
 =?us-ascii?Q?TF0jpCmLVbHTHaLMyZvWE/YbEQR8IKV6jphMs9FAJBkHQjIzME9ayiItgsIV?=
 =?us-ascii?Q?cNpuvUD+GLGb0/p1Uh31uL+Ac/8O4i/E17QlO+tzqaUjG8xweDdPGGYrhLZI?=
 =?us-ascii?Q?1BFTZa/7haDSRpCEBtDeCYkWTv+LI4CkJWSaWHEtyuGbX+zLoC5fOBTRZjuJ?=
 =?us-ascii?Q?dXNbY4EXx5LA+fZbsxDJqP4mKOVe7RyITPqfOKWe8zcvsvIdFYFa/rC6EujJ?=
 =?us-ascii?Q?o1hEZ5S1tU+MRGxr/d/9vWDmLBMYx9a6DE9AFqOqwB++jeX5BnHRyOnaG+pX?=
 =?us-ascii?Q?XzegMgQIVtytzTMacI0bh4BrZ8bXKj3bTqDmgRmscPqHc4n6MNVL6BmgWW0l?=
 =?us-ascii?Q?11CSX/l8aUPbfO9wEQPwa00HAXFpF23Wpa9KQZHl1Bq+qucLbMkXwtMf9msS?=
 =?us-ascii?Q?3zCXlfbLOM7p7d8Nqg75RC0UitX+JpytKFrDTk/jcjlCBLAoEUTq2LIiBT1a?=
 =?us-ascii?Q?ougvzgKELf6fDWzgoKlO7usSu5kuVMymAYY1MEt+LyseUqycVmI6GAXPGnsl?=
 =?us-ascii?Q?VT28s2W1abCDlLI6z1gSQPjnc5JiemXgytq3RxY4csF+/xDQA/YAafax+ZGk?=
 =?us-ascii?Q?V8XJzoqnQsg3d1wuUx5sbCDiNMVMsABDWU4PbOu3BkhgurCzcnu6/+f0eq5L?=
 =?us-ascii?Q?jq4r5rb/WqANcLpvgvSKUjJbtUNm32P657ZK?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kvSIlRCmuOtojA2v4Rlv0I7o1u4XPTvUS/0GYw73v64UHO8HfmqVhrNLUoF8?=
 =?us-ascii?Q?IeGg4OiNnzR5pU7PZjIh7XFclEyaMHTr3g53frwxgzI5mXRh7tdLglA2D4Rq?=
 =?us-ascii?Q?FssxvlYGvTsjFidZrUNQmt/E2UIIP2LOTT3FB09dKOzPvMhOOJoa5VWuwZh3?=
 =?us-ascii?Q?Suu8KzcWCRKeqZgaWTG1i4WD8rcIU8S3TcJ/wpDVuCja8IsUhwU78XNKIv99?=
 =?us-ascii?Q?pcuyd1fIG3ThHCSE2tgo0yCJ06lKUs2DSTYEWcZULY2q1hIcK154b9bAItEm?=
 =?us-ascii?Q?BKJgzRZmFcC9HGWRLA5zkLN6s9/xIoksoc0N2g37FdsmfxvKNdd8HabKKFYM?=
 =?us-ascii?Q?MKt/pt4CijlHlYPcn0wNxHnOVKG2yjPq1HArFbEQHys+vKw0nOP8dBz7RaLt?=
 =?us-ascii?Q?HCPY6/K4qgJLiDQ0IJg9CAg5nsCufZLdXA0MBdTGk2Ue3w2jugov7kU4l5jB?=
 =?us-ascii?Q?q4iEKc5dJfjdBmov9scQkZPt3gkv0OcUgFDWr/QcoVn0kcNPOX/aMRZ2EH+7?=
 =?us-ascii?Q?F1G7WVd+MV0s8b/blB2436mJidRPi1/sDTKmY1EeP5r0cy0SIimzTCwwMwaH?=
 =?us-ascii?Q?EuwcRm95lzilS/jNHPYCyGrhXDSSH8TnxFJouppDyZpETqnwF19lGNN2yKPL?=
 =?us-ascii?Q?KvFn/PEaiVYfI623CI9kStcDXot81rJ6p2INA2YOvWDFBD2CDhUSYW/YFELS?=
 =?us-ascii?Q?KgR3TsgDYsrIKDcD85jIfAJsjwza9wPh6mAWsr2x4lZ3Nr1kugvN3h5c3eGF?=
 =?us-ascii?Q?gs4XC9C+fWzfuoEoYuzujbb8IaGSZSrUKB9YGqIwPH+j8DiqKy0ASm68J8Sc?=
 =?us-ascii?Q?hgQMlRw+IziO2RmOIDfXGHONQtat3qCgFuQd8hr5tRcpyUu00O6tus3/NVdb?=
 =?us-ascii?Q?UVnlv6yHopdFRmJ1UA2IN5EmU8Ir1/U3/YHhf7YGqN9t6/LpjgywwMor5lNj?=
 =?us-ascii?Q?/DxuMHRjcVaBuBAMN5AMWadZD5Kwoj+YBlrkxjBBcI7ItIiTXkUhJ0OCmbSu?=
 =?us-ascii?Q?9XV/zJEfpjmNs2a78fRhTa9syJaj/BijNc1ZUSml7KXjF1B0BGgtWlf7wu9m?=
 =?us-ascii?Q?VoQceEnu4zCEs4/jCRzb0fis6rJMRQ+vA+t/skfwfZ0bynGyMAm6XTIlnmR4?=
 =?us-ascii?Q?J1zOeQiBET2S6Z/h6y4ZpJS7hVthi8lDxuST6B8X04QW+bwkOjcfSE6JC+vx?=
 =?us-ascii?Q?I1eTPQy5zFiSy8eEA0HtmlNjWn8zbWMDNeM3xkeqKQT1hbS/z2bom0as3SLQ?=
 =?us-ascii?Q?2sqKMru44B2miwU/EY3bj3zkNZzC8Qn03jdrR7KYn5fnnlouJBAGG7e91A6b?=
 =?us-ascii?Q?z9zsx1WTYgtxS6njPSzyqHyt39eWny3ppW7zbLmlD2A93P+gCS6pXJwVn9s1?=
 =?us-ascii?Q?yD2JZwAk2Z4TuanYBmRq/VhixodmYb4Hio0fhuRm6pKtzSC2vfo8dvwPOJoQ?=
 =?us-ascii?Q?si/VKBxzkw1zb59kVVj82cLcD54V9acrrCLjPC3aD/ApopsnfiwjCxwMafTS?=
 =?us-ascii?Q?RqNSDXx8PHQMn+jjYE5UjpTM5eYm0P4Q+zS3tlVVDTc5hdWqKK0PEiGeM7mT?=
 =?us-ascii?Q?dRnqpuKE8Qk1My5s+Q4xqAR6CFwhJRhx8lybGE8vcJilM1LwvtTg/uOAY1/8?=
 =?us-ascii?Q?r1S9KnD0RHmjfjvhBtS1Ije3/a78GjB0O4fTS2cCe2v8nfzCX38ZM12pb/Ar?=
 =?us-ascii?Q?GTGO8gp3SBeR4spWDE55iQ/wItI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 720e38d6-2d1d-42fb-2edb-08de4f98396d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2026 16:00:34.9735 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Sgt5vZm/Y9MuhIiL5J9YWKW5h6OR1cNJX2ZOo2cQEzwW0+mcnP75WP8VHxeBV8y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6997
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

ping

-----Original Message-----
From: Xiaogang.Chen <xiaogang.chen@amd.com>
Sent: Friday, December 5, 2025 11:47 AM
To: amd-gfx@lists.freedesktop.org
Cc: Chen, Xiaogang <Xiaogang.Chen@amd.com>; Chen, Xiaogang <Xiaogang.Chen@a=
md.com>
Subject: [PATCH] drm/amdkfd: kfd driver supports hot unplug/replug amdgpu d=
evices

From: Xiaogang Chen <xiaogang.chen@amd.com>

This patch allows kfd driver function correctly when AMD gpu devices got un=
plug/replug at run time.

When an AMD gpu device got unplug kfd driver gracefully terminates existing=
 kfd processes after stops all queues by sending SIGBUS to user process. Af=
ter that user space can still use remaining AMD gpu devices. When all AMD g=
pu devices at system got removed kfd driver will not response new requests.

Unplugged AMD gpu devices can be re-plugged. kfd driver will use added devi=
ces to function as usual.

The purpose of this patch is having kfd driver behavior as expected during =
and after AMD gpu devices unplug/replug at run time.

Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  5 ++  drivers/gpu/drm/amd/am=
dgpu/amdgpu_amdkfd.h | 11 +++  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |=
  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 78 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_events.c    | 29 ++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  2 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 12 +++-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c  | 22 ++++++
 8 files changed, 158 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c
index a2879d2b7c8e..622f613e7627 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -248,6 +248,11 @@ void amdgpu_amdkfd_interrupt(struct amdgpu_device *ade=
v,
                kgd2kfd_interrupt(adev->kfd.dev, ih_ring_entry);  }

+void amdgpu_amdkfd_teardown_processes(struct amdgpu_device *adev) {
+       kgd2kfd_teardown_processes(adev);
+}
+
 void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool suspend_proc) =
 {
        if (adev->kfd.dev) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h
index 8bdfcde2029b..f79e20cadd70 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -155,6 +155,7 @@ struct amdkfd_process_info {

 int amdgpu_amdkfd_init(void);
 void amdgpu_amdkfd_fini(void);
+void amdgpu_amdkfd_teardown_processes(struct amdgpu_device *adev);

 void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool suspend_proc);=
  int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool resume_proc); @=
@ -434,6 +435,8 @@ int kgd2kfd_stop_sched_all_nodes(struct kfd_dev *kfd);  =
bool kgd2kfd_compute_active(struct kfd_dev *kfd, uint32_t node_id);  bool k=
gd2kfd_vmfault_fast_path(struct amdgpu_device *adev, struct amdgpu_iv_entry=
 *entry,
                               bool retry_fault);
+void kgd2kfd_lock_kfd(void);
+void kgd2kfd_teardown_processes(struct amdgpu_device *adev);

 #else
 static inline int kgd2kfd_init(void)
@@ -546,5 +549,13 @@ static inline bool kgd2kfd_vmfault_fast_path(struct am=
dgpu_device *adev, struct
        return false;
 }

+void kgd2kfd_lock_kfd(void)
+{
+}
+
+void kgd2kfd_teardown_processes(struct amdgpu_device *adev) { }
+
 #endif
 #endif /* AMDGPU_AMDKFD_H_INCLUDED */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index f75ede1b1c6b..dd8fc2d42b69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3663,6 +3663,7 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_=
device *adev)
        amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);

        amdgpu_amdkfd_suspend(adev, true);
+       amdgpu_amdkfd_teardown_processes(adev);
        amdgpu_userq_suspend(adev);

        /* Workaround for ASICs need to disable SMC first */ diff --git a/d=
rivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_dev=
ice.c
index e3da2f149ae6..30d87e4daad2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -936,6 +936,9 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
        }

        kfree(kfd);
+
+       /* after remove a kfd device unlock kfd driver */
+       kgd2kfd_unlock_kfd(NULL);
 }

 int kgd2kfd_pre_reset(struct kfd_dev *kfd, @@ -1519,10 +1522,14 @@ int kgd=
2kfd_check_and_lock_kfd(struct kfd_dev *kfd)
        return r;
 }

+/* unlock a kfd dev or kfd driver */
 void kgd2kfd_unlock_kfd(struct kfd_dev *kfd)  {
        mutex_lock(&kfd_processes_mutex);
-       --kfd->kfd_dev_lock;
+       if (kfd)
+               --kfd->kfd_dev_lock;
+       else
+               --kfd_locked;
        mutex_unlock(&kfd_processes_mutex);
 }

@@ -1686,6 +1693,75 @@ bool kgd2kfd_vmfault_fast_path(struct amdgpu_device =
*adev, struct amdgpu_iv_entr
        return false;
 }

+/* check if there is kfd process still uses adev */ static bool
+kgd2kfd_check_device_idle(struct amdgpu_device *adev) {
+
+       struct kfd_process *p;
+       struct hlist_node *p_temp;
+       unsigned int temp;
+       struct kfd_node *dev;
+
+       mutex_lock(&kfd_processes_mutex);
+
+       if (hash_empty(kfd_processes_table)){
+               mutex_unlock(&kfd_processes_mutex);
+               return true;
+       }
+
+       /* check if there is device still use adev */
+       hash_for_each_safe(kfd_processes_table, temp, p_temp, p, kfd_proces=
ses) {
+               for (int i =3D 0; i < p->n_pdds; i++) {
+                       dev =3D p->pdds[i]->dev;
+                       if (dev->adev =3D=3D adev){
+                               mutex_unlock(&kfd_processes_mutex);
+                               return false;
+                       }
+               }
+       }
+
+       mutex_unlock(&kfd_processes_mutex);
+
+       return true;
+}
+
+/** kgd2kfd_teardown_processes - gracefully tear down existing
+ *  kfd processes that use adev
+ *
+ * @adev: amdgpu_device where kfd processes run on and will be
+ *     teardown
+ *
+ */
+void kgd2kfd_teardown_processes(struct amdgpu_device *adev) {
+
+       struct hlist_node *p_temp;
+       struct kfd_process *p;
+       struct kfd_node *dev;
+       unsigned int temp;
+
+       mutex_lock(&kfd_processes_mutex);
+
+       if (hash_empty(kfd_processes_table)){
+               mutex_unlock(&kfd_processes_mutex);
+               return;
+       }
+
+       hash_for_each_safe(kfd_processes_table, temp, p_temp, p, kfd_proces=
ses) {
+               for (int i =3D 0; i < p->n_pdds; i++) {
+                       dev =3D p->pdds[i]->dev;
+                       if (dev->adev =3D=3D adev)
+                               kfd_signal_process_terminate_event(p);
+               }
+       }
+
+       mutex_unlock(&kfd_processes_mutex);
+
+       /* wait all kfd processes use adev terminate */
+       while (!kgd2kfd_check_device_idle(adev))
+               cond_resched();
+
+       return;
+}
+
 #if defined(CONFIG_DEBUG_FS)

 /* This function will send a package to HIQ to hang the HWS diff --git a/d=
rivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_eve=
nts.c
index 5a190dd6be4e..ea913368e231 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -1380,3 +1380,32 @@ void kfd_signal_poison_consumed_event(struct kfd_nod=
e *dev, u32 pasid)

        kfd_unref_process(p);
 }
+
+/* signal KFD_EVENT_TYPE_SIGNAL events from process p
+ * send signal SIGBUS to correspondent user space process  */ void
+kfd_signal_process_terminate_event(struct kfd_process *p) {
+       struct kfd_event *ev;
+       uint32_t id;
+
+       rcu_read_lock();
+
+       /* iterate from id 1 for KFD_EVENT_TYPE_SIGNAL events */
+       id =3D 1;
+       idr_for_each_entry_continue(&p->event_idr, ev, id)
+               if (ev->type =3D=3D KFD_EVENT_TYPE_SIGNAL) {
+                       spin_lock(&ev->lock);
+                       set_event(ev);
+                       spin_unlock(&ev->lock);
+               }
+
+       /* Send SIGBUS to p->lead_thread */
+       dev_notice(kfd_device,
+                       "Sending SIGBUS to process %d",
+                       p->lead_thread->pid);
+
+       send_sig(SIGBUS, p->lead_thread, 0);
+
+       rcu_read_unlock();
+}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h
index 76842bb8e78b..d7b4aba0f488 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1177,6 +1177,7 @@ static inline struct kfd_node *kfd_node_by_irq_ids(st=
ruct amdgpu_device *adev,  }  int kfd_topology_enum_kfd_devices(uint8_t idx=
, struct kfd_node **kdev);  int kfd_numa_node_to_apic_id(int numa_node_id);
+uint32_t kfd_gpu_node_num(void);

 /* Interrupts */
 #define        KFD_IRQ_FENCE_CLIENTID  0xff
@@ -1529,6 +1530,7 @@ void kfd_signal_vm_fault_event(struct kfd_process_dev=
ice *pdd,  void kfd_signal_reset_event(struct kfd_node *dev);

 void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid);
+void kfd_signal_process_terminate_event(struct kfd_process *p);

 static inline void kfd_flush_tlb(struct kfd_process_device *pdd,
                                 enum TLB_FLUSH_TYPE type)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c
index f5d173f1ca3b..5a74469f5bef 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -854,6 +854,12 @@ struct kfd_process *kfd_create_process(struct task_str=
uct *thread)
         */
        mutex_lock(&kfd_processes_mutex);

+       if (kfd_gpu_node_num() <=3D 0) {
+               pr_warn("no gpu node! Cannot create KFD process");
+               process =3D ERR_PTR(-EINVAL);
+               goto out;
+       }
+
        if (kfd_is_locked(NULL)) {
                pr_debug("KFD is locked! Cannot create process");
                process =3D ERR_PTR(-EINVAL);
@@ -1176,7 +1182,6 @@ static void kfd_process_wq_release(struct work_struct=
 *work)
        if (ef)
                dma_fence_signal(ef);

-       kfd_process_remove_sysfs(p);
        kfd_debugfs_remove_process(p);

        kfd_process_kunmap_signal_bo(p);
@@ -1192,6 +1197,11 @@ static void kfd_process_wq_release(struct work_struc=
t *work)

        put_task_struct(p->lead_thread);

+       /* the last step is removing process entries under /sys
+        * to indicate the process has been terminated.
+        */
+       kfd_process_remove_sysfs(p);
+
        kfree(p);
 }

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_topology.c
index 5c98746eb72d..062ad5d40d62 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2349,6 +2349,28 @@ int kfd_numa_node_to_apic_id(int numa_node_id)
        return kfd_cpumask_to_apic_id(cpumask_of_node(numa_node_id));
 }

+/* kfd_gpu_node_num - Return kfd gpu node number at system */ uint32_t
+kfd_gpu_node_num(void) {
+
+       struct kfd_node *dev;
+       uint8_t gpu_num  =3D 0;
+       uint8_t id  =3D 0;
+
+       while (kfd_topology_enum_kfd_devices(id, &dev) =3D=3D 0) {
+               if (!dev || kfd_devcgroup_check_permission(dev)) {
+                       /* Skip non GPU devices and devices to which the
+                        * current process have no access to
+                        */
+                       id++;
+                       continue;
+               }
+               id++;
+               gpu_num++;
+       }
+
+       return gpu_num;
+}
+
 #if defined(CONFIG_DEBUG_FS)

 int kfd_debugfs_hqds_by_device(struct seq_file *m, void *data)
--
2.34.1

