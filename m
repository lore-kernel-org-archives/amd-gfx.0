Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95347C79FAD
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2026 03:49:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28B8110EE71;
	Wed,  9 Sep 2026 03:49:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5E+QGfi3";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011017.outbound.protection.outlook.com
 [40.93.194.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 868D410EE71
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2026 03:49:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WibhK15MPBjGzVa6ptSnNDMdOSlNlVdkmeFYU/u58k7eO7e0ynLb+4jOCbJjMeFNSZY+eWqS9jsHv4lnqvLUV8fCFNEuEAc8yU4faZcjkB78HTCTXWgj1OgTlKzX/zbCS4ZUz50whgH/QBvV17tRBThYiVaBOcIPlUoLcX7AmoY+D4n46zNL3RDfz2EUZxlbJDb9ERkdSFMkY81m5WaKznKc6u7Av1yi7oTt0en24pHNMuzy15/SFoumD9Lt9bivF3vbAu8NG0Yur3PYxikQuCKYU2glVJa2eNntkK5wwGXATb04g/OB3EYL4dIZizR6g73VWMvGPfd6Q/Tg4wNIYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUWHHx4Ofe4sRPvBByyHojfUt9aRhwFTsdPvUqhHGw0=;
 b=B1BFONEM07F8EYSInWB1FgA7Kuh2TXLY8lK0/bB/TBo8d3YbPAdPArN9x30yigNrE8qyRJPnRL7soQyZrpaIyLNzRVZIDY4zRCdB+v8Y4zKRWGKskq2+vgf3gQAl/hoj4pbrilslserL4h7rbSSdFit7fl0lf6KeF5VXMZ4TouMRoGE/SI5rN8SjWgWVW9WkZ7r9murgsrOhkYlEYUsza7TtlknX5CxUpThfrJTB3xtb1xb5goSWApYcl+Yw+dGRj0QRLHGs/5be+efxNmiIXP5xc6wDVrlDTrOQVynLNTOxcNPfuxIkiLm5y86vFB0HAWh2b88MfhzKI3g4/F9ABA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUWHHx4Ofe4sRPvBByyHojfUt9aRhwFTsdPvUqhHGw0=;
 b=5E+QGfi375rl3j1lbB16/nSfjh/TYiY6RQvylXgbx1ovvwnl1uGtz+oV1r3EMN4x0UKjtPp6ac7gjMO4G+zHe+swGrIgDH6EukJtbqbEJSt+3Wn8d4k/TIzOxkjY1ErD/Y+pzHa6oc/a9bNDPDdvG8mcw2miswVQsLTpmd00dk0=
Received: from BY5PR12MB4321.namprd12.prod.outlook.com (2603:10b6:a03:204::15)
 by SN7PR12MB7855.namprd12.prod.outlook.com (2603:10b6:806:343::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Wed, 9 Sep
 2026 03:49:47 +0000
Received: from BY5PR12MB4321.namprd12.prod.outlook.com
 ([fe80::1b9d:14a9:e7d2:7057]) by BY5PR12MB4321.namprd12.prod.outlook.com
 ([fe80::1b9d:14a9:e7d2:7057%5]) with mapi id 15.21.0382.014; Wed, 9 Sep 2026
 03:49:47 +0000
From: "Han, Zhen" <Zhen.Han@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Hou, Junhua (Richard)" <Junhua.Hou@amd.com>, "Liang, Lily"
 <Lily.Liang@amd.com>, "Zhu, Lejun" <Lejun.Zhu@amd.com>, "Yang, Philip"
 <Philip.Yang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Joshi, Mukul" <Mukul.Joshi@amd.com>
Subject: [PATCH v2] drm/amdkfd: correct vram_available calculation
Thread-Topic: [PATCH v2] drm/amdkfd: correct vram_available calculation
Thread-Index: Ad1ADitiPmMG3nKuSpatsjgU6psLkA==
Date: Wed, 9 Sep 2026 03:49:47 +0000
Message-ID: <BY5PR12MB432123E94FB423CB7EE969F58DB02@BY5PR12MB4321.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-09T03:47:20.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4321:EE_|SN7PR12MB7855:EE_
x-ms-office365-filtering-correlation-id: 98c88e04-63e2-478a-e76c-08df0e2564b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|38070700021|10067099003|11063799006|18002099003|56012099006;
x-microsoft-antispam-message-info: mtfBobcYUM6oKqy05vlUgnyhjtRYpUvlzY6XH0tGvAWcyDMHUD/mYPvaAke7PQRjduM2gKZWlVuHfeG8rJ9KpXYjh4jl/0bwMFPBvPY+ydHsFas0Gi1hKHQPXI8kH41jaLpgqRZ3QYj7iUM4nRElMTC4qJGWzZFbETajwb2pBUh9Un8Xzbj4vP+gcRIn/FPj2cpRDWJE84/dUy0mxkZq4X0eRnfOSJLurNppziEffwUuZlM5fbg7K3JWfdgWmWEr4XQSD2ihcu8PhVRv6bKoLgxXv8LXEB5jdJp1xjxIyI7F+XA6199tbyPj8WbHd+DPIEO9Ho4aVo1kszGLUp/yGUfvnOPyE4+w+mXjtut4wuplFjuZ/udQ5o/0jlHXuPuCJdZKSepvZ22yBryxgPdN3EKAJENJtlmzkhv1iCwswNqVy/4ju307ESkuRe1iKAW4lTpA0uaQso6EOU2GURP4enGk5i+3wwPgRA1p5b7cgcnvY3CHY6hDIF1F4fAOxpnrdk7nV6GrVpzKwTLQtWfNT0IrGZAUGixOMvOvE3aApvtFyfH3DRWC2a2mki0kS9O4Gb+1ZvooZypu3g4h9N/I6QL+VjrmfycR9mwVAEhx+Z1/J/1l4wCZmNR1OaF2KFXIi6NRHgBoqFLJEGfthBxWifBRCrEpz9QUt/eOqKOn+h3vgGBZWQhMyVycSDetjaYJLuk6MSzCB5oYKL8OpNvjjVbcwhIlp2tmZt8dyF8g9tE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4321.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(10067099003)(11063799006)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OclP3k/rduS2A2LqiLY8jEjq2poW4Vzw5ALA5pKSQcqRnEol8mll79gwm3?=
 =?iso-8859-1?Q?zF4uHWo0v9OI0IR4RmwrHBUOF1geUOkafRc7WMsmD057IklMoCZugWD85F?=
 =?iso-8859-1?Q?NWLx8dOZEt6LRo8McYCAYE6wFcJ1nbL8oyRhRwJQd3vyvgAfhYGrQHnq4q?=
 =?iso-8859-1?Q?+1o8INfvCs/EOJKhhMOZZ1EQX/HlaYCwwf6OeYqrjLti6MRC0A22msSIXD?=
 =?iso-8859-1?Q?ToINtp3KJg++bJghQznU8jXfZXoAqCneAMBNm2nhL7+/m+SMImm/zAG4HU?=
 =?iso-8859-1?Q?YV9AfrCVBj/q3Bpx1B0SOQO7IFPR4R23FnNBZSUjPI1dxe6ywBve5d099z?=
 =?iso-8859-1?Q?D2Wh4r9+rcfIIzTcl8Rum5lsMbkNu/OyFYFCtOEwswt6GUACzQqrhUBnhO?=
 =?iso-8859-1?Q?uD8qeZC6FwubXu7iwocRK+UFoHsXwOK29/1h9+UyqjjyqNw1tO3wTYcE3C?=
 =?iso-8859-1?Q?YlNDp+/TpfXgBP7Tn22B+8FZEuYvHIC4cresYvoS0Q2+EDqSyMzviRaSsX?=
 =?iso-8859-1?Q?kNAfp7W8zcE61oqrcG4PRfcffH0M6LO9K+9Ach7sXD5GJuOwXhHpo4eiEh?=
 =?iso-8859-1?Q?XLbk4bir0v/D0up5rX8SJe9Vk8rHO7r6Il6kosQyvfFBYglSof8Ohx/KDD?=
 =?iso-8859-1?Q?iCqgS82aSWCH7c9FovfySwEctBDI2ITDbmoVhxymuS7vKYZtlvXm/H5EOV?=
 =?iso-8859-1?Q?7HC1PG40vR9snOYjW9QQSe5Ql6gCR4tBb+uS7DNkMPTspTZjh4oIrwBKiB?=
 =?iso-8859-1?Q?qYPZzcDSUgPE57JtuYlDzC079kLBZTswJledwfV6ef3ZHDHTtNJbBq4qPd?=
 =?iso-8859-1?Q?7mGcTbq9fhHx1BExwA5BJIobcorfImcs6R2Yz0QnjUq9p7sahBVMIGIvIQ?=
 =?iso-8859-1?Q?1PJQbpAFWd/8LfMpdIiCW4JxsV1SP8IO60JLUchU8izWU3MhMk61bfMbNi?=
 =?iso-8859-1?Q?y3QWLuuON6U20ib92EuROlHC4JnC8CVB7tWnQcyMLpKIB+KDd7Vzkg5PT8?=
 =?iso-8859-1?Q?7Osjbx7r/86yNZF7/DCiu9S6yo5SgKc7DDHKvCo8h2S2PYjzVCWF43Ms8G?=
 =?iso-8859-1?Q?WfpQ8zf9erjFDyoHpjzkZwOUqxa4gquTVA+YxsyCH3/JFBdpFWyGAu1QfP?=
 =?iso-8859-1?Q?4PBVDahapjn3zOF4Vj1tix6A5usWkU0CHYY7sBp81tQJfiXz4ib5p8+5el?=
 =?iso-8859-1?Q?ZhqdSeBR5fIbNLNGi8GwBST8X79UP4t6/8K8GcyBEgtae2fJKViMdX9YI7?=
 =?iso-8859-1?Q?ewpZO4dx43hFL0OrMxRlPoAJE/NrAqsPKyrmerWE73Pv9Q55PAx47gYx21?=
 =?iso-8859-1?Q?KShgBS5WY1kMuHY8kKGnCeq65dMulvv5WQPWe+OK2kIajhMVdakTTFrOYt?=
 =?iso-8859-1?Q?j+LtlEBReEojNhTAoe6A9fE/5ZYdeBUEbj72ZWXsG1nD/TWmP1Q3m95nlj?=
 =?iso-8859-1?Q?g/YA9tXZtHAIIocuGLw/iu+5IDT9IhRpxWg3GyYmQg1Nj59ePB0PeLV+G5?=
 =?iso-8859-1?Q?k/wjdy0QzdILiG9FW0Qnw36YWwYaSt6quMI/PbWnUHxzkpHWW5eSnxaOoc?=
 =?iso-8859-1?Q?EZsXc+iXA6WnNzYG66WZeYPKfERlE7DXomvolr5Ebt/dQJF6b7WEyD3hSu?=
 =?iso-8859-1?Q?krE/nwbdDYE7dGWMsQyoMh8gQw2EAkXtI03oMqqBZ/tFYRCeemGUY/pUVb?=
 =?iso-8859-1?Q?uBVUlACGFDTJNlyjfPECCBsRIpFJ0cyDmzpxEv1Hd3cT52xQPuyBJl+4+n?=
 =?iso-8859-1?Q?pWuWcRkz2iT78nTcftosmHg4LbY1HpDs8vRv8UUI4L32R0?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4321.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c88e04-63e2-478a-e76c-08df0e2564b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2026 03:49:47.5351 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mw7hCqEaAEw5R3A+dIfH2lF0vBYqZl9eHTHdFIahFqDktnerEhbrbmURNHKM6LxO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7855
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

AMD General

A new VRAM allocation needs to meet:

        adev->kfd.vram_used + vram_needed <=3D vram_available

kfd.vram_used already includes BOs that are later pinned.
Pinning does not consume extra VRAM. Subtracting vram_pin_size
without adding back kfd.vram_pinned counts those bytes twice
and causes fake-OOM while VRAM is still free.

Add kfd.vram_pinned so reserve_mem_limit() matches
get_available_memory().

Signed-off-by: Zhen Han <Zhen.Han@amd.com>
---
v2:
- keep vram_pin_size; add kfd.vram_pinned in reserve_mem_limit
  (Mukul Joshi)
- leave get_available_memory unchanged
- drop former 2/2 (Christian K=F6nig)

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 89958d0f7e59..03d64758147d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -237,7 +237,8 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_devic=
e *adev,
        if (adev && xcp_id >=3D 0 && (!adev->apu_prefer_gtt || adev->gmc.is=
_app_apu)) {
                uint64_t vram_available =3D
                        vram_size - reserved_for_pt - reserved_for_ras -
-                       atomic64_read(&adev->vram_pin_size);
+                       atomic64_read(&adev->vram_pin_size) +
+                       atomic64_read(&adev->kfd.vram_pinned);
                if (adev->kfd.vram_used[xcp_id] + vram_needed > vram_availa=
ble) {
                        ret =3D -ENOMEM;
                        goto release;
--
2.43.7
