Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC69CAC5BB
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 05:58:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 255EA10E067;
	Wed,  8 Oct 2025 05:58:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QZ8bGqGN";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013062.outbound.protection.outlook.com
 [40.107.201.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80FCE10E067
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 05:58:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XnbL+NsvrWgBrq5iaiTdD1a0ByT8660K7xTprre5UC18dNqowqKDUuo8G9qRNOrEO/Xcq6DsKUEE5nruo46UmcyKTZSDujy+ZKQ7HGlxK3ZjG/EWhFvBQjOAHML2yn3pSwgwqPUxL2ZAxFETrAxZwsmI7sPzYGbQ69UmD6Dcl5cfpShAxio/izMks5lgiOxf8qAI+sFY8aF6GiMVt8VWNGOsmxMYI8yNXb2jy92U7r7zH2JkHKGNMJehmef+nMPK5EAfHkkOxmQPS4RPB3PViZ0b4GdqZclR11uzZzQ4KLVrmV03iV+T3iNVilOShmrUzfDzxWeUIpzEsXQMnL+E9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WOJIN8VvnmxI9ppYB6Bsi/bJbl31SvB3SFb29uIxIU=;
 b=YktmwkBm9DgfT9q0qCQoa3KuwZ2HASdc3Tps5N3yEfr2GmgqkKcjdSMAIjxAvWATZKB+MbNB5xtjChwbRK2tbKvPpfm4cQge6CTOadremfqEA8nkQ0AZv+/2qvqIgKvgVG2e/KLBuDopaXQdv0EwUxWLrR+Q1ZeDzjmrkFYso7XkMicNBp7eRW9LgtyX08oUEgbtO5sX5Qi0pMbGET07U1v4e/wJlHUTT9xPTOOX1fsecogeKMi+mMT+xVj+UunEvT/e91ZgrZL6qe6WCoEPq1QBuzHnVQwqkXgYcHa//5cvi0OLGmI2ayNlj7sAEHFZOAykzzj57aAMFdq/Lgnr+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WOJIN8VvnmxI9ppYB6Bsi/bJbl31SvB3SFb29uIxIU=;
 b=QZ8bGqGNCR72u8GjprtZOEx/8ReaYs2C59rjjqoTgc+l+u0Ry9eHjZZvk7RQVWkCezRaCy9KWtY3yhnyHdThVyVvf54t+uuhbLSzNZSvMWyasizLVXm3AVBmy1El9WQmNIe1M8tD+QT58Kg9qTMuGhKsacT6WMoQW6BegBssYBI=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA1PR12MB6776.namprd12.prod.outlook.com (2603:10b6:806:25b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Wed, 8 Oct
 2025 05:57:54 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 05:57:54 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Skip SDMA suspend during mode-2 reset
Thread-Topic: [PATCH] drm/amdgpu: Skip SDMA suspend during mode-2 reset
Thread-Index: AQHcOBEYdwXycnuXWkSBsFJHOzDBBbS3v/IAgAAApvA=
Date: Wed, 8 Oct 2025 05:57:53 +0000
Message-ID: <DS0PR12MB78041875860C8D6AE96AA44597E1A@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20251008050418.3399656-1-lijo.lazar@amd.com>
 <DS7PR12MB607106FF830947FC304CD9E88EE1A@DS7PR12MB6071.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB607106FF830947FC304CD9E88EE1A@DS7PR12MB6071.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-08T05:57:09.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|SA1PR12MB6776:EE_
x-ms-office365-filtering-correlation-id: 7b60e4c0-ae16-4b60-ecba-08de062f9f58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?TOihPL3VmG9194XMSgNqnex15RiEws7qOuQS4QPrvV4cqckmBjfQRnOu1jYt?=
 =?us-ascii?Q?uzhnSCTrP2ZJKCBl7popCBvCG3nyvyazcqdZdKmUOm5ZwEa/f+iGohwEjI+P?=
 =?us-ascii?Q?jWgMKv17K8LibMD+UkOP0pQ8vS6zrZrAW8KhEMNDCr18+nwE0InLyNvxpui1?=
 =?us-ascii?Q?WjcrTCX3liwHAtTOnCxJN10yE+0cQewg/wUQ5VljhF8cNZ7an+pUYfkATx8j?=
 =?us-ascii?Q?IEm67qyuu3vkJCuKU/fWxhuizNzGYWNzhJvm3+IZ0gHWfD1FjojOfoBi2+nq?=
 =?us-ascii?Q?n4VvgNcFE3t2dEF6Q8v10kN7aFKgju6WiLXZztgZmXyeK0cN2vZWColkMwID?=
 =?us-ascii?Q?cjbA4AeTAOdwuceAMFaBFScbePFyYBSpp6s+RjJZWcmXFivL+j5byLi+wLCd?=
 =?us-ascii?Q?xjDWyNMA4PvFx0em/Fm+G2+Xqlp4lu7ZkdfO33Y16Pi9KV4zUQNgll2mZ7o0?=
 =?us-ascii?Q?LqrZ1xYsbNcxkNrq1qqqIPTTBM88o1YD0/zaOPxXw2C11Ttzk0FZ6/fflL/t?=
 =?us-ascii?Q?DEtGQ/7wT7l1icALnJn+4EZcJDr3OcSpkB0GGlYW8atB1fF4uIFI969+t11x?=
 =?us-ascii?Q?5GzcigSGoKboWSVLQ9MiN37ofT6EMpX+wobFAI3VqSkJ+ntfUeiPWuF0d/Q1?=
 =?us-ascii?Q?mxR3AESAKyQtjbikkqVzAbQrhWETwZOWsHgbp97PknMl8KtOqwPtICO5Nw1y?=
 =?us-ascii?Q?guoWNSzI8AB0FCobtoae94b9f18tc4CGSFPsY/deMEBdLHGK4HTmMTaJBQiV?=
 =?us-ascii?Q?B/HtWbKRxypXb5tDNs9m3DYfkU4XwNYhZkeWont9LF2nQDE5bGNQIOwT9P4U?=
 =?us-ascii?Q?avK8/6T94g5kq0u83mxHkm7IRf+2bCYM8KkBq6vibvlDo7n8bJYEW3+I+SIy?=
 =?us-ascii?Q?aNZMnfwmQ8wE6mlN7mw/F8XaXfcuVEIvcsOBz+T409vqbFwGQHVgsuN5L9QP?=
 =?us-ascii?Q?NbTie1LQwttvQb0JuiXllzXvKYmOd3PySHlNTH0ifPI3+x+bVrhrPpU1yFJp?=
 =?us-ascii?Q?sHcFeRIm47nagyy3nSOo3L7U/q1BA0jA49Ck42z3wt2xzeNsaRjs6iLig4DK?=
 =?us-ascii?Q?agqwLcqoKQZEIgm+RIf4bWkYTZpxk14VFB02zvBQ8yI9tm6Kai95uTieKhX6?=
 =?us-ascii?Q?x6TXn7JpM9/lsm18AEUtnJjJlW42xGITkSQUrjxrHgf05/CpD7q3VJ5SuGKb?=
 =?us-ascii?Q?c4mZaEfqPa+KznxQBynPU88BWT9LpQQK4a8UiMsO2DQbzV00mqhvMNWzH6u3?=
 =?us-ascii?Q?rk0zj058RYIoVDPbb3aM8jJmqw6/9mbzQ8+MeZzWRoNlbOYSAXxYpSlDXmMI?=
 =?us-ascii?Q?1kqskv081CjxWjZ9C8fpXtOUkDN4DjMryVICUmzgFsktnB/asQY7sXjvhLB2?=
 =?us-ascii?Q?bXt2UcXsvDHOFckXn1pFBt9N3+46sfFbgGacaWratnjo3TxcKOdisom2DxPR?=
 =?us-ascii?Q?hgp2Y/0eR0kunuXSUTQ1Ntrlt07XWgLSsKiHkhZV6cBfGyhdLfbmEM0/bLD9?=
 =?us-ascii?Q?2sDsd3taG+ba/NaP407DTWpVfzBMyt5bs6Gi?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9pKF6eLP5uCaWOk/2XynmiuyQ3NIcMucqLsVh7KbqSokDU2eU3j2xL+Lq59v?=
 =?us-ascii?Q?9EiWqFJYrWiQJw4Y7PcWH5RTfU4BMH1Yc55xYz3y3TIa5P0mnNd2brksdc+N?=
 =?us-ascii?Q?Ebrj9HKvqgojdcpeeB2Sy3MA00RqicIXLZLqGPQeN6UUi8PNIpxnZIq1xT+V?=
 =?us-ascii?Q?kX8is+/BKjbjoE+5ByLQ9TkCzRwE7p2g99lEg+TvPFKV7T0feRJIK029D0HQ?=
 =?us-ascii?Q?Es/lA0K5QDtI4AgzHFupbqHDcdZdJRhwu5hn7z8R+n5lotAurVfQ7DscbXNv?=
 =?us-ascii?Q?ZZCofdYjvnJNfW5chV4xdxUPhY2KdcTG3Orkx5xsKSusCaFOC/uOM49V3AMf?=
 =?us-ascii?Q?MxsK143GGfqVVh6NK5mLbEvSpvSkJm/GAduRIJl136eubdb8QWvpduM4VZ8I?=
 =?us-ascii?Q?sBamYDwy6KIsj4JlAnQfU/B6VcdE7r1di+NodaWnjgIL7d9Q7SJIlgN47vgE?=
 =?us-ascii?Q?zghhJ/Mf0g76ayu/2/3CfD6BeOEJ9PuSKMlHYkjL19TJRWctjNPXbZu/IwI3?=
 =?us-ascii?Q?6KWZlVUov9+6r5gb6UTQe+LKysUAEkRsUEMP3I9AfsU4DhttgMwrbCl54zE/?=
 =?us-ascii?Q?gPcI9OghWTQqAlboLd9vCqeETAwEXOaDiUwczMs0DXO0nzK2C6VzTaNIQF8j?=
 =?us-ascii?Q?ZdW4F1nMkRANdT5cVKG8GTibhRM49xp8ArGtZviox5XY5H6vnwvSD6xN5QOg?=
 =?us-ascii?Q?jbyuC06Xkc7DRA+Ss+ZgTbQ7eKQZp3y7GmbOE5teqLdWdh+H4UXnOsFTwnkK?=
 =?us-ascii?Q?+c4l0w6obaMLGnhM6S61UppsbCZeopFcW0z+/j4wSCvdx7Kyxz01RhbsaKKP?=
 =?us-ascii?Q?nGtZHMMwHxW6+y1yzvOuV2//u+PlfQY/k+xO0WYnNioWLpc62DudLxlIM9TW?=
 =?us-ascii?Q?vXva+3l+ebg8U8nawV+5BVcVbesBNUysgOwjoIij1yOzexo/6yLFpmfyMiiF?=
 =?us-ascii?Q?Oe/ywppP/zGhhFyRop8aRleTPktC3n68Y+/Ez2LFuPfVe8s4GtT74XngeHJ1?=
 =?us-ascii?Q?XcLhml+v35g2zwQ8skgVUOc/rgUsV2jU96jlXy5a3O/SknnzvCQgA0BDjAJd?=
 =?us-ascii?Q?PnTuRN4aW1fYLMXAv460Fu9GNYZIXetcNYM8Lj+8tGEVIDVKZPDKYN/NKIYd?=
 =?us-ascii?Q?aewSmcDJURtItqHVbdXDVjTtFLT2BD67LwJpxFMNlJamo416qIzGzArIwfnt?=
 =?us-ascii?Q?SzMaubAvV8/lG6R//MkqTf+yfQCFW1Bw2fgEY7aPD4W/d9TwhqF//DIt//Ad?=
 =?us-ascii?Q?I5B+OpVduiKS1LtAvLm5hONoizOl2Fo9GFjIOssS1Ya2qbihZzL2t+T4XG1V?=
 =?us-ascii?Q?PMzVXkC07u8YDUxjirCBe8nU5y/PxQa+OTsIjqpB0rgHQZlwWDtQ/Ijk0QBY?=
 =?us-ascii?Q?p9uwwPUZscP4f6KWY1fRCiCt7I4n9SGqqPEXWu3oc4BZ9V2HmnGrX+rk4qRS?=
 =?us-ascii?Q?xgi5jId4nP3O3t7/2PjPFcWSQhirQnvtx1JHe/fVHj3UzHctOki+n6+TqmQx?=
 =?us-ascii?Q?aYIY1UJngycmhXmdoMziUm6YBUiUVP3e9o88QQybBGdLpocFxVTz1Vvpk0eU?=
 =?us-ascii?Q?7OCTxQJ3m6oC0V+lx7M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b60e4c0-ae16-4b60-ecba-08de062f9f58
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 05:57:53.9522 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M1r0zFfCrrML3AsaWRn0IVfZEynzGo/Vfl/z+LFq+92QUmvcWG/HTY6DzL57GvT7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6776
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

Good catch.  Will change the comments before committing.

Thanks,
Lijo
-----Original Message-----
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Wednesday, October 8, 2025 11:25 AM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Skip SDMA suspend during mode-2 reset

[AMD Official Use Only - AMD Internal Distribution Only]

With minor comment and patch description changes

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Wednesday, October 8, 2025 10:34 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Skip SDMA suspend during mode-2 reset

For SDMA IP versions > v4.4.2, firmware will take care of quiescing SDMA be=
fore mode-2 reset.

AK: Please change it as >=3D 4.4.2, same for code comment below

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/a=
mdgpu/aldebaran.c
index 9569dc16dd3d..0007d00b9e8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -88,6 +88,10 @@ static int aldebaran_mode2_suspend_ip(struct amdgpu_devi=
ce *adev)
        uint32_t ip_block;
        int r, i;

+       /* Skip suspend of SDMA IP versions > 4.4.2. They are multi-aid */
+       if (adev->aid_mask)
+               ip_block_mask &=3D ~BIT(AMD_IP_BLOCK_TYPE_SDMA);
+
        amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
        amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);

--
2.49.0


