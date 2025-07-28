Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDEA2C83F17
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jul 2025 17:55:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6535E10E55D;
	Mon, 28 Jul 2025 17:55:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FXD6+d4o";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ACFA10E55D
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 17:55:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ufLQViTCw0LlmWuzl0jUpmFaj2Ya8igUzZqhAa+OJDGh/Mz43RCj3tpxgMHXY5rVm+tC0cd/0bDG+ndfBeGOE5jGGUGJh3qTntbVnv7kahxTp+Bk+11C1qqql5hZoHgePl+4Z4VdRLza2t4HjcFUIEUNenCA/4IyogcQ8jIjd8lj6J1YGS5ZrriYYCZeMxxGqwcYiC+4HCzzc0ImIrVmpbr/PC6UgJXxdXklDeTc2+Tc0Zg1plyWgb3Iv5eOqb+wo7bzzxBFTX94ueXEMZtw2xd3JC/pq9oLfnf8YOGrVdMWURjGjprFjDtxKM7/2EEsLSJzTWzMLwMRHqEJ84Salg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cb500JiocMGYpwsUDLimDK31xUqs07JrYS25k+3kwrI=;
 b=DyBX4EJBrHwtRwrx7FrAoHfDf4B6Pe6FEuAnaO7epUd5+2FeELSDBca2yE2LSsFL3d4Ocsgns1mXw3Gfa6e3/pjRfshW92KnI/DqyFL/hfe95/pAIJwm9Fz3KmyX3zKozB0aOo/+qIzqgOvSAls+0TplbW08uZw74MMx1r7nXr2wgicfnId2NRwrT9lr2FAlTazlIPL533M6uE7bDs09EvGeIOB07RVr+mw5A51YJDEDkZgevCbZ7ahga4Rrqy3o8EukZCFzD/tn4+PhnRgBNyhrVV5sQdDxIX2Vd2iCw6vxWKIkNMyq2HVBFS8m6OXLPKLWQc1vPmwIiAQR6yg4tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cb500JiocMGYpwsUDLimDK31xUqs07JrYS25k+3kwrI=;
 b=FXD6+d4ogiI+TmFWfg4TtpA6/Bfm8A2cwly5Z8WWcu74jGa4mt35wuONMFS9AP4wfZxsMy4ij+Z8GkWkwX1aO/ELh5L2iw33/4n/nEuYo0LPC3RtyYhMJbglDjDUx1ye5AcN1i9OM1iSGL8q9UjUEo6PiBg+OWq5UW47VWFzVaU=
Received: from DM6PR12MB5021.namprd12.prod.outlook.com (2603:10b6:5:208::17)
 by DS0PR12MB7972.namprd12.prod.outlook.com (2603:10b6:8:14f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Mon, 28 Jul
 2025 17:55:45 +0000
Received: from DM6PR12MB5021.namprd12.prod.outlook.com
 ([fe80::bb5c:1ce:83ad:3169]) by DM6PR12MB5021.namprd12.prod.outlook.com
 ([fe80::bb5c:1ce:83ad:3169%6]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 17:55:44 +0000
From: "Yat Sin, David" <David.YatSin@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Bhardwaj, Rajneesh" <Rajneesh.Bhardwaj@amd.com>
Subject: RE: [PATCH v2 1/2] drm/amdkfd: Restore SDMA queues with engine_id
Thread-Topic: [PATCH v2 1/2] drm/amdkfd: Restore SDMA queues with engine_id
Thread-Index: AQHb+zCw58CIKUbD1UGrW3UgdiwIjLRHumiAgAAYWcA=
Date: Mon, 28 Jul 2025 17:55:44 +0000
Message-ID: <DM6PR12MB50219C19B47364D4C6C13202955AA@DM6PR12MB5021.namprd12.prod.outlook.com>
References: <20250722174712.450292-1-David.YatSin@amd.com>
 <faa11cfa-980e-4cf1-957d-899088a5ecd2@amd.com>
In-Reply-To: <faa11cfa-980e-4cf1-957d-899088a5ecd2@amd.com>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-28T17:25:09.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5021:EE_|DS0PR12MB7972:EE_
x-ms-office365-filtering-correlation-id: b2e2d0ae-6785-4288-76ab-08ddcdfff9ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?czNEcWVBQllTWVJ1RWsvSUVjVndNQWgwR21TYnlpSFg4ak92alpCMGprRjlL?=
 =?utf-8?B?MHhGUGtoSW5rWmxDc3RRTE9UbDlhdkVTaU1uekVlUitieFpxUitOVGpvUm9a?=
 =?utf-8?B?QTNRNEI2cEpNZ1N0eXlFYU5vU3BzUjdLRHdyQ0l6K0UvaEk3OFJYZlhHM3I2?=
 =?utf-8?B?dmE4TFpua0pud05HWHp6QWtFVUUwbnhka1RmcHdmYXRvK0lJcEFMNGJaSlE3?=
 =?utf-8?B?amFBeGU0TXBnQTRzZWM0WTBCcm4wZFc1MEFwVDNyMVJTZ3QvdVIycVBCQ2kv?=
 =?utf-8?B?SnRmU2dzYVBIeHUyMGZ2SjJQYnVtWTE4cGN4NklYMWlTdHRtcGdmSjZueHBJ?=
 =?utf-8?B?elZnNnhkSEhxY2dSd0FDM2h0RVhXNi9CSWYxSXBrbE8wQ0N1TitiaTE3OUkr?=
 =?utf-8?B?Z0RPZ0RVdTgrb2t1WmtxYUQvRUZPa2UyMkpXOG9TbXg5Y0tWVkRxUkhNa1RB?=
 =?utf-8?B?RW11RUFLcENvejlsSWRLNkhYVUlaRkpyeXdKYXV0Y2lUSUZvcE1ZNkZDRGZN?=
 =?utf-8?B?MGlEaUZOSXRxa1JZN0F6NWIycDZXWXVSeUV0cDh3amZwMjhGcHlvVzhwNSto?=
 =?utf-8?B?WWM0UEpZcHVGQUZ6eEtha056OFBRM1dLMWhLRlNvczczUWlvUExOSTVWSlBJ?=
 =?utf-8?B?R2YvQWdtT3d6QTBRbzkyMTBCRXVpV2Q3NDd4K2VnZ1pZR3diQXFqOWtSNFlp?=
 =?utf-8?B?WFc0ZFBmWUZTMUJnemRRdlduTXMydnE2cU9uVnpkZ3JRTE52VzdFMm5qNGR1?=
 =?utf-8?B?enlJL0dMWWFzSk53UnE0RHJRZVhnRU8weWYzZHZ5K29la0NFek5aZHhSdUJV?=
 =?utf-8?B?dUYwZ3Zpc2RaajhUQ0ZDWWN4OWFKNkZQMk10c2IzUWg4NTNhaTVBVVNUS0Yz?=
 =?utf-8?B?aG9RMnVQQ0t1T0pKTGJiMjhramFGcDRRamRpNWx0K0FDUElkS3NLTXJyZEZp?=
 =?utf-8?B?a3J0MU11RWhuS3RldUtlWmc3c1F2bW8vRFNGcithS0VEb1hWNzV6SVUzaHRM?=
 =?utf-8?B?RmtnRzFEbG1sNlUyRXFxbmREUy9WajBxNXVBL2lLcit4RHZSZ3dvZTFPYyt0?=
 =?utf-8?B?M3V2YVVWanRTRkRYQjQ0VlBzM25hL3c4UWVtN2JNVWhzcC8yR28wa3RqZmxR?=
 =?utf-8?B?cUxtQ29pZXBNQVFUOXpoKzhmNjhMeTlhWVdnNFR5Zjd0b01odXYvRWhyaG85?=
 =?utf-8?B?Z25uNm9BNjZXSHlTQTdNYkM3R2tOWWdueW40dFNlVDkzcEEwOGhvR0E5WTdo?=
 =?utf-8?B?eXM5aWNoNFVza1VrL2R3YmdRbDFBNkJaWVRNNlZjangrOGw4Z2tnbzFyRE85?=
 =?utf-8?B?d2NVNmpPVzJlY3NaWDVJV2ZkQlRvNjZkMXFMY0lJSW9iTmFJU0lBdFh2cW9z?=
 =?utf-8?B?cmJOdDRmQW1oSXNKcFV3Y2QwMWl3dmZrWWs4SlZ2WW5ydGNMN2NjRW1wT2Vy?=
 =?utf-8?B?K0ZlRGJLTDBlR0Q0MXI5SjVac1kxVDIyT1FXUjBvQ21xQ2k4NzR2YVM0elNh?=
 =?utf-8?B?dzhpNVpvVGlOR3FRcW8wdlVaQ3p6SS9NZ3ZJMmFBTUxKYmZzZ1RHR3lpRktp?=
 =?utf-8?B?L0kzWnZrTHhyUUUrbEIySTM4a0JhOHZCUDR2YXJWUG1GOUVHbkJ1U3JFbllV?=
 =?utf-8?B?RStDaXdkRFI3UWtoQ2sxT3p3SHBicHE0alhlcEhpNTVRbWNOWGFCMitRdVJy?=
 =?utf-8?B?WlE5R0VqblBuTndMbnVGN1V4QlVWcDFZcThESlQzb0owMDhpblBwZ3JydnBR?=
 =?utf-8?B?ZU9hRlNLa2p4S0k4S1daNGtmSW1FbFVrQi9UaFhnUm1HeFgyc2lpMEZhRXhx?=
 =?utf-8?B?aFl2ejZ0SFJPZ2ZyT09XeTF2d3ZMYnUrb3FCaWc1V3MwdCtCK1pJYmQrZjFq?=
 =?utf-8?B?SmVHaXZNNEhubnJ2OGdiUWJjNXgxMU4wN25ibGY5ZVQ0UjJmQU1IZnc0amYx?=
 =?utf-8?Q?WMZMr9vPtpc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5021.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QSttTFZZQ0FHdFRDR2ZIM1k4aW9lQ2lYM241ZnRXTFViM2tUbHZmRCtCWDd6?=
 =?utf-8?B?dU9SRVBUekpRdWhlWWZZNTdDQWJrOHRBSERuRXUySjBpMVNPUjUvaU45VCtN?=
 =?utf-8?B?VzlQQUJ6dlpIVzg4ZlovMFRYanorcWdPbUtCYXFhMnk1TkVmMjBzcG11MGNt?=
 =?utf-8?B?RTU0SzJDSjg0cHQ2YjgyYlQxU2xPdmppV1lWV0VPWm5pY3ZTVUZvNTd1TUFD?=
 =?utf-8?B?L0wwZjJFWWRZNTZYOE1FdlF5Z3JkT0RYcUNFTFFhWE0wUUZWM20rbFVlb0ts?=
 =?utf-8?B?RHpuVEQ4ZTA1ZXZtMldkbk5aMlFGYXdIQUVZNXRNK2NkTDdmdW8vb0ZmTGgy?=
 =?utf-8?B?WFpncS9MUFd0OXRCczlVOU5peUtZY1dGTytjVHdCWEVhaGIrNDhXVEZRMC8z?=
 =?utf-8?B?SjJpSWRSWThTUGY2SnpPeXg3bUI2RzAzWkdrMzJ4NzNMTEMyUmUzT1RJSHZq?=
 =?utf-8?B?S1ZMeXZFWWxQdDRZZm42eEhxejJDdktzaUdXZXJCalMzMjRQRCtqdkNGeElD?=
 =?utf-8?B?M29OdHFTblNxWVcxaVpVN3hsbEh6eWMxQlNOd3lLVUxLZUNlVVpwQXpZa3Nj?=
 =?utf-8?B?ZXFsYzFBdjVMUDRsbVdJNXRPMHh3WFRib25iZVh3MDdoSzlBZ1JzRlBCWjha?=
 =?utf-8?B?cTdBbWt1R3EwODVTemxqeDNOSUl1UGsxaHExcGcwL0xZZDl4SXlSZ09FQ3B5?=
 =?utf-8?B?K0s5dmREaTdWSEh1dGNSMm9LZjNrL3dWU1ljcmF6QXB3VzNoUzFZRENqT0c5?=
 =?utf-8?B?M0lTK2J1UnhTaVRPMmZyMm1yNzRmSkdhZTBRNmlqQUpPNWt6bnNNR1RYNWRq?=
 =?utf-8?B?R3ZvUmdHd3djQkRQNkg4RElBRG5aVFZ5eGJiUC9nUXduSUtpOXlpRCtWc0FG?=
 =?utf-8?B?MzRtRjZZWHRlNU1rcUdaRlhXS29RL3QwQTBQTmZFaHVhdDc5UEZuak5icWEr?=
 =?utf-8?B?OU12Z29DVVNKN0UvU0ViRVQwUVdIeHlGenZEMnZIM3ZOd1p0MFpXTEF0QmE1?=
 =?utf-8?B?emVjRGFtdUhXUWtvN213MVJyRHdCZlZNd3hYWFZObDJxdkcwNnYxcDdHa0dD?=
 =?utf-8?B?NkVJeUdmOXI4YmVDWVFQYWRvMmFVSVViaTJNdU80K05sMzBIeUlSTW5PMTNC?=
 =?utf-8?B?eDRvY3pxbWg4Z2NENzVOc2NRS0cxSjFrODB4TTU0cXdNZ3NqSmk5UytMUTVp?=
 =?utf-8?B?dXFXaVVIeEZDVUE5UThWRktLZ2t6NkxYS0RCbVZwVllJZkEzY0NXMUJ4WFVV?=
 =?utf-8?B?N1ZpZVZXUy9FWkg5Tk9tcGV3cTRVRUg4Y2dORndGQzgydVIxbEtyTE4vZFBz?=
 =?utf-8?B?RkxUOWZoenZidUZSN3JMM0xPYXo0ZXE2ZHFMc3YxdEZjQ0ZBbkF5SzlPMGFI?=
 =?utf-8?B?UzE0WEZPQjduZkpPeFp1KzZLVFEya09ibXIyNCtTZ2VKby9Mc0M4QS83SnRT?=
 =?utf-8?B?SEQ5YzlQdHdGN2N0Zzh1czVXeEVmZ21xcHQ2NWFiWlFybmVrcytEQUUxSWJW?=
 =?utf-8?B?U2k0YUQ4aEhKb3RVRjZnM1U2RndpMGtHME5OSHVjY2IzaTJYanQzOENzVGZa?=
 =?utf-8?B?My9hWEU5alpueVhHY3hqZmYzL3YxN3pqZ1l4ZFdUTnFyb0dFUHNvSzkwTjgv?=
 =?utf-8?B?V01Gckc3cmVrRUdKM1dJSkdwM3NFbjZROHF4Z2gzQ0RFbUo1QUV4TGFZV1Ft?=
 =?utf-8?B?dTNZaDRFaFF3azdXRWhvTDVjSG1hZndUNVIvb0FsbHl2WlR2Sys0Z2pxZHlQ?=
 =?utf-8?B?aEJlZC9EM1pTME9QUnhhLzQwWUFFWkphbGdUekdkdjd6bkp3K3FPYVRRcSti?=
 =?utf-8?B?aW9pVnQyVmFoQTFnblZmR3ZTdnRQUmxwdGI0VWlJZnlzSUpCbUJuVHRYK2FE?=
 =?utf-8?B?YXpVQ0xIMVNhMFJTblB5NVZ5N3pqV2hrNWxQRldtTCsrT29Yc1RvQjNlRDdY?=
 =?utf-8?B?Sjk5Z0tFWWZsdFBNYnBnUmdyVUpnVTlETjJmeEszZWRIeHpaaHY2VDdUd2Y2?=
 =?utf-8?B?ZzlXeVlqMDdhRENqL0dMaG1vWW02amRnZ3B1THJia1ZyTTlFQzRha1FMTlZa?=
 =?utf-8?B?MHJxMVAwTWlEV1lIQytqMys0SGU2UlZ3N253YXV5V2RhZzg2TzFoRzNZNzhQ?=
 =?utf-8?Q?lMHg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5021.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e2d0ae-6785-4288-76ab-08ddcdfff9ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 17:55:44.5109 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qzs2LcIdYYB7UpEs8xhM1kYCvnV3bktdE+GEncGNMXG2MZmM4JIbw7p1mm0WCrwpa86weNsSaAbIH4NfRlZlCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7972
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
Cg0KWWVzLCB5b3UgYXJlIGNvcnJlY3QuIEkgd2FudGVkIHRvIHJlLXRyaWdnZXIgdGhlIHNjYW5u
aW5nIG9mIGF2YWlsYWJsZSBlbmdpbmVfaWQncyBvbiByZXN0b3JlIGhlcmU6DQpodHRwczovL2Nv
ZGVicm93c2VyLmRldi9saW51eC9saW51eC9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
ZGV2aWNlX3F1ZXVlX21hbmFnZXIuYy5odG1sIzE2NTINCg0KQnV0IHRoYXQgaXMgaW5jb3JyZWN0
LiBPbiByZXN0b3JlLCB3ZSBzaG91bGQgb25seSBhbGxvdyB0aGUgbmV3IFNETUEgcXVldWUgd2l0
aCB0aGUgc2FtZSBzZG1hX2lkIGFzIGJlZm9yZS4gSSB3aWxsIGRyb3AgdGhpcyBwYXRjaC4NCg0K
UmVnYXJkcywNCn5EYXZpZA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NCj4gU2VudDogTW9uZGF5
LCBKdWx5IDI4LCAyMDI1IDExOjU4IEFNDQo+IFRvOiBZYXQgU2luLCBEYXZpZCA8RGF2aWQuWWF0
U2luQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogQmhhcmR3
YWosIFJham5lZXNoIDxSYWpuZWVzaC5CaGFyZHdhakBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHYyIDEvMl0gZHJtL2FtZGtmZDogUmVzdG9yZSBTRE1BIHF1ZXVlcyB3aXRoIGVuZ2lu
ZV9pZA0KPg0KPiBPbiAyMDI1LTA3LTIyIDEzOjQ3LCBEYXZpZCBZYXQgU2luIHdyb3RlOg0KPiA+
IEFkZCBzdXBwb3J0IGZvciBjaGVja3BvaW50L3Jlc3RvcmUgZm9yIFNETUEgcXVldWVzIG9mIHR5
cGUNCj4gPiBLRkRfUVVFVUVfVFlQRV9TRE1BX0JZX0VOR19JRC4NCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IERhdmlkIFlhdCBTaW4gPERhdmlkLllhdFNpbkBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+
ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3ByaXYuaCAgICAgICAgICAgICAgICAg
IHwgMSArDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzc19xdWV1
ZV9tYW5hZ2VyLmMgfCA5ICsrKysrKysrKw0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNl
cnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX3ByaXYuaA0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3ByaXYu
aA0KPiA+IGluZGV4IDY3Njk0YmNkOTQ2NC4uODM3ZGEwOWI1YmVjIDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2LmgNCj4gPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oDQo+ID4gQEAgLTEyNjEsNiArMTI2MSw3IEBA
IHN0cnVjdCBrZmRfY3JpdV9xdWV1ZV9wcml2X2RhdGEgew0KPiA+ICAgICB1aW50MzJfdCBkb29y
YmVsbF9pZDsNCj4gPiAgICAgdWludDMyX3QgZ3dzOw0KPiA+ICAgICB1aW50MzJfdCBzZG1hX2lk
Ow0KPiA+ICsgICB1aW50MzJfdCBzZG1hX2VuZ2luZV9pZDsNCj4gPiAgICAgdWludDMyX3QgZW9w
X3JpbmdfYnVmZmVyX3NpemU7DQo+ID4gICAgIHVpbnQzMl90IGN0eF9zYXZlX3Jlc3RvcmVfYXJl
YV9zaXplOw0KPiA+ICAgICB1aW50MzJfdCBjdGxfc3RhY2tfc2l6ZTsNCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3NfcXVldWVfbWFuYWdlci5j
DQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzc19xdWV1ZV9tYW5h
Z2VyLmMNCj4gPiBpbmRleCBjNjQzZTBjY2VjNTIuLmZlNGM0ODkzMGFhZCAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzc19xdWV1ZV9tYW5hZ2Vy
LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzc19xdWV1
ZV9tYW5hZ2VyLmMNCj4gPiBAQCAtODQ2LDYgKzg0NiwxNCBAQCBzdGF0aWMgaW50IGNyaXVfY2hl
Y2twb2ludF9xdWV1ZShzdHJ1Y3QNCj4gPiBrZmRfcHJvY2Vzc19kZXZpY2UgKnBkZCwNCj4gPg0K
PiA+ICAgICBxX2RhdGEtPnNkbWFfaWQgPSBxLT5zZG1hX2lkOw0KPiA+DQo+ID4gKyAgIGlmICgo
cS0+cHJvcGVydGllcy50eXBlID09IEtGRF9RVUVVRV9UWVBFX1NETUEgfHwNCj4gPiArICAgICAg
ICAgICAgcS0+cHJvcGVydGllcy50eXBlID09IEtGRF9RVUVVRV9UWVBFX1NETUFfWEdNSSkNCj4g
PiArICAgICAgICAgICAmJiBxLT5wcm9wZXJ0aWVzLnNkbWFfZW5naW5lX2lkKSB7DQo+ID4gKyAg
ICAgICAgICAgcV9kYXRhLT50eXBlID0gS0ZEX1FVRVVFX1RZUEVfU0RNQV9CWV9FTkdfSUQ7DQo+
ID4gKyAgIH0NCj4gPiArDQo+ID4gKyAgIHFfZGF0YS0+c2RtYV9lbmdpbmVfaWQgPSBxLT5wcm9w
ZXJ0aWVzLnNkbWFfZW5naW5lX2lkOw0KPg0KPiBJcyB0aGlzIHJlYWxseSBuZWVkZWQ/IElzbid0
IHRoZSBzZG1hIGVuZ2luZSBJRCBpbXBsaWVkIGJ5IHRoZSBzZG1hX2lkPw0KPiBUaGF0IHNob3Vs
ZCBiZSBzdWZmaWNpZW50IHRvIGVuc3VyZSB0aGF0IFNETUEgcXVldWVzIGFyZSByZXN0b3JlZCBv
biB0aGUgc2FtZQ0KPiBlbmdpbmUuDQo+DQo+IEkgdGhpbmsgd2Ugc2hvdWxkIG5ldmVyIHNlZSBL
RkRfUVVFVUVfVFlQRV9TRE1BX0JZX0VOR19JRCB3aGVuIHdlDQo+IHRha2UgYSBDUklVIGNoZWNr
cG9pbnQgYmVjYXVzZSB0aGF0IGdldHMgcmVwbGFjZWQgYnkgZWl0aGVyDQo+IEtGRF9RVUVVRV9U
WVBFX1NETUEgb3IgS0ZEX1FVRVVFX1RZUEVfU0RNQV9YR01JIGluDQo+IGFsbG9jYXRlX3NkbWFf
cXVldWUuDQo+DQo+IFJlZ2FyZHMsDQo+ICAgIEZlbGl4DQoNCj4NCj4gPiArDQo+ID4gICAgIHFf
ZGF0YS0+ZW9wX3JpbmdfYnVmZmVyX2FkZHJlc3MgPQ0KPiA+ICAgICAgICAgICAgIHEtPnByb3Bl
cnRpZXMuZW9wX3JpbmdfYnVmZmVyX2FkZHJlc3M7DQo+ID4NCj4gPiBAQCAtOTcyLDYgKzk4MCw3
IEBAIHN0YXRpYyB2b2lkIHNldF9xdWV1ZV9wcm9wZXJ0aWVzX2Zyb21fY3JpdShzdHJ1Y3QNCj4g
cXVldWVfcHJvcGVydGllcyAqcXAsDQo+ID4gICAgIHFwLT5xdWV1ZV9zaXplID0gcV9kYXRhLT5x
X3NpemU7DQo+ID4gICAgIHFwLT5yZWFkX3B0ciA9ICh1aW50MzJfdCAqKSBxX2RhdGEtPnJlYWRf
cHRyX2FkZHI7DQo+ID4gICAgIHFwLT53cml0ZV9wdHIgPSAodWludDMyX3QgKikgcV9kYXRhLT53
cml0ZV9wdHJfYWRkcjsNCj4gPiArICAgcXAtPnNkbWFfZW5naW5lX2lkID0gcV9kYXRhLT5zZG1h
X2VuZ2luZV9pZDsNCj4gPiAgICAgcXAtPmVvcF9yaW5nX2J1ZmZlcl9hZGRyZXNzID0gcV9kYXRh
LT5lb3BfcmluZ19idWZmZXJfYWRkcmVzczsNCj4gPiAgICAgcXAtPmVvcF9yaW5nX2J1ZmZlcl9z
aXplID0gcV9kYXRhLT5lb3BfcmluZ19idWZmZXJfc2l6ZTsNCj4gPiAgICAgcXAtPmN0eF9zYXZl
X3Jlc3RvcmVfYXJlYV9hZGRyZXNzID0NCj4gPiBxX2RhdGEtPmN0eF9zYXZlX3Jlc3RvcmVfYXJl
YV9hZGRyZXNzOw0K
