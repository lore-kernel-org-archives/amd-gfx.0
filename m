Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798FFC021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 13:53:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2935F10EA76;
	Fri, 21 Feb 2025 13:53:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ch54yy20";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DF9110EA75
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 13:53:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jmd0r/bd1FXAb+upvIyZ02khed69XwGuFG9Oy7q3OlwtErNJdTAhRmpnmQPE/JbWT9JKPc7/iytWGsv+ZVwZjEtVcDPVkg5052YXZ6EmHsCxbPch3XTJBqsDEPVKScYo0Bw5FYj8OktrfpKVPbUbxWCbkevIXe8efwiPY7GDjxgYY0PL4Y7O+CaQFUUIBxFoVl1FwlycoSjJvLTJUlLsa3Xlad7FUSqu9OvA3+9P7oj77TIgmJNJjy1ykwDgAW0oNHfi8NENo5aO4W3kCiHBvqEwh2VXBTAmXWcQOqus1AfEebXc6OwZIHiJ6nA7YU5sHRzGXiEGFdUIv/ahAnuYTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQHW8K5TKfOupnOd66cNyv6snaEL72G0DOTL+Dp+0pg=;
 b=Bj8jgaYs3tzfh/zxBktMBVJkUxGFDQEcjZo5aHZmW3FZfq1g+r0j2A3+evrMqGGfg+PO78U1wW0VQAf1tTHckiHz8GKTIIZgW5QvZoHV7n9UreFLuDAf4KH7XkSc7ZvnPQJKi09ei4fBCh6lsBetbWDSDpVZGbkHylLIbykQ69c2oXyeazQgF2MQ7BiPgAVBqfUUmwtRd+AGF/E2LqcR6G7gpFeHiuuG6j4p8+0XYlhnwZkLLTuHbmXQzM89K4SbeK1RjsOMPipfK792hT7aZ+f2+Ks2l8fMwoh0UWTjwIRGgEV9Bl9MLVs8VYrHrtgLtj3DIQNMoqbBVpM0B/b6FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQHW8K5TKfOupnOd66cNyv6snaEL72G0DOTL+Dp+0pg=;
 b=Ch54yy20TCac4ikiOIuggMxvqbu8GhBuzBIn+Ja6pEPnqZPk2V4jrbFbl+aGrMYRjVmyOkqe+b3CNU9/O8xvjvqKvJQLmaZkLOk7pyCvcRIG975bjEDFFkKxkpguj3jMxpdNuH2MGThj1zpTNjg1+q21ELNiZ4E0ryhQRws7Eao=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 SJ2PR12MB8182.namprd12.prod.outlook.com (2603:10b6:a03:4fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 13:52:57 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563%4]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 13:52:57 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Sundararaju, Sathishkumar" <Sathishkumar.Sundararaju@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdgpu: Add ring reset callback for JPEG5_0_1
Thread-Topic: [PATCH 3/3] drm/amdgpu: Add ring reset callback for JPEG5_0_1
Thread-Index: AQHbg8aTZCMBMAZp20qA+3O81CbE1rNRx6rA
Date: Fri, 21 Feb 2025 13:52:57 +0000
Message-ID: <DM8PR12MB539913F7733156DABC4538D7E5C72@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20250220183653.3000793-1-sathishkumar.sundararaju@amd.com>
 <20250220183653.3000793-3-sathishkumar.sundararaju@amd.com>
In-Reply-To: <20250220183653.3000793-3-sathishkumar.sundararaju@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=e8653991-d623-4dd2-a41e-cdfcdb96463c;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-21T13:50:46Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5399:EE_|SJ2PR12MB8182:EE_
x-ms-office365-filtering-correlation-id: 04d2c7a9-d32d-4310-f53f-08dd527f0c32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?V1ZTc0VPZERpdkVyeUkxMTBnMml2dS9hWmRHNStoVmlVd1AwYUJWTmNzL1Jl?=
 =?utf-8?B?Q1IxbGlSUUVNNVl4ZEZDS0tqTnhUc3dVeTFnMXVENGszb0xOY0t2Y0hmTUhu?=
 =?utf-8?B?UHRDZ3ZESkxEWmpBN2tGQWtYaC9Ddk1tSU1pWFpEaFVXN0ptYWVubEltd3Ar?=
 =?utf-8?B?aUQrTzBmTDJmbnNmWE93VURhNjhnUWgxbCsyLy84bHgwbVNMMXJjZWc0TzF5?=
 =?utf-8?B?T0diN2dzWG43eUxzNTNPR2ZTdjhhYTFVNTVLL0RkeitwRmpvUEVOcTEvaDFT?=
 =?utf-8?B?bjNPNUcxOTRrZzM2ZzZDNmlpVEVBOTg3ekJJWDBMRDVyNVpDSlMrbTFXWEFO?=
 =?utf-8?B?S0pkZWZZOFhEM2Qxd1dESFlDVWI1RnJETjF0ZVlEUVVnTzNyWGo0Um52Vkk2?=
 =?utf-8?B?SXI4bmJIeHBJZGVQdUNveEpmZHI0c1NDTWxFVkp0K24xNDE1ZWQ4YlRmMmFm?=
 =?utf-8?B?YkhwVDJQdUdKSjFTZlArYXdkOUtPMk1nUmR5OHltMzd0bFFQZVp5bGk3bGxY?=
 =?utf-8?B?MWVzQnFreW52d21lajR0UE83cjliRG5sTVJ4VDlQU3psa3c1V3Z3VVZiT2xM?=
 =?utf-8?B?N2JrZkNFQ1JUV2lUamo2WmQvRFV1em94VmxqWjd1T0oxRXhpTUpPODJQM21q?=
 =?utf-8?B?QlNYRWpKNmlMaXlSMjhwNXVmVkhQcEhtbTZBVVppZzZNSjA3UklnTlVGSFZ6?=
 =?utf-8?B?RVpIWFNOV0ZLUURUU21OeEpvaDF2VVRmWGVReWJ4RW9wMUV3VU1oSWVPSktm?=
 =?utf-8?B?QXY3VSt1SXpKaGRMZjZJZHhFZWFBN3pyV09VcmlVdUF5MGgvb3JJdEdObWta?=
 =?utf-8?B?NTZNVXNTVmtOS2VheUJXV3lkMTZPN3VGWEhVR2wvUGtzcUk4RmlpSFkrdUox?=
 =?utf-8?B?WUR0cW9COGRoZVV5bEdVcUJ6ZE9IKytDSFFkTFYzVjQ3aDVOeVNMUjFlQXpp?=
 =?utf-8?B?MWlVVi96RkRkSW1aOXlnQS9panBucHFJVG1tMGdMWHhxU052cllybUdiK3JF?=
 =?utf-8?B?QTRuR2xvYUMzYkNzeG5vckpSSVlWZ2RIczlHZmtncUxmWUhvb052dC9EcGpv?=
 =?utf-8?B?MW1uODZESzhZR3dCV1VnMzFRamJTbm9QK005U2pCMWplSStSaXo1QU11Vkxa?=
 =?utf-8?B?ZWEyNzhSemlEcVNMNThUS01TV0VuOXUzTGpXVGt0c1dtUzJXbURQKzQ3ZzlI?=
 =?utf-8?B?Yk5jd3FTYTNMQ1kybTk2Z2syMVJDelJ4Yk51ZDVEbEhPc2NDd0lpU1FYTEZ2?=
 =?utf-8?B?TUFIOTF6VStPck81VkpoRDlON3R1L2sxQ3B1MHY1V0lIL1dnSmhaL2I2bUVz?=
 =?utf-8?B?ZHl4V3RxU0tlQjBmbDU0R0l6SGlzZ0lYdFdjVitUR3ZueE42T09ySWE5SmNN?=
 =?utf-8?B?YnRJRUZMWjVkRWZvRzl5THBJdCtBbmIybThQNTdCM1ZyK3lzRThhOHAwTEtR?=
 =?utf-8?B?Rmw4VWI2Rm1heHlweVdkdUNxbkUxOEN3M2JTSDRycEFPd3JWZHVmeFNhQWlm?=
 =?utf-8?B?VGFxVHl3MS9Bc1dzZVo3alp0ZU5mNFVwdmdWMlIxcitRelc4NXI2MTljWlhZ?=
 =?utf-8?B?ZkpDaENjZFJkWm9GZzFpYlJLUEsxa2gwMFlSSFdIS255ZWN4TitVdVFRUjRX?=
 =?utf-8?B?d0V0RWUzditDSTByTmIzemRtYmRMYVRxVXNqc2FtMlMrNTg3YmV6aFY5M2JQ?=
 =?utf-8?B?cWZQSGxNK1lidFM3TzdHVG9uek53Qmo4K2gyL1BCSmYva3ZGd2gwQTZ1MXhO?=
 =?utf-8?B?KzYrNlJ2WlkvTGN2QlZtRmw5RUttNmp6OHF3eXl3bXJLRC8rdkFHM29qaFl3?=
 =?utf-8?B?OXFCR0R4U3VjVThzQWlKY2lqRW9JTHdGUFk0dWZqR3FoZUdzT0p6MUZvU0Er?=
 =?utf-8?B?dWdrTmR0b3dmRG9FQ1NzT2lSSFArZTZsTHh5Nk52TnlWbTdJbnRmREFHU010?=
 =?utf-8?Q?8I2EzDMnzclJs0DEcrdTKIWZwm432US5?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGZWZGlFTTBteEEvSTNhcUtqQmxGamVObzU2VDFPR0xiRmhxQUF4ZS9yajFQ?=
 =?utf-8?B?Q1pNOE5xSGxsZlZQaGxvaUxnbFYxbGZMR0VUem8rTEpBbTEyWUFJeEhPR1Zq?=
 =?utf-8?B?a3dGL25jRFpqU0pvWDNzNTBnTWtWNHNibXpJWjByUE1xd3VTU0tSMUtFQXlz?=
 =?utf-8?B?M3dNTzdMdENrT1MwczRvQWRPUUM2bnFaSGllZlVtQTVrR0U2SEdhYmtlTFhv?=
 =?utf-8?B?Qk9ycDlZZnNGOTdQRGVSYklKVU9vVXdtK1l4YnhuVG5qdlY1aFYzN1JIODBT?=
 =?utf-8?B?QXZqRFYrUTI1dzVMNnZYaGtLellZaUx4b013QWI1Z1ZnZGYxZVllekhyU2hu?=
 =?utf-8?B?SVZkcUkvU1RNVFNPZ0tybWlMYktSQWpaMnNMWTUvS2lGV3VmVkFSdzlLTVBG?=
 =?utf-8?B?Q09PUmcwQ05ITlNxTy93K25yOHJEQldLSHh0dktycHBWZldjL2MrWHhIcjBn?=
 =?utf-8?B?OVA2dWd0eFF0OEpEa3BweTBGMWRiYnpjd283RjVGbVhUVjJXaXNqRHZCbjdR?=
 =?utf-8?B?K29lOEVod0tXZmF2Rlluc1BIRjU0RUtoU0pwd25jL2ZUSkZEako1cUVLaXRT?=
 =?utf-8?B?cXUyMm90S082NmtYdnlJU1BqV2t0QXNxMXlKMWVhQUd4cUZJUEdhTDI2cjli?=
 =?utf-8?B?Vk8wSVUwUWQwdGc5aXExTmNmbWFSb0RvQ2xBdWlKRjNvdDVPNGJqTkZjZS8v?=
 =?utf-8?B?bmo2RXYzd3pVaG1leVdKaGtEK2RIQldwSGdyWDliRkJFaFlHK0tSUWFrZjFv?=
 =?utf-8?B?Q1RHMlRYdUpHb29YUUdGcEZZTkFsYXJZSExUa2NjY0Y3ZXJLTXhUakNaSUpH?=
 =?utf-8?B?dDdlTGRLcnY1WlBRbUxMa2ZxYi8xOFZBLzlpVi9BRm95c3A5R3JMN1R2TVBO?=
 =?utf-8?B?Z2lXVzZIbGNhclVkaHJUUTl0TG8vUU15dXA4T3Q5QWxERERUcGpEcVhQajlL?=
 =?utf-8?B?QnFsc0RKY1lJVUxqNzlYa055T2hRcHpGTU5BUDRqMGo4M2ZlbXE5aXlhS0pG?=
 =?utf-8?B?WDZLUXZKUWFRVXNoSFpiaUozM25UVXE5cFRUb0V2QU0rRW9peFE3SVN6bE9U?=
 =?utf-8?B?YjRWRzZuQytKN0pNZThOcHF0ZmxoNmdPbXd5MlYxSlY3ZFUyZ3lSUzJPb0Ev?=
 =?utf-8?B?T1RmS2twZytPODB3SklmaFhOU1RDejNnSnh0SkJKcHlRem9heXIvVEY2Zmph?=
 =?utf-8?B?Zy9GdHVIekFQN3hsTWowVE5Ob25LaDAwOUJ5ZVgrZ3VFcmFUZVFJNVdOWmV1?=
 =?utf-8?B?TkQ0ZmpFUm03cmdpUlQ0NXp1dHdwaVU2Ym5sTW5tNEY4RndLL2s4WlB4TDZh?=
 =?utf-8?B?MVF3SiswTmR3SW5FbWNEK1NVRmlmRHlFa0p0SFdqV2NaLzlTUzVjZkpKSXhH?=
 =?utf-8?B?emFUNTh5TGZoTStrSituYXdXQ1BMc0RTUDBsN1RPWTRYM1E4dUtVamNReXlW?=
 =?utf-8?B?RmhvcURwMjlyS0dXN3ZDMkJxcFRmTElhT0FsVGx0UEk5c0R0NTF6MEdpcEJ2?=
 =?utf-8?B?NmhFSm10L3EzVi9BOFpQNTl5UUQ5MEg0WmY3TFhUYThjeGc0YjBWNC92Q2pj?=
 =?utf-8?B?YVJFZ0VJZW01N1ptbU5Id3JRYzdvc1FnOG1YL3M0bThUK0RwdWMybGNGRG81?=
 =?utf-8?B?QmQ0UC9xUStlR0tzekhmRThCeTlRUmJ0QnVQcDYvRUQvYUhTZUk1V0xZTmZV?=
 =?utf-8?B?TkNPbktEZTVUYnAxV2dnN2I5aUM1Y2UwTVlvY2F0MEtVTHJrQlE1NkhaRjFX?=
 =?utf-8?B?a3Q1RUlka3FOMndDdkttT2ZrdFRKbHk5R2tFYldQRW4xenFjTWJLeHRGZ1dk?=
 =?utf-8?B?WE81ektQM3FKaGttSS9sVG5CN29WTHZFQnQ1V21EV21TWTNXTGRXSWFuN0hO?=
 =?utf-8?B?SGx5b3llNXNQb1ErbDc5bVNvUUtlU1dYNm9wT1FoYmdtM2d4QmdtRFV5ZlVE?=
 =?utf-8?B?bzFraU11S3IvdjczcWVWT0VSbWJtVkFrMzJvNEJLNmE5Q1NyeVpQL3ZnZElY?=
 =?utf-8?B?N2tlcWd4S2JtYWRQWU1vZjgxOVhuVlVXeXpJeG5SOWhFS0ZBU0RtaGhzTXpX?=
 =?utf-8?B?VE84OHFCQUR6bFpQTHVVUmFkdWVrdXV5aU4yREpiNEdmY3VQNkxkWGxHWHhy?=
 =?utf-8?Q?6mzQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d2c7a9-d32d-4310-f53f-08dd527f0c32
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 13:52:57.5003 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aBdM4uqzx3M1ohdaryj8W42rA85OcaJ1CTDg2TYaLQHgfbRuSNmUWN57OVsESfyW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8182
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
Cg0KVGhlIHNlcmllcyBpczoNClJldmlld2VkLWJ5OiBMZW8gTGl1IDxsZW8ubGl1QGFtZC5jb20+
DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3VuZGFyYXJhanUsIFNh
dGhpc2hrdW1hciA8U2F0aGlzaGt1bWFyLlN1bmRhcmFyYWp1QGFtZC5jb20+DQo+IFNlbnQ6IEZl
YnJ1YXJ5IDIwLCAyMDI1IDE6MzcgUE0NCj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnDQo+IENjOiBMaXUsIExlbyA8TGVvLkxpdUBhbWQuY29tPjsgU3VuZGFyYXJhanUsIFNhdGhp
c2hrdW1hcg0KPiA8U2F0aGlzaGt1bWFyLlN1bmRhcmFyYWp1QGFtZC5jb20+DQo+IFN1YmplY3Q6
IFtQQVRDSCAzLzNdIGRybS9hbWRncHU6IEFkZCByaW5nIHJlc2V0IGNhbGxiYWNrIGZvciBKUEVH
NV8wXzENCj4NCj4gQWRkIHJpbmcgcmVzZXQgZnVuY3Rpb24gY2FsbGJhY2sgZm9yIEpQRUc1XzBf
MSB0bw0KPiByZWNvdmVyIGZyb20gam9iIHRpbWVvdXRzIHdpdGhvdXQgYSBmdWxsIGdwdSByZXNl
dC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogU2F0aGlzaGt1bWFyIFMgPHNhdGhpc2hrdW1hci5zdW5k
YXJhcmFqdUBhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2pw
ZWdfdjVfMF8xLmMgfCA1MA0KPiArKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBj
aGFuZ2VkLCA1MCBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9qcGVnX3Y1XzBfMS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvanBlZ192NV8wXzEuYw0KPiBpbmRleCAwNzQ4MWNlYTU1YzIuLmIzMmVlZTVhYjNmNyAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvanBlZ192NV8wXzEuYw0KPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9qcGVnX3Y1XzBfMS5jDQo+IEBAIC0xOTAs
NiArMTkwLDEzIEBAIHN0YXRpYyBpbnQganBlZ192NV8wXzFfc3dfaW5pdChzdHJ1Y3QNCj4gYW1k
Z3B1X2lwX2Jsb2NrICppcF9ibG9jaykNCj4gICAgICAgaWYgKHIpDQo+ICAgICAgICAgICAgICAg
cmV0dXJuIHI7DQo+DQo+ICsgICAgIGlmICghYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKSB7DQo+ICsg
ICAgICAgICAgICAgYWRldi0+anBlZy5zdXBwb3J0ZWRfcmVzZXQgPQ0KPiBBTURHUFVfUkVTRVRf
VFlQRV9QRVJfUVVFVUU7DQo+ICsgICAgICAgICAgICAgciA9IGFtZGdwdV9qcGVnX3N5c2ZzX3Jl
c2V0X21hc2tfaW5pdChhZGV2KTsNCj4gKyAgICAgICAgICAgICBpZiAocikNCj4gKyAgICAgICAg
ICAgICAgICAgICAgIHJldHVybiByOw0KPiArICAgICB9DQo+ICsNCj4gICAgICAgcmV0dXJuIDA7
DQo+ICB9DQo+DQo+IEBAIC0yMDksNiArMjE2LDkgQEAgc3RhdGljIGludCBqcGVnX3Y1XzBfMV9z
d19maW5pKHN0cnVjdA0KPiBhbWRncHVfaXBfYmxvY2sgKmlwX2Jsb2NrKQ0KPiAgICAgICBpZiAo
cikNCj4gICAgICAgICAgICAgICByZXR1cm4gcjsNCj4NCj4gKyAgICAgaWYgKCFhbWRncHVfc3Jp
b3ZfdmYoYWRldikpDQo+ICsgICAgICAgICAgICAgYW1kZ3B1X2pwZWdfc3lzZnNfcmVzZXRfbWFz
a19maW5pKGFkZXYpOw0KPiArDQo+ICAgICAgIHIgPSBhbWRncHVfanBlZ19zd19maW5pKGFkZXYp
Ow0KPg0KPiAgICAgICByZXR1cm4gcjsNCj4gQEAgLTY1MCw2ICs2NjAsNDUgQEAgc3RhdGljIGlu
dCBqcGVnX3Y1XzBfMV9wcm9jZXNzX2ludGVycnVwdChzdHJ1Y3QNCj4gYW1kZ3B1X2RldmljZSAq
YWRldiwNCj4gICAgICAgcmV0dXJuIDA7DQo+ICB9DQo+DQo+ICtzdGF0aWMgdm9pZCBqcGVnX3Y1
XzBfMV9jb3JlX3N0YWxsX3Jlc2V0KHN0cnVjdCBhbWRncHVfcmluZyAqcmluZykNCj4gK3sNCj4g
KyAgICAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSByaW5nLT5hZGV2Ow0KPiArICAgICBp
bnQganBlZ19pbnN0ID0gR0VUX0lOU1QoSlBFRywgcmluZy0+bWUpOw0KPiArICAgICBpbnQgcmVn
X29mZnNldCA9IHJpbmctPnBpcGUgPyBqcGVnX3Y1XzBfMV9jb3JlX3JlZ19vZmZzZXQocmluZy0+
cGlwZSkNCj4gOiAwOw0KPiArDQo+ICsgICAgIFdSRUczMl9TT0MxNV9PRkZTRVQoSlBFRywganBl
Z19pbnN0LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgIHJlZ1VWRF9KTUkwX1VWRF9KTUlf
Q0xJRU5UX1NUQUxMLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgIHJlZ19vZmZzZXQsIDB4
MUYpOw0KPiArICAgICBTT0MxNV9XQUlUX09OX1JSRUcoSlBFRywganBlZ19pbnN0LA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgcmVnVVZEX0pNSTBfVVZEX0pNSV9DTElFTlRfQ0xFQU5fU1RB
VFVTLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgMHgxRiwgMHgxRik7DQo+ICsgICAgIFdS
RUczMl9TT0MxNV9PRkZTRVQoSlBFRywganBlZ19pbnN0LA0KPiArICAgICAgICAgICAgICAgICAg
ICAgICAgIHJlZ1VWRF9KTUkwX0pQRUdfTE1JX0RST1AsDQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgcmVnX29mZnNldCwgMHgxRik7DQo+ICsgICAgIFdSRUczMl9TT0MxNV9PRkZTRVQoSlBF
RywganBlZ19pbnN0LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgIHJlZ0pQRUdfQ09SRV9S
U1RfQ1RSTCwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICByZWdfb2Zmc2V0LCAxIDw8IHJp
bmctPnBpcGUpOw0KPiArICAgICBXUkVHMzJfU09DMTVfT0ZGU0VUKEpQRUcsIGpwZWdfaW5zdCwN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICByZWdVVkRfSk1JMF9VVkRfSk1JX0NMSUVOVF9T
VEFMTCwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICByZWdfb2Zmc2V0LCAweDAwKTsNCj4g
KyAgICAgV1JFRzMyX1NPQzE1X09GRlNFVChKUEVHLCBqcGVnX2luc3QsDQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgcmVnVVZEX0pNSTBfSlBFR19MTUlfRFJPUCwNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICByZWdfb2Zmc2V0LCAweDAwKTsNCj4gKyAgICAgV1JFRzMyX1NPQzE1X09G
RlNFVChKUEVHLCBqcGVnX2luc3QsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgcmVnSlBF
R19DT1JFX1JTVF9DVFJMLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgIHJlZ19vZmZzZXQs
IDB4MDApOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50IGpwZWdfdjVfMF8xX3JpbmdfcmVzZXQo
c3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLCB1bnNpZ25lZCBpbnQNCj4gdm1pZCkNCj4gK3sNCj4g
KyAgICAgaWYgKGFtZGdwdV9zcmlvdl92ZihyaW5nLT5hZGV2KSkNCj4gKyAgICAgICAgICAgICBy
ZXR1cm4gLUVPUE5PVFNVUFA7DQo+ICsNCj4gKyAgICAganBlZ192NV8wXzFfY29yZV9zdGFsbF9y
ZXNldChyaW5nKTsNCj4gKyAgICAganBlZ192NV8wXzFfaW5pdF9qcmJjKHJpbmcpOw0KPiArICAg
ICByZXR1cm4gYW1kZ3B1X3JpbmdfdGVzdF9oZWxwZXIocmluZyk7DQo+ICt9DQo+ICsNCj4gIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgYW1kX2lwX2Z1bmNzIGpwZWdfdjVfMF8xX2lwX2Z1bmNzID0gew0K
PiAgICAgICAubmFtZSA9ICJqcGVnX3Y1XzBfMSIsDQo+ICAgICAgIC5lYXJseV9pbml0ID0ganBl
Z192NV8wXzFfZWFybHlfaW5pdCwNCj4gQEAgLTY5OSw2ICs3NDgsNyBAQCBzdGF0aWMgY29uc3Qg
c3RydWN0IGFtZGdwdV9yaW5nX2Z1bmNzDQo+IGpwZWdfdjVfMF8xX2RlY19yaW5nX3ZtX2Z1bmNz
ID0gew0KPiAgICAgICAuZW1pdF93cmVnID0ganBlZ192NF8wXzNfZGVjX3JpbmdfZW1pdF93cmVn
LA0KPiAgICAgICAuZW1pdF9yZWdfd2FpdCA9IGpwZWdfdjRfMF8zX2RlY19yaW5nX2VtaXRfcmVn
X3dhaXQsDQo+ICAgICAgIC5lbWl0X3JlZ193cml0ZV9yZWdfd2FpdCA9DQo+IGFtZGdwdV9yaW5n
X2VtaXRfcmVnX3dyaXRlX3JlZ193YWl0X2hlbHBlciwNCj4gKyAgICAgLnJlc2V0ID0ganBlZ192
NV8wXzFfcmluZ19yZXNldCwNCj4gIH07DQo+DQo+ICBzdGF0aWMgdm9pZCBqcGVnX3Y1XzBfMV9z
ZXRfZGVjX3JpbmdfZnVuY3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+IC0tDQo+IDIu
MjUuMQ0KDQo=
