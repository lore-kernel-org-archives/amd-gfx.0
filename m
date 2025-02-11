Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D3C7C02198
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2025 01:48:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C807410E630;
	Tue, 11 Feb 2025 01:48:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RdR9cLKH";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F68B10E630
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 01:48:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8Csy/iV95c8D1eIgdtM1nTqrNPvd8IR72YSdqfH79uufIBc5o+CmAE1E4NNhgvBwn5fLx9iLNmmuG7wlhrRJTeOd3LNLTIlmP6X+D1igWYI3hAlb4fPLGjUeZqi6NdFjtHEPQGUmqsTjBkLKngm756Tjzcs/2AJ2NJNuCOOLkppkchnzgk/oF7DMLf31zXHxnoE4bJKCe9y2v3WaGQD/UtYBv2uKCrJ3KS1Av8NEEMEJTVMev5J8EskhLSM6OO6bQUsxzHZ8QkfAGiMXk+yphqC7ivKWv1EtdHXrCJnHk1HV3PfkYnOJrNK9pd95cB7qX9W7CunToNMc6CHYNu3ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcvoPfjjWEYflnASPbq0TlZ7Uxt0yoGzl6aVTuqBghU=;
 b=XR50KLB1Qc9TMCnD4vFuExCpQlVq2seVlrPslI7+xK2LTh7RMzTg4O/653RR+XhSOpoXyqeqKKRcVr/L7bkSnxJoIlHYqqm12NqHH/dI8ASsjL98LOE3XDDgRQxCc5FVZfxLAWsohN8+qNAw0v7daUhTGS3AkIG97uqqCQ26mB3kvUqZgobwyEld83JzHgqqRPuEwSaS7mPAEienf1BCzXnI0D5mdQQ8DyEksJcnz07ayH0kdQS869GYHJ9oRrHypo0g05WdoZX8jMVtdseYKCd/ifXZ/acrLveirMVu3bjexqpmwA5bHuSy26I2Tz9mHWvKW3YlSvobTqOGE31Ijw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcvoPfjjWEYflnASPbq0TlZ7Uxt0yoGzl6aVTuqBghU=;
 b=RdR9cLKHJuzxAjvLr0IEFb36//zXY9eUBtj40XJu4Buc/81Gf7AGnN2FDCqMQxWlUMDK4xF8jmjPgKVi5uY36KMijPxiu5FH5YUI+v1wbS33QS7DRWoPh776t1Zx1NnOC1PJ2dV5e9yfNCOfsqDgMrKyJI9Cqf/03GEjAY4cIuo=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by DS0PR12MB8043.namprd12.prod.outlook.com (2603:10b6:8:14d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.17; Tue, 11 Feb
 2025 01:48:51 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b%4]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 01:48:51 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "SHANMUGAM, SRINIVASAN"
 <SRINIVASAN.SHANMUGAM@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu/mes: Add cleaner shader fence address
 handling in MES for GFX12
Thread-Topic: [PATCH 2/2] drm/amdgpu/mes: Add cleaner shader fence address
 handling in MES for GFX12
Thread-Index: AQHbfAF26N9VO/kRTECg7936LeDhZrNBTw4w
Date: Tue, 11 Feb 2025 01:48:51 +0000
Message-ID: <CH0PR12MB53726043385289BEA92AFA2FF4FD2@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20250210211904.281317-1-alexander.deucher@amd.com>
 <20250210211904.281317-2-alexander.deucher@amd.com>
In-Reply-To: <20250210211904.281317-2-alexander.deucher@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=2b3a11d5-fbfe-4805-8ff7-b2000f40ebec;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-11T01:23:19Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|DS0PR12MB8043:EE_
x-ms-office365-filtering-correlation-id: 9ad873c8-af7b-4a9b-3be3-08dd4a3e3c0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?De1i4j7tp0RlfCZN0vAP1qiRigMhWZnkkIdNeHDoVh2grp8ZH8XkpqaRhi?=
 =?iso-8859-1?Q?9Ope0wBKnu5VowXljzAAuwT5D9fvsJqnrPsdoJMoWmSFfyoLP6U2b4lETc?=
 =?iso-8859-1?Q?V97iaATXRCVNmVvebrZDM+1zpHxCIKiIz4xjh755L2BuHfRkMZ+MCdIwdk?=
 =?iso-8859-1?Q?PfYfc7se5mBPJ0cSBG49wxwiYxZniO7HGhwmm3sMXw9U0Vn2muNPAoNz0R?=
 =?iso-8859-1?Q?DLDxhpLPyduTGBFpw5WfATznZt0DH4YDlGvMlJEx79sjOjx3u5+i5ku9Lc?=
 =?iso-8859-1?Q?x7z0BzgZtsA9kY7kxl1M4PgKN7AzlV4WNElmh1p58gb8nIIYrJivuVYeR9?=
 =?iso-8859-1?Q?IOFA/kH4O7GwIQ8KGRrekgLu5455+tSJpMXhI9wzHQWYqjz7M1Zd5l+pg1?=
 =?iso-8859-1?Q?Im0Ztx5lY3FmwBaJTXFg+YI7mBcZvAFVWryUSAlPP7H/pb/qZRfyjwVtJj?=
 =?iso-8859-1?Q?oHti5//Sz+pQ7VP0OiDM0z64h9LMmGu/I2yALRl9xepDohvOXf+fNTI7Ks?=
 =?iso-8859-1?Q?4hDdTQX0RcvxrIhz6/pEt4jiQ/C6gCUxziJalSZLOdkliUQB3DwJ/M3EJD?=
 =?iso-8859-1?Q?Voc4aJnkyQelzDyUGd/m9OYCgN8rPDlN902dLf0uHxX5XJIqtewD4a5dem?=
 =?iso-8859-1?Q?jXTfQXTT3voNAip9aFB4vhyV/n+jveLieT20MTlDKx98CKCIrWqoh8PF6e?=
 =?iso-8859-1?Q?I1zUPM5zry8/APjcG8pcnySgAwb0EmWgE/16SSa7nX67img43kedvZBJag?=
 =?iso-8859-1?Q?VKPc4i0aHOlrhvm5Z/r0gCsR+75ZFMx1eZZ1wAwyEzg0xhhIKTc3JRVIPv?=
 =?iso-8859-1?Q?qVFVwQuuxtDQlcOqag18UwDx1s3SvReKYsVw6IDrniDdEYml8TX2wkPHTJ?=
 =?iso-8859-1?Q?ury7AoPsNB/TbeA98fpZ1xjQrEpUArz0nCGlyhv7ZOW0LJfMd6Xc3W+eMe?=
 =?iso-8859-1?Q?Tzx8IoQW3u3jyjQhMFuODlu4ZZybpYBnJVFoNeADBAFXQX2eBPl2aD46wG?=
 =?iso-8859-1?Q?zSHe7HrTk1qChr3n40+gouh/7MV8FS8YOJ4yvi2JpDqFnrDQHJN9qtCPCg?=
 =?iso-8859-1?Q?b+2UZY/BsWqQli3EvzgO+Ks0cn4dyVAaH1TTpKtoSfHxjCxMw02GycibFJ?=
 =?iso-8859-1?Q?ZK8W8e52pwFHuZDVQir83rJcEjUGabHnI6JKnuc11SK73eO+JtbZ6X7u+L?=
 =?iso-8859-1?Q?idxRkWMT/hpry4uhaIHQA4ZAyVEgNQ79aNmbMLh9ICx3aNN4j7B41vaqmt?=
 =?iso-8859-1?Q?iypMndzjwsZRq9pp1H8eIdkmCFigxZbOlqQm8t7rXTVNoG6mGU078/UtT2?=
 =?iso-8859-1?Q?vp5a6dCbOLsNc4orr85Ew6eO8I/wq57HE5Xkgn5XRvj3iyNqfNYZeRVMbl?=
 =?iso-8859-1?Q?3cEfD7Wd280poKnBNUFpQGstAwPWuyG/PmUr6LEY74dosORFoiIHHDR8Xt?=
 =?iso-8859-1?Q?q49JBNCt/jePUZgrR8jGVeSGvazDQMZE8++PTiBxmK8N6xGDl3heRuu5lZ?=
 =?iso-8859-1?Q?/aTEOnjWe+mKT2Bx4aK1Sz?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ii2N5sWBJBdmulG9DkRPqVMGUsupQeA+6N49gexmUTYfU6bE8qDmzcnk1h?=
 =?iso-8859-1?Q?2Y7axxPFxrUaG5w4VNQE36DDF1v07KC1xDSs8GPUjznKAHUZxam+SNMABG?=
 =?iso-8859-1?Q?QHnGkPJjkxli9aVuwywnn8mGt9341WTvJKXjl7jV6T40e4PRytaRxMxLaj?=
 =?iso-8859-1?Q?yXfPMCFlIEgrfxPDVAlZ5KwvpODR4Hb027j5bTTVzOAhgEPbZ6ACW29DFw?=
 =?iso-8859-1?Q?7a0LlPgVc1le9gXqw90jpXx8ykFqsS1Sb67hMvmTVEfRKcg19KiYxPi406?=
 =?iso-8859-1?Q?UvseNKHIth2IuwWqB0cONdS/dhaNmN8ggbMEyHKCOiAbPej/mVyBfAqJWl?=
 =?iso-8859-1?Q?aN4B++kQNgLJANugdh3PaRWB1NHZ8mHnOubM4u0I8xPkIwv9YTn/UKXBSK?=
 =?iso-8859-1?Q?6HAhBwiC86Da/9dUqzM8qeyrXYCgjOpFLGeqt3e0ZY4QZKZoSPg5Py2ugg?=
 =?iso-8859-1?Q?gFJY/+HgPql1NwashTFbrKTpC7ibHZ3nmXdx/8B8rT9WM8BCPlHES/ktEW?=
 =?iso-8859-1?Q?hYXX4uhF6uJ5z6tmf1LsJfEtFdUR1HpQvQVlLLoJG1Y3qA8nUubjZxXlTW?=
 =?iso-8859-1?Q?ZY0daiGtmbKoQr+ACo5bfOGSH2lnlCbpaxdC44F6k+PRLr0Da/wkmTWcKZ?=
 =?iso-8859-1?Q?QZ2XWeiyKdil0rosp7FQiiXS6y640WQ40IO4wSC0xP9WQ06GxbSpE4zCNO?=
 =?iso-8859-1?Q?X9HBTbZm5GEW1BRvzxSkq6GyQ5nZ5O8pvCN+221iKuixFP9fZbP1txGQcD?=
 =?iso-8859-1?Q?hm9T23al5m4R5YnOddNC6iVT6UeGNJPi/pH49+dWfN7giP3bPYwKSkEICH?=
 =?iso-8859-1?Q?3ExEqtbVoAWClXppJuxu8HKtFWz4LXw+V0y1jSgfi5sHbMxVjWSSxpUkKW?=
 =?iso-8859-1?Q?JiVDl/FgHegq5JdOTmHY7uj3+YwWYetI51149MklTbbks+SMmAt+km6jWu?=
 =?iso-8859-1?Q?cAcMtq7m5LgxSrUPce53vXNAGyzFf0eWmdlaVyBoQAYU7OQ8s9MUD/dbuC?=
 =?iso-8859-1?Q?lfOnroz+8gteHwIoBUwdqzIqGVhygwqE5D4vNu1DQSxS9FrATJa0iAiPWo?=
 =?iso-8859-1?Q?MbJgtVLEkUp1j6LRx9QZ5evDqjK76oVP9u7398EwClXWBI+fyeARsLBXka?=
 =?iso-8859-1?Q?KPT2LZIRrwsEcyFKj9vbVuVspYailrJ67WT7wvJ90O6C8EqSInkXZchqtT?=
 =?iso-8859-1?Q?cBqL2yVbTgHKIUAqPezDGRjVIpTjC2vrDVMog6PviVXaCSCUh60WjUHH3O?=
 =?iso-8859-1?Q?msL7DCf76oUzE4PcxUwTUX+in6fF2jxwNw29ojTasVG7TbFk9FGgqHPSk/?=
 =?iso-8859-1?Q?Vw9sitiS+h1hFYRghnp0A1640y5lMRscegNT6SlhmtQOfaEuEdvwE1vUyz?=
 =?iso-8859-1?Q?PKmZ2N4muc5Q6nMZkYtYTXkyn50qpmHeqx3Y53IlQ42b40BImMDQzHD+U2?=
 =?iso-8859-1?Q?a4iZvYiI8KwKtP5W1GZ3Txrw5Fwb52iSUnSxjHbpcOHD+Lz/+R8HJKFAia?=
 =?iso-8859-1?Q?PEP1uhGVUr34pJ9k9oDQ7rICYI9dEB8rPwvXCIja8ahzGyRnj4at7tgRyd?=
 =?iso-8859-1?Q?FgbTMpR7LvtcGSBbFiNjtlA4NTmt3fF1WcxHzosP/Ug8Db67/G3mDpiz5x?=
 =?iso-8859-1?Q?3ehBDdnr99/Bg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad873c8-af7b-4a9b-3be3-08dd4a3e3c0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 01:48:51.2178 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zEsQAhH2HSlYR/TBGo355qtdeaQ8N2Q8mBUm3SwXyv1TOx7kABVlVqIrbF8mCpxyS/ActNVdRRwkVKHL4yXe5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8043
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

Why only free the mem when  unified mes is enabled , I remembered that set_=
hw_resource_1 will also be called in none-unified mes mode .

Another thing is eventually we probably should allocate total 129 pages the=
 same as GFX11  (128  for hw_resource_1 and  one  extra page for MES intern=
al usage) .  But seems SRIOV still not use that 128 pages, It can  be  upda=
ted later when  I update the API for gfx12 to enable that .

Regards
Shaoyun.liu

-----Original Message-----
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Monday, February 10, 2025 4:19 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>=
; Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/mes: Add cleaner shader fence address handl=
ing in MES for GFX12

This commit introduces enhancements to the handling of the cleaner shader f=
ence in the AMDGPU MES driver:

- The MES (Microcode Execution Scheduler) now sends a PM4 packet to the
  KIQ (Kernel Interface Queue) to request the cleaner shader, ensuring
  that requests are handled in a controlled manner and avoiding the
  race conditions.
- The CP (Compute Processor) firmware has been updated to use a private
  bus for accessing specific registers, avoiding unnecessary operations
  that could lead to issues in VF (Virtual Function) mode.
- The cleaner shader fence memory address is now set correctly in the
  `mes_set_hw_res_pkt` structure, allowing for proper synchronization of
  the cleaner shader execution.

Cc: Christian K=F6nig <christian.koenig@amd.com>
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Suggested-by: Shaoyun Liu <shaoyun.liu@amd.com>

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_0.c
index dcbc31279f29b..8dbab3834d82d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -678,6 +678,9 @@ static int mes_v12_0_misc_op(struct amdgpu_mes *mes,

 static int mes_v12_0_set_hw_resources_1(struct amdgpu_mes *mes, int pipe) =
 {
+       unsigned int alloc_size =3D AMDGPU_GPU_PAGE_SIZE;
+       int ret =3D 0;
+       struct amdgpu_device *adev =3D mes->adev;
        union MESAPI_SET_HW_RESOURCES_1 mes_set_hw_res_1_pkt;

        memset(&mes_set_hw_res_1_pkt, 0, sizeof(mes_set_hw_res_1_pkt)); @@ =
-687,6 +690,19 @@ static int mes_v12_0_set_hw_resources_1(struct amdgpu_mes=
 *mes, int pipe)
        mes_set_hw_res_1_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
        mes_set_hw_res_1_pkt.mes_kiq_unmap_timeout =3D 0xa;

+       ret =3D amdgpu_bo_create_kernel(adev, alloc_size, PAGE_SIZE,
+                               AMDGPU_GEM_DOMAIN_VRAM,
+                               &mes->resource_1,
+                               &mes->resource_1_gpu_addr,
+                               &mes->resource_1_addr);
+       if (ret) {
+               dev_err(adev->dev, "(%d) failed to create mes resource_1 bo=
\n", ret);
+               return ret;
+       }
+
+       mes_set_hw_res_1_pkt.cleaner_shader_fence_mc_addr =3D
+               mes->resource_1_gpu_addr;
+
        return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
                        &mes_set_hw_res_1_pkt, sizeof(mes_set_hw_res_1_pkt)=
,
                        offsetof(union MESAPI_SET_HW_RESOURCES_1, api_statu=
s)); @@ -1770,6 +1786,12 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_b=
lock *ip_block)

 static int mes_v12_0_hw_fini(struct amdgpu_ip_block *ip_block)  {
+       struct amdgpu_device *adev =3D ip_block->adev;
+
+       if (adev->enable_uni_mes)
+               amdgpu_bo_free_kernel(&adev->mes.resource_1,
+                                     &adev->mes.resource_1_gpu_addr,
+                                     &adev->mes.resource_1_addr);
        return 0;
 }

--
2.48.1

