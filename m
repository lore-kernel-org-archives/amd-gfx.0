Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAF1E69E97
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2024 21:41:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60DB710E862;
	Mon,  2 Dec 2024 21:41:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZE93Weju";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 674F310E860
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2024 21:41:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FB6RVg7UhVnozPQR4afffC7KG3LpAkwMuM8DW4hl6wwTMtR5/Lm5+/6s4w92gl05oR2zsi7UunPYA4Ly90BMNk1U88tqRC5mf+hPh+vRjr2UNvG7yClGw8qqPT+u8rWDlhQqqU294N0IkPiNqlp8hgfSTVI3wuKRShwM0GPbp4/9rhpNq9g5krBmW8mC/sZPrrCDX8kHoV5sXQH+0L8d5Idy8aNgO20DxuQGdNrQUiZ81MZdXgly0ua9hWGuS5dx9WEY9+DlQ/dMwfF8Neb5+mDVBBEEKQRUKlMQMF09rsmG9NoMPgY08ZtsUJ4nEsGFUJRin3geNKSb7vByy58nOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybiEHoyj+hNN+4QbACdGCC7IiMSQ+CSCieejFfOdOKM=;
 b=EC6ZbPR6X0nFilY/3BgG2BV+TPRkNwLST1Yvlqc02VDiLesR0Yw/Ui+28/7kT2s6uX5UVd0ikXHEkPiqzBMZTBbAFeoMq3cCkLYNbo/zkzptOpwMVwULRlgj7+qr6aMOyEJ3KggMcOqX8pxhBgUtWrvClyvwKEJZAsLmFIU3Q9mAzVchEB7/kW7oCP5U498tVyeheY+QiXcHt/su8FLDSWQQgp4vKK3sHxlcAiDepgx0tbzW7PQl5xHKgDqq0bajGCL2bmVR80hnfv1so0HuvVNYaqZWHXseAE/k4rz5S/JJTZPYwIwbcts91hB0GfDb2U8sm4BZxKToTUyQBhuiLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybiEHoyj+hNN+4QbACdGCC7IiMSQ+CSCieejFfOdOKM=;
 b=ZE93WejumjtQWPKkWSmjcd8Q1dKM3KN+ih+HT93zgdVfooPyKK22Itfx5AoVY8+Ad0exNjlOQImcCBwiMEL1EhVoILCGnZxN4H47gnW75nhIlwP6u3yYr4yuJBPT/BooaP1ZTUcHW/JcdmIYlG6W/PrDRY2AzeMmjyKAXLYtzqs=
Received: from DM6PR12MB4481.namprd12.prod.outlook.com (2603:10b6:5:2af::11)
 by SN7PR12MB7934.namprd12.prod.outlook.com (2603:10b6:806:346::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 21:41:13 +0000
Received: from DM6PR12MB4481.namprd12.prod.outlook.com
 ([fe80::2f5a:1dde:a3d6:942f]) by DM6PR12MB4481.namprd12.prod.outlook.com
 ([fe80::2f5a:1dde:a3d6:942f%3]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 21:41:12 +0000
From: "Zhang, George" <George.Zhang@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: rework resume handling for display (v2)
Thread-Topic: [PATCH] drm/amdgpu: rework resume handling for display (v2)
Thread-Index: AQHbRNqom6+HtxzgkEe24pH5F4JFZ7LTVEaAgAAAUACAACcJ2w==
Date: Mon, 2 Dec 2024 21:41:12 +0000
Message-ID: <DM6PR12MB4481456F559944597817995094352@DM6PR12MB4481.namprd12.prod.outlook.com>
References: <20241202165237.971604-1-alexander.deucher@amd.com>
 <c8bb8b47-314c-402e-87bb-3641b63eb6f7@gmail.com>
 <1f65b7d2-7e4f-48ef-ade1-bdd3f2edb8ad@gmail.com>
In-Reply-To: <1f65b7d2-7e4f-48ef-ade1-bdd3f2edb8ad@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-12-02T21:41:12.550Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4481:EE_|SN7PR12MB7934:EE_
x-ms-office365-filtering-correlation-id: c3c6f7d1-bf22-4c49-a872-08dd131a0ad4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ljl4emtubBKrEQW7+q5tswXTuOxDc4zjKQHwY/JHSFKqZkhaEEL6v2sziQ?=
 =?iso-8859-1?Q?qSfhN9jlfx0IPTP1XHg0ACl03kSCCw+ZjQVR0nwnknhJ2whUPOhB9H1BfP?=
 =?iso-8859-1?Q?9ZfW7I/XdGg1EDEK36u3mny8UwV030jGedkk+rs0koImTs89Je0h4JaZbe?=
 =?iso-8859-1?Q?9IDDPIl+aLCuIakGZ8xlSCI2V89LmwWPier3RIBtbvTZtGoYwTtwBZIApK?=
 =?iso-8859-1?Q?6LXV3sAxOk5EelxK9Z5s5vNub4wv5yIxX/nUjuy8AiC49z9KX5hKGZd0qm?=
 =?iso-8859-1?Q?nZssCPpz7lAEoJ7+Xm+1Y2SeQpnoNQvVA5EaC0+8gLq/23eZcfToZWBo2o?=
 =?iso-8859-1?Q?Hduzqiyek8Slg6vu0YPTI78iytdDjOk1KgOm7963jORR+eQ1cboqB3CpvH?=
 =?iso-8859-1?Q?FinkWID5M44mATD16hx+YDY+Oxw5/zRzXazI+EfC2e8Ovd2C/BGQgadgGW?=
 =?iso-8859-1?Q?/COLSEExKeCP8lcY5OAhqyOiYjDzKx75AKceBFlzvINifWcet57R8Kk9ar?=
 =?iso-8859-1?Q?vOFUr7juWuP9VVyYUYJiWMgNMwHy2ZkSAaAE25CDCFAf1sYTpBYscTSg1U?=
 =?iso-8859-1?Q?9gpdFiu5f6oXhZPgc5v7yBTRcZ/lNK0HLs1gdora9jEx8+cK1rqsTYFXmK?=
 =?iso-8859-1?Q?fif6l3D06ZRxhvmOQfr53UR8MdubjzvprY54qxxabxCAbffM3vwKWRTFWv?=
 =?iso-8859-1?Q?SCpCIr1z5g5HzAL5XtkA/+xvC4ZjsV0mAWYgp7BGzTPdAbgIze/YQmkcST?=
 =?iso-8859-1?Q?JqC1t2CrGGu5bkIYpgFzcSFS2mqrIQnl7LWWSEl9LmJJkRdT21KeiE8K85?=
 =?iso-8859-1?Q?OaLLgPRmawHfUzpaTWpj1sATQ0jx9pLD1/xu1wzXrPU1HFJeXGSH9ler/9?=
 =?iso-8859-1?Q?3bc7rOCCHhAtM9NRekYEFm6OxDDlT5I2+sAgyPC11qmH421ADl47nqvh9+?=
 =?iso-8859-1?Q?Q5Zv/ghZrr3Jb1u3RGBxyYIJV5ITSxaDl+94lf/+jOEjxF/R0DQ5Aa3WWP?=
 =?iso-8859-1?Q?mGkF8C54KpJTT5cQfFo5OnEC2P/4ZTzoD/HPHCzV5iJR9lb27FjhFUozZp?=
 =?iso-8859-1?Q?tU67FNN/gVSWcfmqayj1NeHcW6IjnUqKxvmqzLL6MB5N5GZt2iOjJnXUkW?=
 =?iso-8859-1?Q?y7dTQ1CWzzwxAYmCmyyo5bXWkQSQPo9k9S/RZ43O6Om3wCLcC+/pkxA5ha?=
 =?iso-8859-1?Q?VVTUhuqSEigEMlLCz3S7cNgI8ftvZD6+SFPur79htBeCC2KQdKBeT+Af5h?=
 =?iso-8859-1?Q?m27N5Sov4WGOZ/05Vw800OQZYK3g/91uDbKN2lu6hGCAGqkYHnLWee+nP9?=
 =?iso-8859-1?Q?Q2Xv1YCAtZadrKWW+Rc7VIQDY1LVKJ6+NsKiqweLqqeGRPrf7aGptI/I72?=
 =?iso-8859-1?Q?yb+mc/qN9UQdY9d7P1Gt7keo4lNOOrRBhq6hxWeh4j6MuFgR2i6CXY23X9?=
 =?iso-8859-1?Q?vlfowscDJ3SQW5Ca2SXHc69tVK+SyftlVMPohQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bBBljwL21UdZHucCNez/Zan6AHN/PL5DNlYFuWjHcTlfJfKXGV92cz36gM?=
 =?iso-8859-1?Q?DWq/LO0vhXDYGcKe/U+YZ75B3pIKc948sZrlG4YoWg0sJuAMJX/9flhG6e?=
 =?iso-8859-1?Q?LNOIbQbyJP+YMquIV3tcPOwWiXWIxGTXQp+QryrrV8eFAPW2nc6xOce87e?=
 =?iso-8859-1?Q?QmzdZEH1A/QnW1BivtFjMgQtnno1/iERdPOIc3MSptHf1mZbYchjEDBPyK?=
 =?iso-8859-1?Q?+hx3xsni0f7AtomLs6hkFisoCvP7WcHyIOljuui9j3V6EgrcAk1x+zTmy1?=
 =?iso-8859-1?Q?9YICf01+wN5J2OpbFY+YgLc+AYGUO7/va5nV+pCJdfdWYWg0FrkVwkYsqj?=
 =?iso-8859-1?Q?GdgTJ930p9zuZSSOwLok36PXrwh2I6hVBQbQfRyWK0W8+DyEDW9EqMMuaN?=
 =?iso-8859-1?Q?A+IM7JvODt8mktiOLZ42WXOYWwNOVLzpsy/fYwPUOyGi5+Vu8f0RRhQsAG?=
 =?iso-8859-1?Q?dQLOoCuAO83ypvP8jTndQkvu45upBC0FJbb38He7uHgcZyeKt8WxnM+9xO?=
 =?iso-8859-1?Q?2/YjCTfINNtae9VR+EaJkqBbkr0gc/qwuiosopkMTwxyxV6/T02XJjPO4i?=
 =?iso-8859-1?Q?zLZNcXuOPjh6OnkIfhmQ+KfC0q11W92rURmarnfB99x2m8KZCTTtL1Y1zP?=
 =?iso-8859-1?Q?7ln6lfN782ZpvENS+N7mnEcZwwl/5X5uoe5zw7/9hsp0w9rGOS+gV04i4f?=
 =?iso-8859-1?Q?fRSJO+9qfAKPCDX5V6yzaWL/fj6UCMffer3df130gHjKEC/bLxxL1Y4JQW?=
 =?iso-8859-1?Q?zP1W9S8KDcr3qBdg778SOKXkcjWm02VJ+B0Z6c0l9H0j3rvbiw44AsA7iA?=
 =?iso-8859-1?Q?I22XaM5Grilv5Y9pqL8b/82VjODKrJjydr5qnWvUyJQNhfh5Plfguk2GfK?=
 =?iso-8859-1?Q?oNs71CxF77KXCKviMXOrLpJXjdsRoECTA21P+Tj5faUHgC0ujXQB7Ph72r?=
 =?iso-8859-1?Q?rDQBL+n9UUzxuOdbkfLAcDpjKCOgPq1ZKXu5/7OeqPLVL1Is8+pr1+jWYR?=
 =?iso-8859-1?Q?/x1V90BEF7lw6C1EvVUTo2+9fDplMRxKANNmEL8r152smDZ7lr4HV+Izv3?=
 =?iso-8859-1?Q?Kdjjo1Ko9hlXH7rkckY2W3PlWBkhOTgZseaRt8n480/zCx1HozIOBr/M29?=
 =?iso-8859-1?Q?rtOoupzTxwYGulamIAQ6k2piot3SNae2gSuTRLnV0faZ1ngoQTmb4C8gwb?=
 =?iso-8859-1?Q?BfymjOYMZ/QdfSs6QVvu39+bZQ/LbT8/a4F2yW8nMb+3ElygFn324pfex2?=
 =?iso-8859-1?Q?Q635IxPhAlPC6oHimmJBvPTaqTqWqKzBC0ZsLjcjNyKco1zOX9eR6AHVX2?=
 =?iso-8859-1?Q?RKgE1JIeJJrqtco6ckVherckBCkC2pRU5+qUZ5KKDk7ZccNVe40Y2BzAVf?=
 =?iso-8859-1?Q?0OGy+geNUkKwrVXSIaBnduRNZ/Yd6OgaAht92HXZv35Z+oj3V5uSzAXf74?=
 =?iso-8859-1?Q?5WzCpyt6NzVQrRFw6xmQwOH2wqc0pBR/+JN4Iw83FcBhZpM9Yb2rclH6ak?=
 =?iso-8859-1?Q?lrDKpkYK0UMUe2hSoxcNDzbD7ejqXVJ/uNjQsCzRyx9vztlKsPI4QCY3v1?=
 =?iso-8859-1?Q?VUYhBy/pXf50Lgaua5TLJDHT+rtNCgcywXLCVZB9odEtQH0Fql5ja5NXUM?=
 =?iso-8859-1?Q?qh8nDBoER6gh0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c6f7d1-bf22-4c49-a872-08dd131a0ad4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2024 21:41:12.8197 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dnp5C2zRvN9Rm35L58JRoNmek2l6tXARdbPWh516bmEBhh7E2++otfL6Y56NLekxR9ETRCtH4t9KBhyQ2J5aTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7934
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

________________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Christia=
n K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Monday, December 2, 2024 2:19 PM
To: Deucher, Alexander; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: rework resume handling for display (v2)
>
>Am 02.12.24 um 20:18 schrieb Christian K=F6nig:
>> Am 02.12.24 um 17:52 schrieb Alex Deucher:
>>> Split resume into a 3rd step to handle displays when DCC is
>>> enabled on DCN 4.0.1.  Move display after the buffer funcs
>>> have been re-enabled so that the GPU will do the move and
>>> properly set the DCC metadata for DCN.
>
>BTW: We might want to add a WARN_ON() to the CPU copy path to make sure
>that we don't try to copy DCC buffers while the SDMA is turned off.
>
>Christian.
>
>>>
>>> v2: fix fence irq resume ordering
>>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>
>> Reviewed-by: Christian K=F6nig <christian.koenig@amd.com>

Tested-by: George Zhang <george.zhang@amd.com>

>>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 45 +++++++++++++++++++++=
-
>>>   1 file changed, 43 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 2a25e0742f8e7..d882d46de1416 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -3764,7 +3764,7 @@ static int
>>> amdgpu_device_ip_resume_phase1(struct amdgpu_device *adev)
>>>    *
>>>    * @adev: amdgpu_device pointer
>>>    *
>>> - * First resume function for hardware IPs.  The list of all the
>>> hardware
>>> + * Second resume function for hardware IPs.  The list of all the
>>> hardware
>>>    * IPs that make up the asic is walked and the resume callbacks are
>>> run for
>>>    * all blocks except COMMON, GMC, and IH.  resume puts the hardware
>>> into a
>>>    * functional state after a suspend and updates the software state as
>>> @@ -3782,6 +3782,7 @@ static int
>>> amdgpu_device_ip_resume_phase2(struct amdgpu_device *adev)
>>>           if (adev->ip_blocks[i].version->type =3D=3D
>>> AMD_IP_BLOCK_TYPE_COMMON ||
>>>               adev->ip_blocks[i].version->type =3D=3D
>>> AMD_IP_BLOCK_TYPE_GMC ||
>>>               adev->ip_blocks[i].version->type =3D=3D
>>> AMD_IP_BLOCK_TYPE_IH ||
>>> +            adev->ip_blocks[i].version->type =3D=3D
>>> AMD_IP_BLOCK_TYPE_DCE ||
>>>               adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_TYPE=
_PSP)
>>>               continue;
>>>           r =3D amdgpu_ip_block_resume(&adev->ip_blocks[i]);
>>> @@ -3792,6 +3793,36 @@ static int
>>> amdgpu_device_ip_resume_phase2(struct amdgpu_device *adev)
>>>       return 0;
>>>   }
>>>   +/**
>>> + * amdgpu_device_ip_resume_phase3 - run resume for hardware IPs
>>> + *
>>> + * @adev: amdgpu_device pointer
>>> + *
>>> + * Third resume function for hardware IPs.  The list of all the
>>> hardware
>>> + * IPs that make up the asic is walked and the resume callbacks are
>>> run for
>>> + * all DCE.  resume puts the hardware into a functional state after
>>> a suspend
>>> + * and updates the software state as necessary.  This function is
>>> also used
>>> + * for restoring the GPU after a GPU reset.
>>> + *
>>> + * Returns 0 on success, negative error code on failure.
>>> + */
>>> +static int amdgpu_device_ip_resume_phase3(struct amdgpu_device *adev)
>>> +{
>>> +    int i, r;
>>> +
>>> +    for (i =3D 0; i < adev->num_ip_blocks; i++) {
>>> +        if (!adev->ip_blocks[i].status.valid ||
>>> adev->ip_blocks[i].status.hw)
>>> +            continue;
>>> +        if (adev->ip_blocks[i].version->type =3D=3D
>>> AMD_IP_BLOCK_TYPE_DCE) {
>>> +            r =3D amdgpu_ip_block_resume(&adev->ip_blocks[i]);
>>> +            if (r)
>>> +                return r;
>>> +        }
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   /**
>>>    * amdgpu_device_ip_resume - run resume for hardware IPs
>>>    *
>>> @@ -3821,6 +3852,13 @@ static int amdgpu_device_ip_resume(struct
>>> amdgpu_device *adev)
>>>       if (adev->mman.buffer_funcs_ring->sched.ready)
>>>           amdgpu_ttm_set_buffer_funcs_status(adev, true);
>>>   +    if (r)
>>> +        return r;
>>> +
>>> +    amdgpu_fence_driver_hw_init(adev);
>>> +
>>> +    r =3D amdgpu_device_ip_resume_phase3(adev);
>>> +
>>>       return r;
>>>   }
>>>   @@ -4909,7 +4947,6 @@ int amdgpu_device_resume(struct drm_device
>>> *dev, bool fbcon)
>>>           dev_err(adev->dev, "amdgpu_device_ip_resume failed
>>> (%d).\n", r);
>>>           goto exit;
>>>       }
>>> -    amdgpu_fence_driver_hw_init(adev);
>>>         if (!adev->in_s0ix) {
>>>           r =3D amdgpu_amdkfd_resume(adev, adev->in_runpm);
>>> @@ -5489,6 +5526,10 @@ int amdgpu_device_reinit_after_reset(struct
>>> amdgpu_reset_context *reset_context)
>>>                   if (tmp_adev->mman.buffer_funcs_ring->sched.ready)
>>> amdgpu_ttm_set_buffer_funcs_status(tmp_adev, true);
>>>   +                r =3D amdgpu_device_ip_resume_phase3(tmp_adev);
>>> +                if (r)
>>> +                    goto out;
>>> +
>>>                   if (vram_lost)
>>>                       amdgpu_device_fill_reset_magic(tmp_adev);
>>
>
