Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC562CE8340
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Sep 2024 13:22:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6472210E4A4;
	Mon, 30 Sep 2024 13:22:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mdcf6oZo";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65D7F10E4A4
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 13:22:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/oyvhwfgw89PtW8hVMNxvnGHqWbUcWo5AlaKzDg0sPDST21Bw/RCBgBOU1qElFStuiXtz7xs7GQt77dWTc1ZnIqtAYCAxzwtDfghWirawjdnOZpNzkIRxirAML4JAdQit3Jt4st6x4IvAx1O3a/0RgM9YI41ohcMlyywqwepxRCxJGOnOgtVJ1QCAjCugD1r7BbAO0KM9Q2AX/YzpcmvdrCpnSISsdFlILlzxOAx83Zre1fliqD4LgFI4N5D8IXO59ncEfuEVSi+Do8IbP8/RgYofMsOxDdVv5IigM/1QhnnrkMY/cI4K2bFH7SviAKEtIyGTMlZkqx1U4X5yFfxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3Bkw0LSjPmq9RzpYKWTCAWJ3hs4fM3CpFPUNNfpkY8=;
 b=Xjdcky6JyqbMNz56LqgJiyw358G1y9cfy6iuxuXCkDauCLCwtyLuaBBXJeS5wkWtY5dDsv4sFP+sXde+4VRXHgmgTA4y47+wgbkUThtDTw1eS5tSudeK/0/ctlXAv9kCZvLJ0TXXsoIWrZ6fzX6LuSJLKk32FBks37Mpsm5QbRsWuvs2gJaGDTWvhUgF5WRQ5hLfMf4FkEWG0B66IBKenBPNjxC1XQ+Dpps64bPUq+9+mkgcsy3BR7lLDwtfRrno754jTN9qPn1mDn/Nol8w4nMhCsKxQX7sXj9tqGAUu89o4M68cZeKAvJm73obScNg6/T0lBIlRcvEcSuk9zek2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3Bkw0LSjPmq9RzpYKWTCAWJ3hs4fM3CpFPUNNfpkY8=;
 b=mdcf6oZoHWHmWnbZnw+47kvTJS/KrKNxHgwCYzuuBNiZ1GAZrws5DzysTTNK0wNOXZgSoQdGqQfqlx+7kioqQZ2nkpUoft5Uir0WB3BsPFQE48QuWgKkaXkEVI58mqkrVpEkZscDLxMTA7ELGVv/fYwWfQVnvl2M+D+wNJ2efH4=
Received: from DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) by
 IA1PR12MB6482.namprd12.prod.outlook.com (2603:10b6:208:3a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 13:22:20 +0000
Received: from DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::6f01:2f45:71e4:653d]) by DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::6f01:2f45:71e4:653d%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 13:22:19 +0000
From: "Bhardwaj, Rajneesh" <Rajneesh.Bhardwaj@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix logic to determine TOS reload
Thread-Topic: [PATCH] drm/amdgpu: Fix logic to determine TOS reload
Thread-Index: AQHbEzNFEMGc2AWdSUCyYyifXH7MCbJwUOeQ
Date: Mon, 30 Sep 2024 13:22:19 +0000
Message-ID: <DS7PR12MB5933DE30B33901A022233F92FE762@DS7PR12MB5933.namprd12.prod.outlook.com>
References: <20240930122103.2918787-1-lijo.lazar@amd.com>
In-Reply-To: <20240930122103.2918787-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=f0180aca-54c7-4ce4-ab18-4751ee5a77c5;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-09-30T13:21:36Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5933:EE_|IA1PR12MB6482:EE_
x-ms-office365-filtering-correlation-id: abae8b16-c54a-4f1b-7c7c-08dce152e960
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?5cLYaWtrzOElQGEW8ezCgThkJ8grk8WV3vsPLLFe01OTSM78NugPdp5MoYv3?=
 =?us-ascii?Q?lq9s1gTcFR6jJbeoW7BTxQ/edAZCQSD7a8qht2gjrZrquiU+i/s05FhjJO3l?=
 =?us-ascii?Q?9gM1uDT8GVqXneyk2W9rf823WlvHFr301D9uUSOFHdQ5Tl2bG8DhKPH5wO00?=
 =?us-ascii?Q?D8srN3h1HNPMHXZv6x1GRQWCYuQ6Xz4Z1fKahlsXWJMQmxdzFkorZ6qPhyFu?=
 =?us-ascii?Q?v9V9ytYbyQuxC8JkG8slquPCq9l72I1oEAQiF8R4dKwMS15n3znm3wl5r4EM?=
 =?us-ascii?Q?o2ECcqHzqjCGt7jMsyxK28irPD2lvzeeFYFkqTNTGs5A4y8Dk0UX6o2/a2Ys?=
 =?us-ascii?Q?4E2RuJNpsE6FxyCuoie17Z3yIxUlYfOSzc4Asr12e2+jSm8+XjEPOl3hnlLs?=
 =?us-ascii?Q?KRp1Cv1h7X7G2skpRgQSJQoGo6c0XPbu5ivegOKulqSiU2Db9ApT2H9lsnOa?=
 =?us-ascii?Q?orLm04XUnp9cyHRkyxsKTbJqoxGwHf6z0OkouIf6iaFJrp3DJnJnlknXREMi?=
 =?us-ascii?Q?0CONWLQKMoE6JHn9/6owvB6uSmqaulprKXWjnaO4mslt8DTrDTZlvkPQN2g5?=
 =?us-ascii?Q?uFYXiYJCTgVjoNVJjO6URJD7EWlTN/C15Aq6g+yYQwg8oPODQeXszg5I92ZL?=
 =?us-ascii?Q?rZ+7mpR8+fI4/eyT1yLnWVk6OzpL41sbuFj/cJISVwhwNR6bXalCUcrc65Ne?=
 =?us-ascii?Q?iYJ3qFtvP9ufphEJSpACi8xZraTIVcohIESCTeVdBcSJq5EcXvimfR6omOqw?=
 =?us-ascii?Q?IQhx866hKWBBo1cwenUJbFSOBi2O8pPFDZaoSTMUxJrjjbblxxwkgGbkhIJx?=
 =?us-ascii?Q?3iOuP3MljEoKQtNlLk/gfh/E0puOKjgfgT459zuiRkpiQWyxp//GZFtvQsCZ?=
 =?us-ascii?Q?B/ePg7fjwrTssUMWHmr2tMNtoG7t1k9qhmvinwFdyOHmup7MxARPVP8Klmu4?=
 =?us-ascii?Q?/lI8nexMchx+QEjToHMtkR9uYmlQ6RwfAhp4Fx3+mr21QSA+LrUI4nbBH42g?=
 =?us-ascii?Q?BOTHIdrs+zYjIlFMFSd+u2XevSeQTmuXM1nVib/r/N9YI1dWUjba7cDcoyvp?=
 =?us-ascii?Q?JjqnEHZYnI4uuRO+ihWZLs4rXeARXZXvWS38/gRKAyqEXsPQxqsHwx2G5sOg?=
 =?us-ascii?Q?WmKsFrpFU0+x/PaZ6uSa7PHF6dxJ0rxJ5DVeltKCNX02PqFjkEiuVv6/LeFl?=
 =?us-ascii?Q?ZuxJx2ZH3D57BL2vSh0DZigr4AWloRHy9AXHs+f44OCUnhAHbeYdhkZSaOsM?=
 =?us-ascii?Q?ryzNiS3Pck5W55zcb5OxTSypvX5AkFsYaRqXJI4n+8DUs5O0s1unJskuy2B7?=
 =?us-ascii?Q?G/E0N2d7tYNKIYf3jVjYj5Y5?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5933.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SSWMD+Rnwg/XaVjLjxSZuR2kYTbxluD5FZBuz/KeSS57O8omUEDzRNT/azjT?=
 =?us-ascii?Q?B0Hm+y3rTcwPus5kPfDXL7NHEdQdacF6D4ZXjAZbJuW++vLM77P2+qJWX06d?=
 =?us-ascii?Q?cgREIWHvPY9D4ynzNimRlp6QKaRStNTJvSRRLFQb+OZPRtEKqOtKUaVKfas/?=
 =?us-ascii?Q?fu1msH5hTWN4FzgZykHv03JRN/ye6R+zxgKHhVpt8Pbaxcv2J7KjHeu/yBgE?=
 =?us-ascii?Q?HFSjBnc81N0txPuao8egOslrxL563Rfqvvp7exuKk2TO3TOQBte/jYDvgx25?=
 =?us-ascii?Q?psS2i2s6lLs7vg9R4oGADnP29F5GoFYpGOXJjzRnQWRjNHyNrNIKcHKVFJRa?=
 =?us-ascii?Q?DKCSBQ/ty/IYWzDOGTioAcBDO9AcP9Ksg6b6w3KtrCXkoiAGaLhI1XlyPbxw?=
 =?us-ascii?Q?eOu0K3h2or33pAe88hGEy/CSAkr1DIiMOKxsCsm3ys0UQWFACMjcQJaDlfwf?=
 =?us-ascii?Q?DRTvuC+0U77rehzQDWwI+u0TLjcd3VN2MF+N1DXxaMn3n/fnwiCmisBSi0pN?=
 =?us-ascii?Q?BPayKZQ2HCDhPbEqq0CQb17970SLoKhYF/didP408O80pjmiz+6e4FvlDCuE?=
 =?us-ascii?Q?JRetDq6IYHtjwwjOGZ9Tt3VnT0jPhFhxSk9BOBxhGB3ExbKl3sx3qoBTlmwm?=
 =?us-ascii?Q?LkDHskcQ+ZJ7xGb63irhTbVdmx9w8U7smzPYPVRBYLmlnfCwb5O3Qyt0xWsK?=
 =?us-ascii?Q?8iGIefO8ZXkOVpXuTSRe4Zk9oErV/c1P1+wwpaABty63ZaJcPHlfJrlRONB6?=
 =?us-ascii?Q?vMCr2Ce9wKgi1/fzmPSII0bS4kTxumqTuGni1EKljQcxDI08TfZh/EIgI0HW?=
 =?us-ascii?Q?9Hbe+7wL+779UGdg/UMcXNjCqPs2MtgORqDipC3WqBR86LmZZvJirugWemE2?=
 =?us-ascii?Q?Ks2E4ThmNGUWAGsgPqmcLaiJEoZSK58T7lqid4jv1/h2qZGzEOMbSMFM8UPX?=
 =?us-ascii?Q?GY2hPM0yGsI6eI6l7OEiwvtNkF2D68LSB6R05xWDbcEjB5fUU791FQhLUpsF?=
 =?us-ascii?Q?BbcWp7d6dOVC4O37lRRfKt5GOK5AJny756ud0me94E1QhKzOKJLBSPRZnqjB?=
 =?us-ascii?Q?pNz1nPpwngzoLP8zuTwah1J+fz9g4xnrzhrQb5Lx4ELOx184SWAoQwQP3o3M?=
 =?us-ascii?Q?YMK62g6aUmOPRx3x0dpk9lpnmMT5NphSZh2qvNSu/AiPXHUxiS++p7zPCoKk?=
 =?us-ascii?Q?LceSMw6nu5Ej9zw64MVcjVE+c5wXyIb84vHQKgVRUsA5S83cFQOCJuLU/vxe?=
 =?us-ascii?Q?AlJY8NjTy2ao6SYrWoYGo1WgQMZahRiC8gjHLK3DDAn43esQ/tCJbLifT5EB?=
 =?us-ascii?Q?qTqYq3yztTIp3LxHPV+/MLgUeT9L9n/27IrchHQTkhF4zS54Ad7GDJz15tHN?=
 =?us-ascii?Q?fsHkWEl3jmyzNgwI8f/SegAlMusIYaA29So0rkBGaWwhLtWQqft0/4d9pq26?=
 =?us-ascii?Q?pnFTVIrXM9TagTdXd8TAx0sk+0KSccQ756lvxxhR/NkpdHGS1uy6F6d8Sa1g?=
 =?us-ascii?Q?vlKhEdKqjCWgvtUo2z+Lj7hbmqA3vK2ws9tS/J89tHc0dtU+0GJ0NLy3MQCO?=
 =?us-ascii?Q?bx+7Qb7spSYYhoqqg9M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5933.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abae8b16-c54a-4f1b-7c7c-08dce152e960
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 13:22:19.8664 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZjbGebTMRk3RnfqkFt7R+Dz1VvnZ5Ycf0RF2XdNRrIVj23HQdQylaHli4FpdQbNbZzCX8kT7EoMyKr4NqaQOQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6482
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

[Public]

Looks good to me.
Acked-by: Rajneesh Bhardwaj <Rajneesh.bhardwaj@amd.com>

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, September 30, 2024 8:21 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Bhardwaj, Rajneesh <Rajneesh.Bhardwaj@amd.com>; Xu, Feifei=
 <Feifei.Xu@amd.com>
Subject: [PATCH] drm/amdgpu: Fix logic to determine TOS reload

Avoid comparing TOS version on APUs. On APUs driver doesn't take care of TO=
S load.

Fixes: 2edc5ecbf1a9 ("drm/amdgpu: Add interface for TOS reload cases")

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 04be0fabb4f5..2a2d34fe8707 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2295,7 +2295,7 @@ bool amdgpu_psp_tos_reload_needed(struct amdgpu_devic=
e *adev)  {
        struct psp_context *psp =3D &adev->psp;

-       if (amdgpu_sriov_vf(adev))
+       if (amdgpu_sriov_vf(adev) || (adev->flags & AMD_IS_APU))
                return false;

        if (psp->funcs && psp->funcs->is_reload_needed)
--
2.25.1

