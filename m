Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E21ECD9B0
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 01:14:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C821410E225;
	Fri,  6 Feb 2026 01:14:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e5/U5jMU";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012049.outbound.protection.outlook.com
 [40.93.195.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63F7E10E18E
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 01:14:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVbA0PHTkQnYDDYFNY1cO7kodJoso6/7xqp5TvX7BntmhzZDpmjY9N/o7r+bR0NBuDPqHXiJ9DsWB4Ro482mqZCghH5a2Su6clddEXRj2ff4GpMDSVGWJ0zE3qWOT2nBvjLzV9EzeIg3Eu9Ct0Ku40uBO00UoyGQR3nOWfPjsmw/5TDjEEi01vyyAGgshBsniF0JDbBz3HQrzpVJIvcymXhMCXBPb85c4qzxYlR6pn6EeJqwttj+05epvwQyeQ0wxsk9XyhP75dgzd6Y2N0YRq+prcto6hJM3aUSlOqJdaukhUzntBYTCOF5msb7UXGmrmXyhJpnxQeCNVyCn+Lpcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WDEFr4MD2YhQELhK8hoFxH41QrnNPvGgkEkS5cvAGk=;
 b=viX5kVgIDLOUU3sCiTqZjrFzsM+dQpKP4UXj7R3GRs43gEGK46oor88u9mpP05tujLgJrIUMZLZSJ5eEBOk34BOUr5DJGn96anhH8andZ4TWECZDgqI/SbFDog6v2DTAiusCq54QOo4IMuM8qBrs2auOwF5dH6BbzgxE9Y1yMS4XxzcbxFILMGOCEiIWAh1fHmUqNhiHvmPZCzrVDP4mfL2rxZ4hSksKteCb6DxkpjVnJ+9NKNaW+fQDIiat5lSWWgKWf/rJUPL/lQGwVi+oOF1Mza0zalttqCAhNPiGzHzaF5Zs1Y9RIclMKTyXVbvW2BYlk1vbNnB+qODi63iUsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WDEFr4MD2YhQELhK8hoFxH41QrnNPvGgkEkS5cvAGk=;
 b=e5/U5jMUd6tPYrAhgKLQbiogM0QNNUIWDIFhnEzbNJ6hR701vK+bTlOKXzVsSFcRAUY+N0WxOPaZWYvSnDSYATBUjHMoUQ0nsZ+ez0hxtMt/9KHE8+BV4dN0jir7LzDmZ38VsdbAyE4KrSfhRFq+LHHikuyKdaVcowfrfszIbU8=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by SJ0PR12MB6926.namprd12.prod.outlook.com (2603:10b6:a03:485::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 01:14:28 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%3]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 01:14:28 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix parameter mismatch in
 amdgpu_userq_set_compute_mqd()
Thread-Topic: [PATCH] drm/amdgpu: Fix parameter mismatch in
 amdgpu_userq_set_compute_mqd()
Thread-Index: AQHclprO652XWquJcEanlWiorpBKZbV03kNA
Date: Fri, 6 Feb 2026 01:14:28 +0000
Message-ID: <DM4PR12MB51521F6AC0F0B528037B5D14E366A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260205122656.286831-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260205122656.286831-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-06T01:13:00.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|SJ0PR12MB6926:EE_
x-ms-office365-filtering-correlation-id: 6935612c-30ac-499e-a829-08de651d134b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?bkR1RU55anNnemV6bjRLOS9oSGVqRFJzUmVGNWZSZHF1eWJsdWhlbUNvSjZH?=
 =?utf-8?B?aFZTTEVxWGdvdzdQdGwxSklvdFo2MGplSEwvcjhSc21ESGI3Nlk0VjEyTHJy?=
 =?utf-8?B?MThRc0ozZUtZalhKWHlPVjRSYkRsditFU09CRjNlM1hRaHcrTE1UUmFhZnZE?=
 =?utf-8?B?SGx1UkdjTmc2SlZXM01wR25FMkNEWmFpaWNPR2xvcGFNaExpVEVsd01LMWsz?=
 =?utf-8?B?R0w2ZzVvVEtwN2JBOWRUQ003dGJwdG9oUHloNlBEQi9pTk9TdzMrOVR6b0d1?=
 =?utf-8?B?T1RCdTYwWHVwTFQ3aHRmZW9sQ3M1a2JXbnVwR295eXNWdW9nckFOSzlTd2FE?=
 =?utf-8?B?clBvcytLRmtsUWVQUkRYK0IzbnRUOEF4WkxJZTdYMWg1UWxsV1ZsR1RlUXp4?=
 =?utf-8?B?NWRoYXY0dlFyd3o1VDYwSzdGZE5rcTZvTlJ1Mm1zTWgyYzVXL3gxTytnaFl6?=
 =?utf-8?B?blBpSE0zRElMdGl4WDZGVm1TTDNHWFBHOFpoL0oyNzZHM1JhTGRIU0FWQ2cz?=
 =?utf-8?B?SDFJWml3SUVYNEpZbHRlYkFTRG0zWGlGSm15M0dEQUszSDNxRnAwYzh5cUIy?=
 =?utf-8?B?L2Y4OFh5WGp0SCtkMUVmRjQ3MW50bzNoQU1BZUozWGRoaXA5L0dCaFNHMk5W?=
 =?utf-8?B?VTdiUFUxMjZFZ2ZiWm5Gd3pvQm9SSnNTWUpjaU1tZ2JnSnFJUlVvOGlwdWla?=
 =?utf-8?B?eWU0NzhqZ0hnMC9kTmFVVFJLQVQxWTcva25EYWgvZldaVDdrUlNXd1Z2WEo5?=
 =?utf-8?B?SGUva2xPZHhZS1ZQOWF2Ym5TTDQvOWRjbGhQQTNleHZNQlhEd21XSkhJdDdD?=
 =?utf-8?B?TERndEhiZnNkR0xQSVZXaVBSTnBQNXlkY1BRR3UzYlh6dzN5bVBuWkdmSklG?=
 =?utf-8?B?aFRmOS9tKzh4SVdqWEdnaXJzc3RTczAyWWUwZ2ZsZE1VVnFlcHBvdWpoMUFS?=
 =?utf-8?B?amllOU56aUhzNXJ5aDcrK2hoUlluSjRTM1B4MWR1MUlhc2syV056RUw2SlhV?=
 =?utf-8?B?NE50SWJ4V2FISWxHcE15THBwRGJmcmFlbjJSU3NGeEpqZXc4ZDg1WDBVWjlQ?=
 =?utf-8?B?R1IwZVNob3JaQm1WUjlzMlVyZUlZLzdPQ1ZQTnBGdkxKUjJOMmRrRzNhWHMw?=
 =?utf-8?B?WWNkSFp5VzFyVzVJQUZMdEpwa1ZuQWFzM09lZVlPclgzQ0VlMmRHeVR6SE5z?=
 =?utf-8?B?MjRZdWVaWXBaa2dQQzhZaXRLT2xKS1ZqNVpQUFg3dmZta0hvdTcrYzhINkRW?=
 =?utf-8?B?TXBBaXFrRXJLQjJvMjQ0T3dKVm9zdFdPNmlOWnFxYnI1UHlrTTF0MHRiUVd2?=
 =?utf-8?B?Y1k4ZzB2NGFDOHhXQU4za1dmbHlPcUtFeUl6OHliSitOai8rQ1BlR3M0V2ZE?=
 =?utf-8?B?K09UMzFKcUpvSTBDM0NpOVpLeVVQc2JBZUttdWVnL2xqYWtqN3BTaDRsaDBP?=
 =?utf-8?B?ekZZa1hkQjVPZW4zTWJRcjJMblRNUXVONmlPY3B4SnBsYXRNZ3RiRUtkbyt0?=
 =?utf-8?B?ZDFOakJ1cU4rK2xpYXdIWk5nSktuTk5mRWRuS0N0NWMwQ1psWVVUeGcvTzZJ?=
 =?utf-8?B?QmtBWlhMZnVaK3dHNTFoSUhwYXJuTHg0RXRrSTlzUEFna3JOWUtrRGlya1pC?=
 =?utf-8?B?dVlncDRkakRGYWlYTXZnM01hN1ZaeHRWc3BMUStkclpWZ0ozWGl4SW00a0Jv?=
 =?utf-8?B?TEMwRmNKZG1xVm5JajJlRytnNEQ2NEhKcjkwNHlKQ3ZXVTZHTnlDc3NkMzVW?=
 =?utf-8?B?ZnIyb09XS25oWmh6VGpJd3ZoQjUyWHRnZ0xGMHllbzdGWm9PdFR3WkVFZlpF?=
 =?utf-8?B?OE9TNXB6REpZcHFyTE5IZmIrd3B1dEtkYU1TM09DcWdIek8rbjBoZXRWNWV6?=
 =?utf-8?B?S1Z1VmpNeElSemVXUUxTRnY4S1czSEVsUVRmdWtyQUVHK1VqYm5LR3BITzFw?=
 =?utf-8?B?ai8wTmZ1emhIeGprZXlyeHRKNmZPRmJ6VU9wcGpUd0Q0VUFKRWJ5ZUkyUWRE?=
 =?utf-8?B?VUlxTXVXSFMwcStCWm8xdkF6U3JWV2lqWlQ5bzF5VG9Rb0dCdDZnMkJRN21l?=
 =?utf-8?B?c2s5Q1k5RnpUTzdUUmtNTkZzMHZEa3NDdnNpS2ZMaFJxbzRyRUNMTU1JUzB6?=
 =?utf-8?B?OHY0amIrR2hSZlJYcXZpWmdMQjlOY3NXZ1BjemtIclplUVdYcFFYVm5JL3R3?=
 =?utf-8?Q?99/u/oRc7C3b5zcpmeyXMwc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckM1WWFKeWx6K1NoY2tzdlYweTlLaWF1cnhDaDd2V0g4L1RPbjZMemg3NHNk?=
 =?utf-8?B?dmo0RUhtMDJoUE8xNUMxaWxHNm1FS2FKTUU3ajJtQWFQS2lVRU1CNDdCaVU2?=
 =?utf-8?B?ZmlzUTQzYkk2aUJ1NXRzUldDRDg2azhsK3ZTVGNMR0diY2VuTm92dEM5ekNx?=
 =?utf-8?B?RUpRVkE4VzBHdURaSlRVWFJOdlN1Wm1Fd1ZrcG9yWXVDWFcreFdsK2pmQnJ5?=
 =?utf-8?B?OGtzNmQyWjlKbGhIMThJanJNNjBFTGsyOG1oQnFFZ3Q1WWFwSWtLa2ZieTNq?=
 =?utf-8?B?bGk2Uys3Ylh4aDByTHlVNDVvNnRuaXphY055bVFhSnFrL1VLNWZPK0Vmd1hS?=
 =?utf-8?B?NkZ1YjBEWjVOWUl1NmhZN21lMEFjWkxMRWFydWsvUHl0bG1CazEvd1FUQXpw?=
 =?utf-8?B?TXNCdHZIcitBWFJnY1ZnSCtRWG9aNlBtOVVmYTNhNlFsN1ZVcHM5MmQ4KzFx?=
 =?utf-8?B?WnQxa21TamhsbVd6ekgxNFd1ZEZRODhHK2JLTDVBdXdCNFFZU0hlMmYvdUx4?=
 =?utf-8?B?MU00VTdDVkNYdW1Vb1YwRDU0QzZIcTUvN2lRZlRCMEVTek1UTnczU00yLzEr?=
 =?utf-8?B?SURVckQ3Y0hFMm5NMkl2UTZzMFowMVlTRkRNVVRwSUZHMjBaVmtLVWRmcEZ6?=
 =?utf-8?B?QmtRSlNTNncrS1lEQVk2dUlOVjkybWZvcVVIVllncm5xRG42M2lmSkY5MitR?=
 =?utf-8?B?SFpTMmp2eHZodUdmUEZjQlFiRWlYZXBydGUxbFZaSW0vMllVL0RnRTEvWGRy?=
 =?utf-8?B?VVczYkxTUERkZDBMcjJBbGdaOU5OL0RUTDJDWkVta254QlozRXptL3hvaDNh?=
 =?utf-8?B?QWVOMjh6UmlEWHRETFZGaStlNXFqL1VjVDF2Y2JXN0JIcGxGSzdsNkYvWVE0?=
 =?utf-8?B?dnN1RktzK0J5SWlLOTBHbGdZRS95YWtxNUEyUURLWlFjSWU0R0p0a3hsVUxM?=
 =?utf-8?B?Y3ZDNnlEWnROTFp6MkQyQ2t0d1FwZXZjTXhyWDdJL3dpYUlMYy9Za1NLYTZ3?=
 =?utf-8?B?MUp1czN5ZVpvTUtjQ09ZeDFSeEt6aHpISHA3eGQxZXBtU0lKM2NEb3FLWWx4?=
 =?utf-8?B?ZjFockptUHkxOURwQlVjeUVZSzkvbmViZEsyd2JpVGVWUVU0NGR2c0ovV1Bu?=
 =?utf-8?B?WmpHdHpORkJFR0pGK0ZONWgzOGZsNVhqbVJFYmpiUGI4NFhtU1pFcng2TVlE?=
 =?utf-8?B?bzVjNWtIbTZncVFqeTZOaERaZFR4Q2hYRkhDVnhjeFRvZFNKc1ZYWWYwak1C?=
 =?utf-8?B?ZVNYZlpsRkJsSHQrZ3BKWXhOc3IzMUNhOTNkVSsyNVFNc0JFdzA3aGcxcVJD?=
 =?utf-8?B?QWdsalMwdjFyZHVTMmJ2bXB0ejlhM3dWVG14Mlh2Qm9JRFRZNWtzdmp5R0pv?=
 =?utf-8?B?M2JKck5ZTXREeXVhS2JsNEhhSjZlMGNqcmFvd1FuU3VLS0ZYK0haZTUveTJD?=
 =?utf-8?B?YnVaSGxMRHNOZkRlSEFtd3QxV2ZTeURLb0ZkSytKZjhNK1MzcjNDcWU5ekNN?=
 =?utf-8?B?UzZ2UTl3UnhEYWRWTEtaeXZIQjlEYUp0WVR4TlRZc05RTENHMUFpbTdYb2VZ?=
 =?utf-8?B?SUhTRW43N3o3WXozaHFDMXB4VlhQVGxVWTQrRTg0bTN4c2cvZis5bXR4L1Zu?=
 =?utf-8?B?azJHNUwyL2QwTTVJRVJidkY0cER3RVF5aSt6WE9yWU90cnRobHdCUWNPcTE3?=
 =?utf-8?B?TGc3Wm1HeHVyRlVmN1h3dk9uODhKZDJ2cXNqWkM3SzFaRmcrV1RtSDY2QXVK?=
 =?utf-8?B?MEJuOGlzZWxnRklsMWcrZmRPWnZROEY1MTY1V1J1TVdLSG80Z1Z0d2o4WHMy?=
 =?utf-8?B?cFF1SDJnVTk0c21qbkNJZjAxSEZoYVdKeWxNUGZ1bFJwY1hXdGpDdlJRVnFZ?=
 =?utf-8?B?R1hEalpnUng1Uktpb1M4TW9zcnhCMkM1TnlQRWRHRXB6cVNqc3oySi9WSVdr?=
 =?utf-8?B?NmxUMEFlZVhVd2J3ZzhLMUU4ZEVPbmFyV3lFVCtwU084REhpOTRZUjdWSUYr?=
 =?utf-8?B?eEg4MzZlY2hqSFQxS2lERElhTC9Oa0Q1VkRCZEl5RDFteWxSd0l5NzRHNCtG?=
 =?utf-8?B?N3BpZG5HL3hXeSt2d2hKUi9BeVBJdkkvSWYzb21IQ1pDUzdTRlU1WGZHVDMw?=
 =?utf-8?B?SnhoVUZUcTZIZWRhanJ6eXZ2WHFxYXhHalM5SFNmNHNDalNSc2JYZzd6WVg1?=
 =?utf-8?B?OGlFd21ab0QzbWROYzk1SjVJT3hiNkVxWjMwMnVSNEp4VDVTaWVwZVE5L3lO?=
 =?utf-8?B?SUw3U2NzcmxaUjRQV3UzKzFJTzNrQjN5andjZ3MvdzkxWEltRDJIVml1QWdN?=
 =?utf-8?Q?eE8gYzQFwpvc61Onwf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6935612c-30ac-499e-a829-08de651d134b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 01:14:28.4537 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iCK6qobTyp2lDuLkQl/XjSgxChT8CorpLoJLSpSDW/oTVFenYuYBhXROk5IN+xR7Toe2tX35G6lHFLSYEiu4pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6926
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
Cg0KUmV2ZWl3ZWQtYnkgOiAiSmVzc2UgWmhhbmcgPGplc3NlLnpoYW5nQGFtZC5jb20+Ig0KDQo+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGFtZC1nZnggPGFtZC1nZngtYm91
bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBTcmluaXZhc2FuDQo+IFNo
YW5tdWdhbQ0KPiBTZW50OiBUaHVyc2RheSwgRmVicnVhcnkgNSwgMjAyNiA4OjI3IFBNDQo+IFRv
OiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgRGV1Y2hlciwg
QWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBDYzogYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmc7IFNIQU5NVUdBTSwgU1JJTklWQVNBTg0KPiA8U1JJTklWQVNB
Ti5TSEFOTVVHQU1AYW1kLmNvbT4NCj4gU3ViamVjdDogW1BBVENIXSBkcm0vYW1kZ3B1OiBGaXgg
cGFyYW1ldGVyIG1pc21hdGNoIGluDQo+IGFtZGdwdV91c2VycV9zZXRfY29tcHV0ZV9tcWQoKQ0K
Pg0KPiBVcGRhdGUgdGhlIGZ1bmN0aW9uIGRvY3VtZW50YXRpb24gdG8gbWF0Y2ggdGhlIGN1cnJl
bnQgcGFyYW1ldGVyIGxpc3QgYW5kIGNvcnJlY3RseQ0KPiBkZXNjcmliZSBjb21wdXRlX21xZC4N
Cj4NCj4gRml4ZXMgdGhlIGJlbG93IHdpdGggZ2NjIFc9MToNCj4gZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvbWVzX3VzZXJxdWV1ZS5jOjMwOCBmdW5jdGlvbiBwYXJhbWV0ZXINCj4gJ2NvbXB1
dGVfbXFkJyBub3QgZGVzY3JpYmVkIGluICdhbWRncHVfdXNlcnFfc2V0X2NvbXB1dGVfbXFkJw0K
Pg0KPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiBDYzog
Q2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KPiBTaWduZWQtb2Zm
LWJ5OiBTcmluaXZhc2FuIFNoYW5tdWdhbSA8c3Jpbml2YXNhbi5zaGFubXVnYW1AYW1kLmNvbT4N
Cj4gQ2hhbmdlLUlkOiBJMmY2ZWZhOGU5ODg2MTA2ZDZjZGZjZjBmZjlmZmIyNTc2ZDhiYTYwNg0K
PiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc191c2VycXVldWUuYyB8IDgg
KysrKy0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdXNl
cnF1ZXVlLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdXNlcnF1ZXVlLmMN
Cj4gaW5kZXggZjRiMzA3M2NmOTY4Li4yNGQxMDJjYjE0NzQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc191c2VycXVldWUuYw0KPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9tZXNfdXNlcnF1ZXVlLmMNCj4gQEAgLTI5NiwxMiArMjk2LDEyIEBA
IHN0YXRpYyBpbnQgbWVzX3VzZXJxX2RldGVjdF9hbmRfcmVzZXQoc3RydWN0DQo+IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsDQo+ICAgKiBhbWRncHVfdXNlcnFfc2V0X2NvbXB1dGVfbXFkIC0gUGFyc2Ug
Y29tcHV0ZSBNUUQgYW5kIHVwZGF0ZSBxdWV1ZQ0KPiBwcm9wcw0KPiAgICogQHF1ZXVlOiBUYXJn
ZXQgdXNlciBtb2RlIHF1ZXVlDQo+ICAgKiBAcHJvcHM6IFF1ZXVlIHByb3BlcnR5IHN0cnVjdHVy
ZSB0byBiZSB1cGRhdGVkDQo+IC0gKiBAYXJnczogVXNlciBxdWV1ZSBpbnB1dCBhcmd1bWVudHMN
Cj4gLSAqIEB1cV9tZ3I6IFVzZXIgcXVldWUgbWFuYWdlciAoZm9yIGxvZ2dpbmcpDQo+ICsgKiBA
Y29tcHV0ZV9tcWQ6IFVzZXItcHJvdmlkZWQgY29tcHV0ZSBNUUQgcGF5bG9hZCAoR0ZYMTEpIHRv
DQo+ICsgcGFyc2UvdmFsaWRhdGUNCj4gICAqDQo+ICAgKiBUaGlzIGZ1bmN0aW9uIG9ubHkgcGFy
c2VzIGFuZCB2YWxpZGF0ZXMgdXNlciBpbnB1dCwgdXBkYXRpbmcgcXVldWUgcHJvcHMNCj4gLSAq
IChubyBoYXJkd2FyZSBNUUQgY29uZmlndXJhdGlvbiAtIHRoYXQncyBoYW5kbGVkIGluIE1FUyBs
YXllcikNCj4gLSAqIFJldHVybnM6IDAgb24gc3VjY2VzcywgbmVnYXRpdmUgZXJyb3IgY29kZSBv
biBmYWlsdXJlDQo+ICsgKiAobm8gaGFyZHdhcmUgTVFEIGNvbmZpZ3VyYXRpb24gLSB0aGF0J3Mg
aGFuZGxlZCBpbiBNRVMgbGF5ZXIpLg0KPiArICoNCj4gKyAqIFJldHVybjogMCBvbiBzdWNjZXNz
LCBuZWdhdGl2ZSBlcnJvciBjb2RlIG9uIGZhaWx1cmUNCj4gICAqLw0KPiAgc3RhdGljIGludCBh
bWRncHVfdXNlcnFfc2V0X2NvbXB1dGVfbXFkKHN0cnVjdCBhbWRncHVfdXNlcm1vZGVfcXVldWUN
Cj4gKnF1ZXVlLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVj
dCBhbWRncHVfbXFkX3Byb3AgKnByb3BzLA0KPiAtLQ0KPiAyLjM0LjENCg0K
