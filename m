Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB359C25B75
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 08:52:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69F7410E15E;
	Tue, 14 May 2024 08:52:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xa0pHxaD";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2063.outbound.protection.outlook.com [40.107.96.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD2CA10E15E
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 08:52:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8uKROgRoyMF5b1qCKk7WVzIinzqX6nYILJEVsJZlCZ+da+LdYdROgSbA9dRfuWNY1mgtyW+6ziUZKODTqxnbfvaM65LTTObMKJABNNy61cnIMcK5XNa8WxLS3zb8xzHD2pt2KJvfl/G86OKcY0y2CqTeAF8r5MHySr/xDgueD27TLO7GbgpxizkfjqwzqnL1q6UshiLeptywBWreg0IerFIW9exD+nSOz/QbzrhfgT+N3WL9/umhXOyldUJ4V7aHoe43NNoM2YrTRmcJziMp/QFCKkaohSZ9uFBfCkXPDyxAHlUturYp3kzlHfbHU6HM/GOu4kvqN3bGFQo2/ByiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zu/ZPE6TzMg2GcCfJ19jTu5v/gSvQUiF7B4gh2Ru17w=;
 b=P83pgsMbb4b86DOGbNqJQneg5pcaO7fsMfjXt9hXdDdFuIh7vdbi6BkBJVUwXgWM/wKtFGeEYfFqARzS7XzgrYelGHiF6awV9CVCNPNIpgZlQ4F815suXkdzX6xzD/vOXUmbgxu1bFBitElLwj34EPpBT/2V7XVkkYW1Yul0QOj7vCpQOtyBQJO/qLVbRpNVAr7HMV4od0vUVmXStWH4p27Cp83ko/3N8xh4xPUKZMGrzicA6zMJPAa2hkt0KczVkTu7KtzwWSXd9dl1h/bEOlG83Lrvy3KP4cHPVs/dWZY5f0VfcI4YmnNZjo9fP/HQjSdRb6GR5wpG/T/fUKO8Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zu/ZPE6TzMg2GcCfJ19jTu5v/gSvQUiF7B4gh2Ru17w=;
 b=Xa0pHxaDU/6KVx1w0rAdqoxgFsVJf1qO/1hZLEC+ogKW8vQacDWXzb4cNs8xUH7L7slSSLokxhH4O0/WkDa87sD7PfGmpn6PdEdOIkzVYIJ4d5Svoo7FByP8LZ3eOBQZMfB6j/g+E25l39gZ1LP5/mXXQzm9ALzBTPZzFPrtFf4=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by CY5PR12MB6154.namprd12.prod.outlook.com (2603:10b6:930:26::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 08:52:36 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::b1fc:750e:c91c:6d7c]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::b1fc:750e:c91c:6d7c%5]) with mapi id 15.20.7587.025; Tue, 14 May 2024
 08:52:36 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/8] drm/amdgpu: enable gfxoff for gc v12.0.0
Thread-Topic: [PATCH 6/8] drm/amdgpu: enable gfxoff for gc v12.0.0
Thread-Index: AQHapduIPxA05TMEvESIi7w1bRzkr7GWbE0A
Date: Tue, 14 May 2024 08:52:36 +0000
Message-ID: <DM4PR12MB5181E0FE54EA48ABBD6D7FB2EFE32@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20240514084751.3438103-1-likun.gao@amd.com>
 <20240514084751.3438103-6-likun.gao@amd.com>
In-Reply-To: <20240514084751.3438103-6-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=e422abfc-dcf3-4965-8da2-271602f24854;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-14T08:52:10Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|CY5PR12MB6154:EE_
x-ms-office365-filtering-correlation-id: 7bb7caf6-b426-4723-f004-08dc73f333eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?Kf28qmrFJLFnwK8HvIlIy8B6l53TiyBbQgHFNzlNlOy5GXVtlpNWCG+33pN/?=
 =?us-ascii?Q?p+K+htHjmrcTmUwT8VCs4V0m7avqKejsrL/bEoGKjpdF0IhCPPcFfbwdeHxX?=
 =?us-ascii?Q?QPKubfiyETC6bgsQiJxvXxgxwF+9Am0zODA+/euNdI8xUqdqoGfa7RwmFZfr?=
 =?us-ascii?Q?hkAEF2eAFyGr9rd6/YnEvPdp4vXH3nenXJAhNF/WKpRlrDuGcFYQCliEbjrD?=
 =?us-ascii?Q?f9egponZzDqDTpenLXblQMXfN3z9JnhL9ioTMAgBBBAgEPlm2rMg4UMMEeYO?=
 =?us-ascii?Q?s6pyBx4oG2qfc/446DRhdvS5KXtErTl1wE9ua7IHhghhr4qhZo7cydUSwh9s?=
 =?us-ascii?Q?UqNcdMMtGTe/gZRC36fV4i1n4zk1Cn/V+nsdHcNZkO+GZNGk0+w660rhk5FA?=
 =?us-ascii?Q?D68dv70Gaz9nGV4cDKdYcErxSbXtRAcddAIhclwynWlmobehtrvjgaREv0H1?=
 =?us-ascii?Q?XiGSZmLBM5FPwoUmedyy7Zmf0lWBnFhzic7nRqCvFn+wfGTIQgn0ppYLRdqo?=
 =?us-ascii?Q?5BYHfGjJiuFKiDarkAe5HJnEamDy0YdAWeNp/3ridRjDlhN8DgTl4JyzI0i6?=
 =?us-ascii?Q?aoFGaF6YPcEXYUy+gTXOFmXLcDaCN1SrfIqdpVQc6Y0x3Besipt6sd3n4b/b?=
 =?us-ascii?Q?v1KgoOLnCv2tG8xW1AExGAYqz+qMI8ZYYDlj70dhgv65rQMWamX3T+uZIO1I?=
 =?us-ascii?Q?6k7fRxWy8B47vLvVo4o5Fncv4HvfR4UWMzbQZzY0cLiBsCC4GyR05ImfwN8l?=
 =?us-ascii?Q?jNo8MZj3GZk2zMEc4rhvMQ1rrshHNi1PbEzQ8n+0cvffAudxH+YYq5IWyanP?=
 =?us-ascii?Q?er9cOSqrSVaGkrsNW7mf6dR3NOOKgZnpjIh9X40oBt86uB/HrpeMh2Mnrp57?=
 =?us-ascii?Q?3xaWC1UAfdytO7fuXECo5Kvm0ARrwOPFSgHfMQqQHy2vN/22TJnouArS+gie?=
 =?us-ascii?Q?8y1bmk7kXrhPkkpS0dBkhOPhZn/f8vhoNrxyBKAj6CzA254nqUjQGFa9b8yU?=
 =?us-ascii?Q?enH35z2Zz0h1ROKvFcKRQFLcqrDRjXz78thS4zv7wsePuNmrSMZMZjOxqxbV?=
 =?us-ascii?Q?Nt97EfOALnNqJW5rUREagR6LDkHIhE7BnhF78aONoDw4tFhAXpmZLjMDFoFG?=
 =?us-ascii?Q?sAVCdOk27POx/D2UUIi/RzD9lGSjVkGSZvJTZfJ0FY2fftXoVdZa3VDPvrlN?=
 =?us-ascii?Q?///lungnb6OYdKuBwi0zk/wnldT1VVPcO5r2R3pAdalcu9hFYlpVOy0D4vwD?=
 =?us-ascii?Q?xqjyqzv879tR+3/LD7PoQ7kIDmwy4Vcr3mGVRzZTIx8MJNOGqH/7BDFRf/LX?=
 =?us-ascii?Q?6kgZ6FqKFmaJAMsTwzrU6tzuTkdpOWu8DlB2CtEByGzJwg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iPxpo1IA2YAWzj4C+X9NUyDQPR0UzFsuZpAojO/qketb7N3EV2FJskrEO+Nq?=
 =?us-ascii?Q?9HpWhmQLFsWYCRW+DR80IN7yfE7v8IHHDZJsNyzKV3POUh6dXTBgCjvVXwD0?=
 =?us-ascii?Q?1qPtenV85sKgGm2gH78asOJh41ppAI3N+p6VaLTAyw3FWANIrk2KLdrESfSC?=
 =?us-ascii?Q?84UndD1V/eDK72Gfpr/GnVRoxhGJD5n1KpXY3+rljvTAtiH9ID8s4luNnxpA?=
 =?us-ascii?Q?qwCNLGH2R1cZS3Zo3fP/R+GVfiebIWUjBcfGX516GjRPMeuPUlib9woz6gk6?=
 =?us-ascii?Q?HQHBggiWdAB3r+WTajYLulNwXSrS1DgnMtH3bQepfdno47IZONA0+BJfwJxx?=
 =?us-ascii?Q?c1NeyLjTksuYpBkvlqcBQssdx4FHg9fA/6lbK5Vyb3jjCFITERi2+EaBleP6?=
 =?us-ascii?Q?97m6I4H3E/H9p98GsQdgoQ/tq2Dy1oP49eWgfKwi7AtazJ160L2Gv3209M8L?=
 =?us-ascii?Q?PRBHSPtleJeVuospOKj6VcCJQyDN5uPSshErlwzlYVcfyb9j1ni3jxlW27i3?=
 =?us-ascii?Q?McKJWfHT5vX6ctyp1fbDFrD/Bza9EDmTQkNC+MWc0WfLUUxEwFU6VA69Pn7D?=
 =?us-ascii?Q?Km2TQ10MhILzzSZW3/he2VORWEqxfEwJsLrKCKSGSXG/W9XdCBfPNDYaVo2j?=
 =?us-ascii?Q?8aoWh/0YXV1cvHkIhUI9luXjuzLGPzsLy7XZ0RdJw/IygrVESbwjV5k5yt+d?=
 =?us-ascii?Q?lm2KP5EKNZnntxvGWRjD6m64fPpyElkC5mYdHBEiItJMs/qgnEY6DksPylMG?=
 =?us-ascii?Q?LLaiTRn+zEdW3ehxEEkHaQ2s6kyr/6GSmxLTF+gUNcQYBRG2YcCvRNU+bSkn?=
 =?us-ascii?Q?3MEhi7XBy5t5EgqHDsoxV+jPhwdQmKYVXamtk7TP1c9+IOr/CzfnzlLuhqc7?=
 =?us-ascii?Q?5J4eSx82UMZ48Vu4K6MADUELjlOqYicLvce89g7Y/QB2x4eeltvA43Bwnk7C?=
 =?us-ascii?Q?2xdkQVOVQhAzDMXLEYIcSLeWlM+LjIHbgeUfzG0Aog0sCMSaPdd97I8wHwfK?=
 =?us-ascii?Q?oolSlC9zkkWTnUUZKZ2x6Z2VMggMdkUov9jHllvm+6Am4KphomyfjErWzzBW?=
 =?us-ascii?Q?nlGeZB4xvw6/Pcy1irbQDcdr4MtXTUc49xugBAhcQJsTou1hBPxphH0kbhoa?=
 =?us-ascii?Q?BR6kD9gjhEW0/cMeXNs7MbyUi0xVTs3pyMN8eOqGLI6phiZu1N0lIfEx6ef6?=
 =?us-ascii?Q?MrvopZQy702XH9FuN+S3qj6d/X4qxwlqHkKCUC0YpsPkDVcehneDu7nElQEC?=
 =?us-ascii?Q?Uyf3dw76NLNZ3Xt0LxJSYzMMpY8TH2aGfqX6KTJyINVFt7g6sWnYXD0vF0Wn?=
 =?us-ascii?Q?yZMEf5r/N73Im3anJH0O9DMlrKVzbRJSuUM/6fYiu3llrW2PDT1yl8WnhUB9?=
 =?us-ascii?Q?BMoUbRhOWiRIr+CXJYlthp91k9KWWM8lIwTHbWsEACQAEZyfw5dmsa20kPhQ?=
 =?us-ascii?Q?ti6enZhxyDnMwAJT9Gw4c4qdDdRrUaETyhDPe+/6uwCTNDNte5MQoSBsyiZ+?=
 =?us-ascii?Q?ZNiHccvdNRiJst9qbtU+jPb9xBEZyQs9E2vmS0CknfuPczwMTc0lL+RTjvLY?=
 =?us-ascii?Q?eQyZd4Iejz2wPJ3eh3E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb7caf6-b426-4723-f004-08dc73f333eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 08:52:36.4950 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AfH+oUfoUbWjRab+wGlZOmSpYtcJRl03oZcN8qI1yjoH46TiyrWJ84RAWyp1yUL9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6154
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

From: Likun Gao <Likun.Gao@amd.com>

Enable GFXOFF for GC v12.0.0.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_0.c
index 045731caa624..6419f98e32b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3608,6 +3608,7 @@ static int gfx_v12_0_set_powergating_state(void *hand=
le,
                return 0;

        switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+       case IP_VERSION(12, 0, 0):
        case IP_VERSION(12, 0, 1):
                amdgpu_gfx_off_ctrl(adev, enable);
                break;
--
2.34.1

