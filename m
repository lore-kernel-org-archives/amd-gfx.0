Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E31C87FD1
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Aug 2025 06:13:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40E3E10E24A;
	Tue,  5 Aug 2025 06:13:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y8PZ/Np/";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE13910E24A
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Aug 2025 06:13:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x9qTkzr1W4FuzSmyDIIz/a3/lTE0RYELeAN7TbNm4uPnJqVN8NrCL2vJ5cuhHVM1PoxHTSWZC3j1ol6RGLj8uOX4mjCyCl1SPm4L+xz58NqtxMTgcNvIkmY+ygdXqPsPmt9Aso8X7C4tJgVdH/0FfhP3a64fUq2/JfY4gezign65FqtgluuH98/E3D1gyZgQTTRTwsvJ+RH7wENR4sw1US6qkYtEDli6mo+9cwoVX00aLz6vOxdmdhk2VY4mGpik/k5xyb6CZmxr8pDReVa1MWSja/Oh4ls/DpYwxsr2eA1sz/65ZPXoj6ubuR4Ztvsl3nWAlMWVwQcgwzS9SOaROw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6loAgbWbLr/YQXivH+P9LYU5fvegg9uRu4zKnZesndM=;
 b=BIT4GTM0fQ9Lc50sSXF/KCK2xVq7j7AxahIWQZjFUTGnKBl3cBIt7/EjYurLlTo0uL35fcbnqpfNMz4i611xhAuf5zeR01BU5hN6/l6K7A+cj3U4NspOp5NALlp/UZYunE36NkoT3Ix5a2wjeSIlYy7cf+sa7uE3YJ9qKul9LifPGCp+UpZaICTsTSR5hoqGaZJToibL3XMsEixdEGJv15DljDncGzZXfOAlSLRyrzp1LVxVtY+w2p/JM6FiMF9tMOma7uFLBC84w6WVF0rAI16NqeI7hydCCO/OYOFOs+cnXtBCBiLrHEnbtIWKF8Gp+7G7hIQom9Qu/+W0Gu4/vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6loAgbWbLr/YQXivH+P9LYU5fvegg9uRu4zKnZesndM=;
 b=y8PZ/Np/Jg+fvO6ggzF+yDmoDr7yZRgGXsRuih9cOhwOttEmZPUzImWlY3qKAyWrPNVs+hQUf7b3z8GQBYEAxoCExylM1kdlLKJnozNw20/L2dd0rYXjUot1v4GKoFHcCZR3fHAjSBWKy5OCl77S56LaJDNOUfJbTxwQxbWgnlM=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by MW4PR12MB6731.namprd12.prod.outlook.com (2603:10b6:303:1eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 06:13:35 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%7]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 06:13:35 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [v6 03/13] drm/amdgpu/mes12: implement detect and reset callback
Thread-Topic: [v6 03/13] drm/amdgpu/mes12: implement detect and reset callback
Thread-Index: AQHcBRuCTMBZFOLr00yHdSVWSAOjkbRSuHWAgADdE5A=
Date: Tue, 5 Aug 2025 06:13:35 +0000
Message-ID: <DM4PR12MB5152E493610D60F9E8369D98E322A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250804084029.863138-1-Jesse.Zhang@amd.com>
 <20250804084029.863138-3-Jesse.Zhang@amd.com>
 <CADnq5_NypwK4k34mRtoc4AkmTvrfEspGDdqBxsLrL1Z6fvkRUw@mail.gmail.com>
In-Reply-To: <CADnq5_NypwK4k34mRtoc4AkmTvrfEspGDdqBxsLrL1Z6fvkRUw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-05T06:12:08.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|MW4PR12MB6731:EE_
x-ms-office365-filtering-correlation-id: f5d13e93-b6e9-4195-873b-08ddd3e7360d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NzlHZHZRLzVoSHk4bmd5RXYxenVKUEgwbWRrdk9FVGQ4RnZKK0NYOFBaWFh5?=
 =?utf-8?B?SHh2MGY2S3FzWFVwSm9tczVuRWhHcnZETFB4RjJEblp5eFZyTkxCMTQwNSsz?=
 =?utf-8?B?RjlEMCtyL0liRjBMY21GSTBCb1dBdXZCaldLT1RnWXFlejk0UDJEaVZJMkE2?=
 =?utf-8?B?Z04zdk1ua1dMV0pqMmcxTmRLQjJ0bE5lb3NQdmUwaUNOaDhSdXZUVUtwc21K?=
 =?utf-8?B?M1gzckpReXhxU0x6TXpwYmlnclQrZnFCRTZ2VkRMS21VQWw3WUFibFk0NUMx?=
 =?utf-8?B?Q1RvZW14VkwvcGhUU0NSSXh0RUYwVEFyTlhZTlVtUGJYd1h3Uk5ISHBySjRB?=
 =?utf-8?B?Z3JGQ2QwQm1ZN1hyMTFacDE5eGNzUUdKNkpPOSsyckZQMEdXd2FZUU1BTW1O?=
 =?utf-8?B?Q0kwZ2hFYVR2emtsMDl1ZnZkbHlSTWlzbzY1YWd5MEhxbkl0WFU1NW5kM0Iy?=
 =?utf-8?B?SmNiWlF2SUdXSFhEMU5PTGJRc0RDTjI5ck1tR2lvN01RRktqS1Y5YUVGREpR?=
 =?utf-8?B?dHlWOHFkQTRpOUxVU3o3MkRaQXJBcGhFRjdjVFlLSXlhL1YwTE94SUZBRTM2?=
 =?utf-8?B?RWxjTnFBMzRtdHE3RFVnam1XQzZuVE5XM1MrWTlXOXo1bXVHOGp0ODhzb2Rh?=
 =?utf-8?B?VC9EMUhLYmVtNWZ6Z0Juald6RlMweW5UTTROK1k4Z1VJUHlSTldJdVRJWVV6?=
 =?utf-8?B?QjlUUVlRTVpLbDQvS2hQcFd1Q0NtN2NIdlhScDVvQ3U0NWxZdUhDT09XbzI2?=
 =?utf-8?B?a0NBekV4azlPUXM1eWV6SU5SczVySy9jYUxjQjFlVUdYVEhTUWkvaEUxN2wz?=
 =?utf-8?B?Vk5VSU81ZTNVQ3RSekRlQzllN1RFL3YyTHZ1dzRPSGhvT1hqdURoUmJ1VXZM?=
 =?utf-8?B?MEdYSDZwV05xaWs2NlUzOVhYY2tTZzEyU3dpdUN4eENPMHNNKzdsSnRMdXpK?=
 =?utf-8?B?RjhuR1hmTnR2V0RlT0lkRE1TMUc2YU1ia0xRZis4V0lvRm9DaUtNY0NWTExu?=
 =?utf-8?B?MlZFZzRrbmJoRHlURDZCWkd3SkhHVnQrbis0MFRnU0pmMmxuR0t5UEQzallC?=
 =?utf-8?B?bWE1dkFZSEw5N1N6ZVRSdTErdUxnc29mbTkxOHNXZUVlcWRzYXcyYW9IUkNY?=
 =?utf-8?B?L2Qra1Jzam9VS2JXT2phSmZXeEhzWlg3VVUvTEF6dEo0bTgxTnZzNkpPNjVN?=
 =?utf-8?B?UnUwQWFwYlRUMDRyQ2JTRVdHVUJhK0lSZkVTODhLV2dwelpXakRPSzlnMG1G?=
 =?utf-8?B?Z3JoWlN3aVk2WjdxQmU2NkIyOEVhWWFzYVd6dUhKT0hzdVI3VU5YSkNEOFNO?=
 =?utf-8?B?Q2E5LzUvK1Rabm1Eckg3ejZWcnJYQVNEVk82UUdTSjdvUGVYeVEyaW1iQjFw?=
 =?utf-8?B?RC8xQzFTZko1ek9reTU0UUYyaXN2UkdVc0tqUWtlVm5yWEpHRVZIaEdqbGl5?=
 =?utf-8?B?N3JTR3FSREdGV01sVFJ4Wk9wQnloL013N3U3bVozSWRLaGRYbVQyTGlJd3Vy?=
 =?utf-8?B?L25yUmlzRXhWakpxMHc5eVoxdTBpeExJcVo1bXBaQUUwc25qYmZBcjFQejJo?=
 =?utf-8?B?d2M5a3BDL0tIdW1wV1QyWDcxOEl4TlBqQXE3RVRXVVFKVVdCbGxGOWdlTEpi?=
 =?utf-8?B?djUrdVJPYU42QStUMU5zNmhXRlpLQTlLOHhuZHdzZXhjTlY4MEVJVzJOY1Vz?=
 =?utf-8?B?eGNLQkxIcjRteTNxYUFiQzVlT3FKTE9DRFRyYkVtOVZzaUdZem0xQjNlZ2NQ?=
 =?utf-8?B?K05rUEpTRUZIc1hGQ2M3WVhHd290Z1hVdW5XRlk2QmVCeStJNVVOVFAyWUY2?=
 =?utf-8?B?MU1zaVY5ZDgzZ1ZIZExWcXJkTkxpaStaY1Z2VU5nSjRYaFRSbHFSMTFIeVZx?=
 =?utf-8?B?S0Z6dnJjbTVtVGI4d2I5VjJpQy9td3RsNGR2cElMMmJ2TEFxbmZxUjRFaXMr?=
 =?utf-8?B?UWhBNVJSOFllVG14VkhwTlVXUCsrdkJjNjF4U3NYTENGZ1BaNnM2YzRyN2tL?=
 =?utf-8?B?NzVKbnFrbVNBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTZtT0ZUNk0wcGtIaXpqQ1ZSYkxKVTdGekxBekEzRkRkSDNtRUVtRTVzR1hM?=
 =?utf-8?B?QlBTNGtxb3VJTTNPVzB4TVNkR0wrQ2pHZEJzWXRrVXZENUJkM3ZuNXM1UkxZ?=
 =?utf-8?B?aUFmd2dBTDdBZGYwemx3aW1iMVNWaFFLeGpRVUV5ZHZ2bXh6MVhGVldtREZ4?=
 =?utf-8?B?WVUzOWdNV0Qxc09SOCtOY3BObWl0bWRLaDRNK0FBeDFTL0ZPcldSUmRUbjN4?=
 =?utf-8?B?dEZZOUcrd3pTS0VRQndyS21qeGdnaytaMytlODdWN1R0Q2VyNmU1UkZab3B0?=
 =?utf-8?B?S3oyTGxJTGFmaWZkcFc0LzhOVEZpOHp1MWJhYUh5WmhRUkNpdm9qRnNjbThC?=
 =?utf-8?B?TTdyTGwyY3cxOUE3SFkxSnZWVXJVYm1LZkJpU0tNM2lYNjVEeWlTUDZwbTNZ?=
 =?utf-8?B?RzhhT01yNkpMVHpiMGszaThMRVBTbnptbmFudWRlcnlRV0liOEIvSlA0ZEVG?=
 =?utf-8?B?UHlvR05HRG5tbHRTVlYyejRoNHBVRUZvTEI2YnNnNTRKUzNmNUNpQmpRYlQw?=
 =?utf-8?B?OE1pN050Z2pNc1kxbHA0dFlEWGVpbE1EYVJMMFh4VDFId3JYei9XcEREdEJ2?=
 =?utf-8?B?RFBaVFFIbStmamQvWWxVS2pidkVNVHFjVFFzNUUvMlFPTitJUEhlRUVXODRC?=
 =?utf-8?B?V1YwWVhXd3BWMzFxTzJZMzFQc05GTU5KUGpib1VvQXhzc29lMlRBdnJWYUhD?=
 =?utf-8?B?VHVHZVQxbHdPdzRUTFBOWTRCZHl6WFJMZ2VvajlRb3pCdWZna204QXcrM2Jm?=
 =?utf-8?B?V1dEQ0IwenNzWWNGWnVQaVkzN1N0NEtyR1Q0cmt5S25EZUdRZXBCUnVoMFFT?=
 =?utf-8?B?WWI5LzF6TVk1VlliVkE4cjRqczhlY3ZXWVhpOHQzMjRzd21wL002MW5sTFdm?=
 =?utf-8?B?VEVWeGpPR3FXTXFvWUxVR0RyN0dNaEpqeDN5SHU1Vkg5U05xSStLS2hqVjhH?=
 =?utf-8?B?c25oRnhHZmdUeFNFZ1JvMmp3ckowaHlEZVBHMnp6RkJGZ3IrcUNSWk1YZEs3?=
 =?utf-8?B?VjFmTS8vekl2Mm1yZTdiSXlramlPajlocWQ4S1pEOWM1UytjeCtmZXFQazRX?=
 =?utf-8?B?QjM3dzFXYlFPWkRtb0JtQ0gxb0syTHB5aEFLdG9mZzVsaVVZWlhTWjF5b2JZ?=
 =?utf-8?B?d1JMTmxwVDJlS0kvWUU2TFkyeUdZMFVtUEc5dVVIVWR5azdFdUU3NktrNU9Q?=
 =?utf-8?B?cHhKampmZTFEVnhqTEo0QS9VU1BEajB6Q3FXKzRRbnZvYTRiSys4ekx0dkN6?=
 =?utf-8?B?ajZjcUREckl5QWl5eFFlcjhMWEJSamtnVC96cHVtZndZVVBUNkwzU1VQdG5p?=
 =?utf-8?B?M0dmMkJpcENMcnVVcXZKV0laekJ5SWFaUlIrbWMyWG5KRS9DcHAwTUxSNHQ3?=
 =?utf-8?B?c0l5bVdlUTd0bkQ4OGpKOVlhY3NqdEEyOVZBUExnS3VvcjZXQ1d1aFhET1Fk?=
 =?utf-8?B?U2RDeTIyN3JMRzlSQlpreTNja3NKa3ZyNWFEQ2F1MnNJRkRjRnlSczdRY29K?=
 =?utf-8?B?NTZNa2Npc0xzbytvT1kwOVUvQ0lKL3g3cWNKclhwbmRPWTc3MDVaOWdibmp0?=
 =?utf-8?B?N0JoWE5oQUFKYXQ4VWFjQ052RWdncUlvOXhwVXU1YnlkRWswSE9RVE1mVWZo?=
 =?utf-8?B?NkhmanFteWlhSTMydElpam1vWldkRFZKZWdha0JkTFBtdVcrcDNqcWtTcDM0?=
 =?utf-8?B?NDlpTXZGL09SbWo5VkwrTTZMQ2tOYitkSkJ3NzMzY3RVbEYwMDQ3b3VUVWV5?=
 =?utf-8?B?cTlJZ3lHMFErdWsxa2M4OTF6OVMrdEZJUkpiYXVsU3FPSnVCNFFmMUtyWVN0?=
 =?utf-8?B?d3hVa1Y3N0lSVDBUdWVvc1hac0NzVUlwblVFczlGRnBRS3kvUlplTlRZWTJG?=
 =?utf-8?B?UjlnY2tQS29kVnVoam9qenRhaU45RHZTc0REWlhDMm82VE5HOHFUWmVoQzlv?=
 =?utf-8?B?cnMrKzRuMEJsVEhZQ1JHcmNYRzdSTk9iRGNXdHJ6M3BlNW1BMVh1M3orM1RV?=
 =?utf-8?B?dW96cnBTbHd1RlBJM1pzc1MrNlBLTEtnVVRsTjN2T0h2NTNsSkEyMnh5aUlY?=
 =?utf-8?B?dGR0elZvMGc3Z1FDdmNYQ2NxNWsvbnNzWEZDOFhwdjRGSE1PK3lYU2Zqd3pv?=
 =?utf-8?Q?sl/0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d13e93-b6e9-4195-873b-08ddd3e7360d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2025 06:13:35.3628 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wpfvz9m+nbI/J6jooNHgcADjd+eGuLfXe8D1IIizZmJhFsS6Nb9e50BG5jaVB67pOtu0Pe0eZIDHPtO3uMZn6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6731
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEFsZXggRGV1Y2hlciA8YWxleGRl
dWNoZXJAZ21haWwuY29tPg0KU2VudDogVHVlc2RheSwgQXVndXN0IDUsIDIwMjUgMTowMSBBTQ0K
VG86IFpoYW5nLCBKZXNzZShKaWUpIDxKZXNzZS5aaGFuZ0BhbWQuY29tPg0KQ2M6IGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVj
aGVyQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29t
Pg0KU3ViamVjdDogUmU6IFt2NiAwMy8xM10gZHJtL2FtZGdwdS9tZXMxMjogaW1wbGVtZW50IGRl
dGVjdCBhbmQgcmVzZXQgY2FsbGJhY2sNCg0KT24gTW9uLCBBdWcgNCwgMjAyNSBhdCA0OjUz4oCv
QU0gSmVzc2UuWmhhbmcgPEplc3NlLlpoYW5nQGFtZC5jb20+IHdyb3RlOg0KPg0KPiBGcm9tOiBB
bGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+DQo+IEltcGxlbWVudCBz
dXBwb3J0IGZvciB0aGUgaHVuZyBxdWV1ZSBkZXRlY3QgYW5kIHJlc2V0IGZ1bmN0aW9uYWxpdHku
DQo+DQo+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1k
LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdjEyXzAuYyB8
IDM3DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMzcg
aW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvbWVzX3YxMl8wLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdjEyXzAu
Yw0KPiBpbmRleCA2YjIyMjYzMGYzZmEuLjI5ZDM4YWExODk3ZSAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3YxMl8wLmMNCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvbWVzX3YxMl8wLmMNCj4gQEAgLTQ3LDYgKzQ3LDggQEAgc3RhdGljIGlu
dCBtZXNfdjEyXzBfa2lxX2h3X2Zpbmkoc3RydWN0DQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYpOw0K
Pg0KPiAgI2RlZmluZSBNRVNfRU9QX1NJWkUgICAyMDQ4DQo+DQo+ICsjZGVmaW5lIE1FUzEyX0hV
TkdfREJfT0ZGU0VUX0FSUkFZX1NJWkUgNA0KPiArDQo+ICBzdGF0aWMgdm9pZCBtZXNfdjEyXzBf
cmluZ19zZXRfd3B0cihzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpICB7DQo+ICAgICAgICAgc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSByaW5nLT5hZGV2OyBAQCAtODc5LDYgKzg4MSwzOCBA
QA0KPiBzdGF0aWMgaW50IG1lc192MTJfMF9yZXNldF9od19xdWV1ZShzdHJ1Y3QgYW1kZ3B1X21l
cyAqbWVzLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBvZmZzZXRvZih1bmlvbiBNRVNBUElf
X1JFU0VULCBhcGlfc3RhdHVzKSk7ICB9DQo+DQo+ICtzdGF0aWMgaW50IG1lc192MTJfMF9kZXRl
Y3RfYW5kX3Jlc2V0X2h1bmdfcXVldWVzKHN0cnVjdCBhbWRncHVfbWVzICptZXMsDQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0DQo+ICtt
ZXNfZGV0ZWN0X2FuZF9yZXNldF9xdWV1ZV9pbnB1dCAqaW5wdXQpIHsNCj4gKyAgICAgICB1bmlv
biBNRVNBUElfX1JFU0VUIG1lc19yZXNldF9xdWV1ZV9wa3Q7DQo+ICsgICAgICAgaW50IHBpcGU7
DQo+ICsNCj4gKyAgICAgICBtZW1zZXQoJm1lc19yZXNldF9xdWV1ZV9wa3QsIDAsIHNpemVvZiht
ZXNfcmVzZXRfcXVldWVfcGt0KSk7DQo+ICsNCj4gKyAgICAgICBtZXNfcmVzZXRfcXVldWVfcGt0
LmhlYWRlci50eXBlID0gTUVTX0FQSV9UWVBFX1NDSEVEVUxFUjsNCj4gKyAgICAgICBtZXNfcmVz
ZXRfcXVldWVfcGt0LmhlYWRlci5vcGNvZGUgPSBNRVNfU0NIX0FQSV9SRVNFVDsNCj4gKyAgICAg
ICBtZXNfcmVzZXRfcXVldWVfcGt0LmhlYWRlci5kd3NpemUgPSBBUElfRlJBTUVfU0laRV9JTl9E
V09SRFM7DQo+ICsNCj4gKyAgICAgICBtZXNfcmVzZXRfcXVldWVfcGt0LnF1ZXVlX3R5cGUgPQ0K
PiArICAgICAgICAgICAgICAgY29udmVydF90b19tZXNfcXVldWVfdHlwZShpbnB1dC0+cXVldWVf
dHlwZSk7DQo+ICsgICAgICAgbWVzX3Jlc2V0X3F1ZXVlX3BrdC5kb29yYmVsbF9vZmZzZXRfYWRk
ciA9DQo+ICsgICAgICAgICAgICAgICBtZXMtPmh1bmdfcXVldWVfZGJfYXJyYXlfZ3B1X2FkZHI7
DQo+ICsNCj4gKyAgICAgICBpZiAoaW5wdXQtPmRldGVjdF9vbmx5KQ0KPiArICAgICAgICAgICAg
ICAgbWVzX3Jlc2V0X3F1ZXVlX3BrdC5oYW5nX2RldGVjdF9vbmx5ID0gMTsNCj4gKyAgICAgICBl
bHNlDQo+ICsgICAgICAgICAgICAgICBtZXNfcmVzZXRfcXVldWVfcGt0LmhhbmdfZGV0ZWN0X3Ro
ZW5fcmVzZXQgPSAxOw0KPiArDQo+ICsgICAgICAgaWYgKG1lcy0+YWRldi0+ZW5hYmxlX3VuaV9t
ZXMpDQo+ICsgICAgICAgICAgICAgICBwaXBlID0gQU1ER1BVX01FU19LSVFfUElQRTsNCj4gKyAg
ICAgICBlbHNlDQo+ICsgICAgICAgICAgICAgICBwaXBlID0gQU1ER1BVX01FU19TQ0hFRF9QSVBF
Ow0KDQpJIHRoaW5rIHRoaXMgc2hvdWxkIHByb2JhYmx5IGFsd2F5cyBiZSBBTURHUFVfTUVTX1ND
SEVEX1BJUEUuICBTZXR0aW5nIHRoaXMgbWF5IGZpeCB0aGUgaXNzdWVzIHlvdSB3ZXJlIHNlZWlu
ZyBvbiBnZngxMi4NCg0KDQpUaGFua3MgQWxleC4gIFdpdGggdGhpcyBjaGFuZ2UsIGl0IGZpeGVk
IHRoZSBpc3N1ZXMgd2l0aCB0aGUgR0ZYMTIgY29tcHV0ZSBxdWV1ZS4NCg0KVGhhbmtzDQpKZXNz
ZQ0KDQpBbGV4DQoNCj4gKw0KPiArICAgICAgIHJldHVybiBtZXNfdjEyXzBfc3VibWl0X3BrdF9h
bmRfcG9sbF9jb21wbGV0aW9uKG1lcywgcGlwZSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
Jm1lc19yZXNldF9xdWV1ZV9wa3QsIHNpemVvZihtZXNfcmVzZXRfcXVldWVfcGt0KSwNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgb2Zmc2V0b2YodW5pb24gTUVTQVBJX19SRVNFVCwgYXBpX3N0
YXR1cykpOyB9DQo+ICsNCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X21lc19mdW5jcyBt
ZXNfdjEyXzBfZnVuY3MgPSB7DQo+ICAgICAgICAgLmFkZF9od19xdWV1ZSA9IG1lc192MTJfMF9h
ZGRfaHdfcXVldWUsDQo+ICAgICAgICAgLnJlbW92ZV9od19xdWV1ZSA9IG1lc192MTJfMF9yZW1v
dmVfaHdfcXVldWUsIEBAIC04ODgsNiArOTIyLDcNCj4gQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBh
bWRncHVfbWVzX2Z1bmNzIG1lc192MTJfMF9mdW5jcyA9IHsNCj4gICAgICAgICAucmVzdW1lX2dh
bmcgPSBtZXNfdjEyXzBfcmVzdW1lX2dhbmcsDQo+ICAgICAgICAgLm1pc2Nfb3AgPSBtZXNfdjEy
XzBfbWlzY19vcCwNCj4gICAgICAgICAucmVzZXRfaHdfcXVldWUgPSBtZXNfdjEyXzBfcmVzZXRf
aHdfcXVldWUsDQo+ICsgICAgICAgLmRldGVjdF9hbmRfcmVzZXRfaHVuZ19xdWV1ZXMgPQ0KPiAr
IG1lc192MTJfMF9kZXRlY3RfYW5kX3Jlc2V0X2h1bmdfcXVldWVzLA0KPiAgfTsNCj4NCj4gIHN0
YXRpYyBpbnQgbWVzX3YxMl8wX2FsbG9jYXRlX3Vjb2RlX2J1ZmZlcihzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZQ0KPiAqYWRldiwgQEAgLTE3OTMsNiArMTgyOCw4IEBAIHN0YXRpYyBpbnQgbWVzX3YxMl8w
X2Vhcmx5X2luaXQoc3RydWN0IGFtZGdwdV9pcF9ibG9jayAqaXBfYmxvY2spDQo+ICAgICAgICAg
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBpcF9ibG9jay0+YWRldjsNCj4gICAgICAgICBp
bnQgcGlwZSwgcjsNCj4NCj4gKyAgICAgICBhZGV2LT5tZXMuaHVuZ19xdWV1ZV9kYl9hcnJheV9z
aXplID0NCj4gKyAgICAgICAgICAgICAgIE1FUzEyX0hVTkdfREJfT0ZGU0VUX0FSUkFZX1NJWkU7
DQo+ICAgICAgICAgZm9yIChwaXBlID0gMDsgcGlwZSA8IEFNREdQVV9NQVhfTUVTX1BJUEVTOyBw
aXBlKyspIHsNCj4gICAgICAgICAgICAgICAgIHIgPSBhbWRncHVfbWVzX2luaXRfbWljcm9jb2Rl
KGFkZXYsIHBpcGUpOw0KPiAgICAgICAgICAgICAgICAgaWYgKHIpDQo+IC0tDQo+IDIuNDkuMA0K
Pg0K
