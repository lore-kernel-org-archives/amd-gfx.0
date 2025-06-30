Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E36ECC7EE39
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Jun 2025 07:52:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84C3310E3A8;
	Mon, 30 Jun 2025 07:52:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="khHwf8X6";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DD1310E207
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Jun 2025 07:52:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QSTBx6QmnJ7i5WA1VeU5HZf78p3rPrgeixejktotHq/ZIyLwgJXwlkyF/R71SRC4I7alv3fT19K1O0cAQG/qJoO0HSGfiGGv1Rl8JmEe7SJhh0NAGVvjtenwMHeFNM1OqHkwUhYFbceNV/Pb/g6LjIE0jrLjT0Lwr1UGni/eOW0Cbn3jxQ/mMW2aJB3dyZYBxiAm1gYJoG299hLw0oP+k/E+X9fBuxVbgdhlqYmZr5pAi1tBhgPdCgcbI221/sraUjYkf7f/gogl6SefFAosYOH1bn5SMELUwCyn63GLkukxYeZZc+Ijubyg1uhIfriTyp10hgy+N1TsKYcJOnS+0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWjn9joBq59bDTnEV8shg4dB5MCNJzTZaJ+2/+GHVkk=;
 b=fFxIFhvjrJOgpDZN/T5vsJdxAXjRyWaZManNyArhMpNeuXKPVwrR6uMOxlbVJMzbrE5s4PO79g8XK+ldh5L8DnfANmSfpF7/+GnI+ola7rStW5a0IyVuMJq6SBWSMwfVhWdIu30Jep0m7iOL5etPOGhnD2IvZxa7GWaTZP1lNTlQDR838fARSugFNUMszR1iDG2QZN5sVpzHRexCcy7Y/594E1YUcwRSg4YbzhH2pBiWxJY3iOoTxCJtAuTKleNsjNGRdfAFEKE+mx+yl50+PcDPyT5TBoxMAoUPeAr6uNvuc+han0mwIfAWEXIcOh0PX6Da0dHUEu7pO2DbVZ/mxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWjn9joBq59bDTnEV8shg4dB5MCNJzTZaJ+2/+GHVkk=;
 b=khHwf8X6jmM6pgECTkv8CM+bZMZ4Yy5VHilEdaUWn39I5SmDtWzd5fQzlEqrpEDSHG4Eus92D+gJbcPK8JT8Dx2Bidy6gGFe8BZjRfCAzosd9anEuiwuCv0ZPNolt9k57/epDSgQZZyGcZQ6x4nNIMXb85Wm1JapPnr4E1AMXnU=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Mon, 30 Jun
 2025 07:52:11 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%3]) with mapi id 15.20.8880.021; Mon, 30 Jun 2025
 07:52:11 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kim, Jonathan"
 <Jonathan.Kim@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Avoid queue reset if disabled
Thread-Topic: [PATCH] drm/amdkfd: Avoid queue reset if disabled
Thread-Index: AQHb6XlJqgI358XIy0qec2HkjHYMs7QbVLsA
Date: Mon, 30 Jun 2025 07:52:11 +0000
Message-ID: <BN9PR12MB525730D5253C28923AB5EB98FC46A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250630044123.1261300-1-lijo.lazar@amd.com>
In-Reply-To: <20250630044123.1261300-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-30T07:51:51.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA1PR12MB8599:EE_
x-ms-office365-filtering-correlation-id: b31601a2-03d8-4c5f-d002-08ddb7ab055c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?fWtxXe+JIUO0zx0QEfxiVu6iCPAOPIB06KyZnrmp6bMIz5tt49epUIGUtrCI?=
 =?us-ascii?Q?EXNbvfSlEY6WDmtcbFY7k8can/umwfzMw7mwo1/CdyTTUfyXqhtRsmMLkqQm?=
 =?us-ascii?Q?FbTq/V4DK/gGHUJvOBe8sh8sb0ByrTvnHu0Te5Rqv68erBggi/qdnEu4jOTg?=
 =?us-ascii?Q?Ti55YuBSdnCXJiLP0ZzE5zwMLUjgTYEfn8YhATpm+B4nl2LZlVKpZowoxFSB?=
 =?us-ascii?Q?pdn7TtXmogERQF8uxPQSulr5LGhcUf0RqwWWx1LN8RbR+WedGNEJzvsanlbf?=
 =?us-ascii?Q?78Kj+wZiU0kwGIkrBypxnn602txQ8FeGny1h43v54ozSO/QzhZxuKwJsXn4g?=
 =?us-ascii?Q?xVoNv9xcCRSYazZB/WXyuJ9tUQBigI4sZgcutq/UO9qPNp4w7pamyicwn8Ru?=
 =?us-ascii?Q?4oDtRRsWrvXBnb2ZR1AQ36TATOLE69oDVwPoDA/oWyYOXgirtyGIaR7PTlcU?=
 =?us-ascii?Q?tF4L1o8P107jea6cR4gcTKEKWG8tPnqtOSpEE7ix9sgfpkpw4tnR+APCC1WZ?=
 =?us-ascii?Q?5GC3o1NXFP8r++OEhskYVIBtlDpSZZwj4wS9ygwB9RD71zHnh5qCxgoTN0w7?=
 =?us-ascii?Q?2C3XWobT/IxUAa8ucAfM6/xzc4WQG4faRmkwLxWEUE6ppp4L7K259G2aXFC6?=
 =?us-ascii?Q?nkeWAOjW/174SawoZQf4VcdIOjoBCiWVQKjCw3i1/HK8Ehfg7jdrKfxFtR1T?=
 =?us-ascii?Q?DITmchlM/sUg75ShqQZfwc66JYdHjvocZ920SdXDCVHlbli0Nr7fongMK/K2?=
 =?us-ascii?Q?sTQPu/VZ1Hny78Vi+kg/1qpILtg7tknmVdQUsavnKp8gnjkEK0xdSTpB8W5E?=
 =?us-ascii?Q?A9fhTan3905jHK6InFWeWkYl0z9Sm1wjxEWkFw8GcFbYRAbWgBe1Ou/wR+SB?=
 =?us-ascii?Q?KRwV14qxJaxYseA26Yqmmzum/WDYB4DXHcPJPpcFicIdrWlU4wMAlJFJRnUX?=
 =?us-ascii?Q?YCiJ1guZ9GYmQwGPHntMEVuYNi5l6w7lIpe0hPBobo+FHMnFvItmWti+zp3K?=
 =?us-ascii?Q?ziA9irQcoxw2MnDA+3xrAZd7lag3qCUQRNzC8RD926kXPu+Hsjq00Uj7tWKN?=
 =?us-ascii?Q?5a6k4RYxtKIRHhtpySYRMlHgy9dcQW8TYSGEHyGvN5hxX/hF8zu2OJADQmWd?=
 =?us-ascii?Q?XgKzBof1KLaYE4ThXHgI0paMRB6Qy+CKjmGwGRsqN6xKdMsmRdkAY969+ikD?=
 =?us-ascii?Q?cLDiCdoF+FHCBlq55y/SB1Z0jgm7ldChD1oXQBS98th9gwc7zvry8Cm+E/nP?=
 =?us-ascii?Q?GvBpTiTAApall7y9iy7eNoAjqJI65lop20NJYPcFmed4CAH0LfW5UzbX+qXu?=
 =?us-ascii?Q?bxWJtH3HraasnpAWqFfltxdqdI5o2t3iOrZs8/T88VDCERj1khtOuk3NlmHg?=
 =?us-ascii?Q?3sS7K+6Z6QC5fEM0B3tQuDjbPPks+B62CQ9I6rJN6t/GD/SnjiBJSZJzoIkU?=
 =?us-ascii?Q?GHLwBfYUo1bd6KuhfWFDISdKmI/PTytSnIJVfFEuOTeF/+MeYHskuem3sfSO?=
 =?us-ascii?Q?ah8b5iU40hC8aUs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cPatXKFxWZTn/X/aTF8Jd6grbNEWzYvSvvX1IGikuQ/vylfhTfVl8OcB74xb?=
 =?us-ascii?Q?JtNsFIF4n52aTU9ue62Pt+2Xmv0WmXCSo5SU3FcmZI9tmuYxfTh22AwyByqA?=
 =?us-ascii?Q?GnMz0UOEjq3XhJGx06S+vUzuOWsr0WI+V1FdEZB775EKO2i84F5VBYoLK5S5?=
 =?us-ascii?Q?Pp6Qg8iUv/LHAxaub4cMQ1qPCs6mzdJ4cdbZTjA7NKPTJuwP8EmP6QSeSFTC?=
 =?us-ascii?Q?0ZMLvgTYHV2KtVBZNL7vYdCEw87C/15LaamnE5U5N2WWSEXHSGQEmLbwd3Tg?=
 =?us-ascii?Q?GrvM9z0YoApDXGYnmZy2EO040/1JZSP35Kzeht9FScgiLP/2I5yPIRY/C48t?=
 =?us-ascii?Q?3XhA7TZDHdSB6mW8Flr79zAK6RE2CFh6fAvfdpYFcYJUylUa7WVkSsXgTw08?=
 =?us-ascii?Q?fNX+ZAwl6r0yXQEUOwKgm1/kmwALtkdDvoP4SNvkJhi854PLjkMT5cDhN/Tg?=
 =?us-ascii?Q?uo/WbHQJFqn9YE4FDd44jTA7AtFxlQ8dG7h5OTFYVUlx8bQf4tq3Tt/6vavL?=
 =?us-ascii?Q?X3t0jbmrFVgIZH4y6MMV8xX1Jfu/AeX/z3mqS28u7oc1Vps+xSQ2EFhHCJn+?=
 =?us-ascii?Q?gPgfw415LGDuGkIAuF2VTAP1pBi9/U/wg19VtTyL7S5Q8w7bIo3cx18RX1G+?=
 =?us-ascii?Q?KRC90ss1izSICwadtLmNexLSFMC8C25w5eFTiPgwUTZtnewmYEctzlSowJ4y?=
 =?us-ascii?Q?zagbqaymFlUlpiwBBgcBI6/nbLoMYbE5//qFM7u5n7+5/1OxTIanAgfUARSt?=
 =?us-ascii?Q?a95NADctKZcrVCXunCr+QOizpt3NGZaKEPRh/DNmLMwx2I5AJqFU5t7MMT/T?=
 =?us-ascii?Q?VjXD3ruPKS/rqyDhD+bvop73UixShmR6/xacO/jAk8LNUe7z5QC9I8siUzLE?=
 =?us-ascii?Q?IT659Qu7o1s/hFDB6jeKSD5tVzixnVKjF7BVaM1lQ5A5rZF4ZTYdbR2hNntl?=
 =?us-ascii?Q?1UAfD0163Wyb8r2Znt1CQucXdP3+Hv2OZUxpqCqj8qs/b0SrToHqmeKWFm4J?=
 =?us-ascii?Q?14VdLD4qhtKWnM3qKM2Nw9Yr5Mn9r9xtYbRtyxSTvXV2FUA69TZ+amlP5QYA?=
 =?us-ascii?Q?5X2C94o0pdQtgucE63+Qc1alkcIDidN5Ry5Ho/rufwlGUKkgbALOTLCJRfJh?=
 =?us-ascii?Q?xihKhK24rGGgzKtwnffbRuYBlmjZY/soT6m/nhS6RQaJpYUOX3pqIYQTGnMN?=
 =?us-ascii?Q?XO3lZE6EAXv0MxHgbbSni/9XkAv6a2QFXMljIrRwY2Mpq7eUqUe65zfYC9Yp?=
 =?us-ascii?Q?e0+n/aZC50SYCKZNuFb9DuRw6cnD4BDSfn8mlvL7+3sDauESO1VKDzkH5XMM?=
 =?us-ascii?Q?lVe2mbcnslVwfXqucFGlVsbty6rUGplTnZeXYJdGsvPUKZX53v6HQn9j6/hc?=
 =?us-ascii?Q?qUMHH+jReRZBdjDroaMIBZugxyPKJHqwG02MAhinzpXb9dwXnVKylJB0o7qi?=
 =?us-ascii?Q?nv8dfEfW4/a1+YcvDJARiVReB3P8n/h48gK04921Vol3ll1pSyc83IlcuxAZ?=
 =?us-ascii?Q?cMW0V50l9EnAE9VsHZn4vzdFO6JuA+02V8WrNz9PVg1uykf/ZeniDy2th6c3?=
 =?us-ascii?Q?vqs+Z76/Ln1o4RlrxuM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b31601a2-03d8-4c5f-d002-08ddb7ab055c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 07:52:11.3550 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rOaCugs08se1z8EL9KVT5s7uthzgAsJabPio447qNczZnB11r0mubHRt4I6tkQ/qOaTAti9VFVQTIg+fJi8kcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8599
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
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, June 30, 2025 12:41
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>; Zhang, Jesse(Jie) <J=
esse.Zhang@amd.com>
Subject: [PATCH] drm/amdkfd: Avoid queue reset if disabled

If ring reset is disabled, skip resetting queues. Instead, fall back to dev=
ice based reset.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 76359c6a3f3a..500f51552038 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2339,9 +2339,18 @@ static int reset_hung_queues_sdma(struct device_queu=
e_manager *dqm)

 static int reset_queues_on_hws_hang(struct device_queue_manager *dqm, bool=
 is_sdma)  {
+       struct amdgpu_device *adev =3D dqm->dev->adev;
+
        while (halt_if_hws_hang)
                schedule();

+       if (adev->debug_disable_gpu_ring_reset) {
+               dev_info_once(adev->dev,
+                             "%s queue hung, but ring reset disabled",
+                             is_sdma ? "sdma" : "compute");
+
+               return -EPERM;
+       }
        if (!amdgpu_gpu_recovery)
                return -ENOTRECOVERABLE;

--
2.49.0

