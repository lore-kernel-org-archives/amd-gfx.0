Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11513C04FFE
	for <amd-gfx@archiver.kernel.org>; Fri, 17 May 2024 04:01:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 139F110E1E2;
	Fri, 17 May 2024 04:01:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z+M6OmjQ";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E94810E1E2
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 May 2024 04:01:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwTJmMoYTJc4V8ZixhTBEhGd+USxqYqIMUsqGxPA+muEj/LbBolwNlN4XVl7dBi9+8wH/EHpwcnVwy5dOkYgaKkAKuSCqx/JVlav06+8a61h63G11qBeTRGJHnKXNjbd5KgQzTY5L1Dc3b1mLU+6SPz5qNqeP4eeUw1W9MYPheb+zrwXivp5TtZ426eQo7DNbg7zuC9pKv4wWlG0GZAu0ZmNZsUB3aQGO8/nNUaQbbB3Gc/YUz+7kwhGctiaYVqdLrL9kDdSqKaxF7eKv2XbC+X79Tbt5RnY3arcDQw5bck+3JmhZJSIL8dBE49gqRQ5vWZslfvs2O5KCwPc32izfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8GzB9SeyxjsfN/g0DcVII04f9w1pNPPWqkwqgD23dI=;
 b=W86qhqFG5+FAZF8AczGW2X7vXTtCcxySDaAEUHA85cTf6JQCeDGD8NerkLTLbQcyJPpxjaXDaOKXV0FNpF74Q/su6yYU9qB1iVWuhXIKOIyTEmqkv5pzugSwN538sxbY9hpK+LLXTymRs5AyOFiJvbCFO19VCL18KX/l2UZgHx7Z5QqlcGsfBNI1AeZ0WS1Pw/s7eSNxk7G3Z3qalnNOwonTX/Pjd1BCWwq8RHpxqXDxfqpB+eSclXvtL5Vp7Q2rYg9tEd3PoznUAPO1gfXKOeU0bJJFgGupf3M6/4Pbrtpo3HMzhY8XinY7pFw9KVzcnyB2Mg0/Hb4t3QF6sPrxZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8GzB9SeyxjsfN/g0DcVII04f9w1pNPPWqkwqgD23dI=;
 b=z+M6OmjQ2WJ3DM2MJMDdl/bvf9pK8ujBHVroRmdmBtPrLG/qOAL1hIOtI3hCN/OUJ46FqZIQxxAdNlYScz8blrM8m7LHjv3EOyJ18Kr2bezYqnIi5JinZHiLDZ5Kng6T8Xvpugv0LP8FY7ohESSjjcYIfotcTGRPOl1MrLXrTb0=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by SJ2PR12MB8954.namprd12.prod.outlook.com (2603:10b6:a03:541::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Fri, 17 May
 2024 04:01:51 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::b1fc:750e:c91c:6d7c]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::b1fc:750e:c91c:6d7c%5]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 04:01:51 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: RE: [PATCH] drm/amdgpu: Remove duplicate check for *is_queue_unmap in
 sdma_v7_0_ring_set_wptr
Thread-Topic: [PATCH] drm/amdgpu: Remove duplicate check for *is_queue_unmap
 in sdma_v7_0_ring_set_wptr
Thread-Index: AQHaqArwGSZP+8BnqkeduGCjoTKVSbGazZMQ
Date: Fri, 17 May 2024 04:01:31 +0000
Message-ID: <DM4PR12MB518198136AEF25F364CE9935EFEE2@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20240517033244.1825782-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20240517033244.1825782-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=399747cb-ee17-468a-a52d-68e63207f52c;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-17T04:01:00Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|SJ2PR12MB8954:EE_
x-ms-office365-filtering-correlation-id: 7e6c24fc-8522-4ac1-6f8e-08dc76260963
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?dnJBZWV4dFh3eGg5a3RNbTJSSS9JNC9DQ3pwOVFGM3AvbGpwaUxuY1RZck8x?=
 =?utf-8?B?S2VUOCtYaWROYXhXZmhGNVhqdCsySjJZZURNSjNpSy85Z1FIUGl2WFFjblJM?=
 =?utf-8?B?QWVHZmNEaURkR0FSOVVyN3p6M0VBaThoV1I4SDJqSFptNHFGbjBTNlBFMUQ4?=
 =?utf-8?B?UkhjSWNuRDloTS9iSlF1Z0FoVXBaZ21ERTM2RW5BNld2ekNiZXBEVTBwVXpS?=
 =?utf-8?B?VEtaeEE5bXVJMS9NaXJCYVkwL3ppbUh3VTJFVXkzSTVHQmN1TE9FK1dTaHpx?=
 =?utf-8?B?ZHpUM09MM0Ywc1NucDM4Uld2WUhtalVsb05zcDk5Q3o3azFaQjQ2Zk0xaVZo?=
 =?utf-8?B?RFJrczVObXVtVXBZR2JCQndTMTFqdEFQbTlBeFIySTV0akZiSXJ6WFJnQjJN?=
 =?utf-8?B?a25Uc0VXQ2JLeFpDNmhBaDg1dFM4R1ZERkIxck1kamUrb3h2bjkyd0dqQ244?=
 =?utf-8?B?Z0o2THl3Nlh4UzE1Rk9PODRUMmxDY2g2cEJiTFpQV29OSzVwaWg0UndaSEFB?=
 =?utf-8?B?cEZPZkxCYVBtRTJvUGJqaDZ5RzA2YzdiVkU0WEZkVWsvSFQzOEJqaFFaQTBJ?=
 =?utf-8?B?ZFZzL29ySmF1TnVSNFJMQnp6b2dsNEVxOWdIamRoOS9Yc1VlbXNvNCtlRnVH?=
 =?utf-8?B?dS9JZ1RWSGxhYkJXckVqUDlhZU1sTTJZZzdoTTJqTFlwanpBeDR3K2lmeHlQ?=
 =?utf-8?B?MEpKRm1EMmg3SmFVT1F3K0ZiajU1Rm9vMDR1Z0FucElleTVrZDQ0bFRjdG1y?=
 =?utf-8?B?LzR4YTRnMTE4TWQ3SE5NdU9heExmRjRNUnZLbFppQW1pcHlHcm1MSjRTTEE1?=
 =?utf-8?B?VFJHM0JQSjgzb2lXZXp1VUFGTGdLOVRQQ3Jrenl3Q3JERFh1cGxWWXpKVWo0?=
 =?utf-8?B?Qnh2bTBGbDdsL0lienFuV1BJSXJvM2tpdjlLb2FWQUFaU0tqMm5mL1NIQ2ZO?=
 =?utf-8?B?WVV0UDNKekxBWXpCbExPRm1vU282WElBcUdab00rTlFDWUhHcWVvMnUrR3Bv?=
 =?utf-8?B?QnlKVS8wRnBqVFdrQWpqWWpybkMwalNmVlltQWE4N3VLVGdadXUyV01PQVNW?=
 =?utf-8?B?NVdRUTdXZ040V0h3eUNpSEQ2dDJwSnU2WEh4dHAybSs4YlhSb2V5OW1Hckln?=
 =?utf-8?B?bWl4OWpPeS85ai93alRuQmpZMHorRHk0WE1lZFpPQ3N2Y1FBcGE2bXJRb1lK?=
 =?utf-8?B?eWM3elBBRGpCMDhVOUV6TUVMTTc3Q2oxNFNWQ1g4YllydFdMM0hnZnNSQVFZ?=
 =?utf-8?B?aStzTjd4NWJqQ0pYcjM5ZlBXZ3NjVXY1V0t0RVh1Sk1xRHVCeEttaUVVTnRW?=
 =?utf-8?B?bmxyUVpkRmkzL3VCWXRrVlRtWDc4OG56Tml1dGN1TncyV3lqSkdCN2xMeVNs?=
 =?utf-8?B?SWErRTgzTHFOREZUWWRVeWRWRkNEUTdvM3RKRGRkbHdTb294dlllQVFPbXhQ?=
 =?utf-8?B?Tk5iRjJOS1FNbzdIY09HNTJydDVORm81RTMyRkVJaTJqM3BhMTBLQzZ6Y1M0?=
 =?utf-8?B?YUZTc2dPNzJrWnFxZHNNelB5N1lBM1h2YnRDbHN4NHhhcy91M1pvTHk0eFdT?=
 =?utf-8?B?b0tuTzBCMC9Oa1plcXF1SHh4RzRQYm9PWnFTYzlWbWk3WWJ0WFZqM2xQK2Zp?=
 =?utf-8?B?Y3dZN1I0Qk8rZ25tV1RFNVR2eWJzWHFidFlsenRxbkFZaGJNemgxR0c3M0xv?=
 =?utf-8?B?Q2FNaVcwKytKVExibngzT3pKVTNOMExtekZ5WWQxQ1hVT2hXTG4yVlQzcy93?=
 =?utf-8?B?aS93bnQyakFWbzQ0TDBjdy9CZ1prb3BCWTJna1o0bDFOMTJPNVMxNEhneDQw?=
 =?utf-8?B?UkptYkkrMlVaTUN2WnJ1UT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1o3UEdVaGpmVmNCSWNCRTB2U0FDTTFZSDNMeEN3MWFMN2ppQkliUFNLT0tH?=
 =?utf-8?B?MkpFZ2JoWEpkYlAxSXJjeFhmbjVXN3FkL0hnNnNkajErSThnWmhjakM2WTZ2?=
 =?utf-8?B?N3ZMdXBIVmJueW1nUWxHT0NKUlFaczNDdStEV3E0amlrT2U0MmxkL2hVL3V3?=
 =?utf-8?B?dS9xaTVldjFKVDlibXJqcjNlWkVkTVFxYjUwYWJqRFVjMXlCVlFnTVROVmhM?=
 =?utf-8?B?dlZlRUNDYVMxa1V2T3RxdjBuVnlXQjA0K21UUnVPZGdUSzA5TFNaRWdUZHND?=
 =?utf-8?B?OWtJbUV2bzMzVkRORS9RUFZnRzgvV0cweWJxZWZNSnJmM1dEcGpTY01iMk92?=
 =?utf-8?B?Q2xLU0psemE2YzJXKzZPZDVWemM4NWJndHVzenRveVBtTGhENHMvS1BVZWwv?=
 =?utf-8?B?NmFjYjJTNktwYTRiT3g2SjZkT2lkUm1DSFVpQUprMWtsRkdJVjRubkF4bk5s?=
 =?utf-8?B?UTZ6SXMyWDd5UVFmN2JhdlN0MzJtdzJwclNDUzV0aWR4WHlSSkJQRWp6V21t?=
 =?utf-8?B?VGZBV0V0bnZGTGU2T2d5ak05N2R5TmUwT1ZuT0VyNEZlNXdCc1BudTd6VjR2?=
 =?utf-8?B?TXNKaWl3d1dLdnE2aWhoR01iaUg5MnJLZTdtRVAvNkhtdHo1bDNoUmRtWDdo?=
 =?utf-8?B?b0YzdTBReGc1ZjRHclpUbjBJR09kSlQ0ZW5Wanhva2FNdTY1ZlRYa1M2N3o3?=
 =?utf-8?B?eVcyMXc2cTJKdnI3b1R1RVFiQzhYQ0kyQm43bEZaU1N2VE5oTDRLbmJQY0lj?=
 =?utf-8?B?U21GWGFJUThnZG9LYmloRE81Q2VVZ1JSdjIyUUdBNndYWS9uSExOMkxhLzBa?=
 =?utf-8?B?ZUIzdmxvSTlGUXN0K2V3eURucStmTHhDc0pqaXUrL09PWUtvNGZ3ekZUWGZY?=
 =?utf-8?B?UVF5KzJSZEVxMnVqKzNBNVNWY0U3bTFYcDA5MitlSkdEZ0Y4Zk9MQVJrNXdJ?=
 =?utf-8?B?OGRreE9lNURidmxLVDBJZDgxbWh3OXNJekwzY2hzVFkxYkxDN0pwRGlyL1Z6?=
 =?utf-8?B?MUlKY1dZVTdRcnRGYzl5S09paXdPVWNmcVJtVTNxUmFYUkw3L2xWOFgwQ3NL?=
 =?utf-8?B?UjBCbllpR092UWR0ZkVhSGs4ZGlUNEdFK0E1R2hETWNTOTlKaERUOHY1d2d0?=
 =?utf-8?B?SjVqU2VHbzNxMm9VOWpieUxFdThvTCtVeGp3ckUrQkJjYS9POG1LSGR4ZXI2?=
 =?utf-8?B?UXU2cTBZOXhLZmE1YzR3M3A0dkk3VDZ0NjRnVysxYWVlWTM4c2tZQmV0UXJX?=
 =?utf-8?B?MTZYNGdRQkRuODhCMndXTjZaS1lIbnFTdGRlMU9JVkluUHp1RzNMOThhRHdq?=
 =?utf-8?B?S29pNXJDcUFEUG0zOURGNXB4MkZ1YTF5WlpYN3MwZnp2K1Q2cUQxNHJjZ3o4?=
 =?utf-8?B?U2VqdCtoRFdSb0FhWW43NlVUWXNHZm81Y3dBTXlhU2pWczRJd3VNbnF5a1RT?=
 =?utf-8?B?aVlWRzBkOGxuT0k4NUtZenFUWDBYYlRlUjNUeTFFZnVxWGc0TkJEOHhjU0Fo?=
 =?utf-8?B?ZFE4QlpxM2FnL3cwNXFBOVBqWlFZdW9ueGp6UWRiaGRseWFIRGdBRmo5V3Vk?=
 =?utf-8?B?ZnVjbjNZK3R3V0VjSjRxdzJnMTh4eC80NTVXa3NZZG1uTklOVGxSSlJaNW1C?=
 =?utf-8?B?OCtFRkFrdE1ZK3lqRVpjRG9PYUZtcDBRM2xvelU1NTBtLzZ3WTZRdG5ZTysy?=
 =?utf-8?B?cjEwQWVEdXBMZDI2MXpyaXhXVjMxK3JxRmNBN1VWZjNVdzVFVjIwYy8xUzJ3?=
 =?utf-8?B?OWU2WnZUUE1lWXlEcUVPdE5SYVUrbG1FRTZBdnVvMTFzQWVFZG41eGNpa3ND?=
 =?utf-8?B?U01HeVdCREhiR3p4c0VWdzRiYk9DUGErVHp1ZHE1Wk5TeDhPSzg3K0duNmo5?=
 =?utf-8?B?VCtvRWNDaUJ1Wi9BY2JjcXo1YjlUUSttbUxUZkFMS1Z0TjNTczlPMkkvQTZJ?=
 =?utf-8?B?SXJWaGY0UUdjZFpyLzlpbHVia3BzV2NOSUJsSmk0NW5JcFpEcyttVndLZk5X?=
 =?utf-8?B?bzFFYWIxYjZSZXRET3JjNkZjNFR2aFZFTGpZZVNXSDIzeFR5NGJSRFBTRC95?=
 =?utf-8?B?dGlMZ0RPRmRLSk5SNDBWS3Zzb3A1WUtPQ0R4TmNNbnVEaU41Unk1Z1k4YWNo?=
 =?utf-8?Q?NLS4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e6c24fc-8522-4ac1-6f8e-08dc76260963
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2024 04:01:31.7595 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H9RhAeyZtyedPIlTyINNDdW8Kv7FK8xOGWPszn7O5qwv777ysH8NrQkgiOcPCKkY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8954
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
Cg0KVGhpcyBwYXRjaCB3YXMNClJldmlld2VkLWJ5OiBMaWt1biBHYW8gPExpa3VuLkdhb0BhbWQu
Y29tPi4NCg0KUmVnYXJkcywNCkxpa3VuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpG
cm9tOiBTSEFOTVVHQU0sIFNSSU5JVkFTQU4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+
DQpTZW50OiBGcmlkYXksIE1heSAxNywgMjAyNCAxMTozMyBBTQ0KVG86IEtvZW5pZywgQ2hyaXN0
aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhh
bmRlci5EZXVjaGVyQGFtZC5jb20+DQpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7
IFNIQU5NVUdBTSwgU1JJTklWQVNBTiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT47IEdh
bywgTGlrdW4gPExpa3VuLkdhb0BhbWQuY29tPjsgWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhh
bmdAYW1kLmNvbT47IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAbGluYXJvLm9yZz4NClN1
YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdTogUmVtb3ZlIGR1cGxpY2F0ZSBjaGVjayBmb3IgKmlz
X3F1ZXVlX3VubWFwIGluIHNkbWFfdjdfMF9yaW5nX3NldF93cHRyDQoNClRoaXMgY29tbWl0IHJl
bW92ZXMgYSBkdXBsaWNhdGUgY2hlY2sgZm9yICppc19xdWV1ZV91bm1hcCBpbiB0aGUgc2RtYV92
N18wX3Jpbmdfc2V0X3dwdHIgZnVuY3Rpb24uIFRoZSBjaGVjayBhdCBsaW5lIDE3MSB3YXMgY29u
c2lkZXJlZCBkZWFkIGNvZGUgYmVjYXVzZSBhdCB0aGlzIHBvaW50IGluIHRoZSBjb2RlLCB3ZSBh
bHJlYWR5IGtub3cgdGhhdCAqaXNfcXVldWVfdW5tYXAgaXMgZmFsc2UgZHVlIHRvIHRoZSBjaGVj
ayBhdCBsaW5lIDE2MS4NCg0KQnkgcmVtb3ZpbmcgdGhpcyB1bm5lY2Vzc2FyeSBjaGVjaywgaW1w
cm92ZXMgdGhlIHJlYWRhYmlsaXR5IG9mIHRoZSBjb2RlDQoNCkZpeGVzIHRoZSBiZWxvdzoNCiAg
ICAgICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92N18wLmM6MTcxIHNkbWFfdjdf
MF9yaW5nX3NldF93cHRyKCkNCiAgICAgICAgd2FybjogZHVwbGljYXRlIGNoZWNrICcqaXNfcXVl
dWVfdW5tYXAnIChwcmV2aW91cyBvbiBsaW5lIDE2MSkNCg0KZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvc2RtYV92N18wLmMNCiAgICAxNDAgc3RhdGljIHZvaWQgc2RtYV92N18wX3Jpbmdfc2V0
X3dwdHIoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQ0KICAgIDE0MSB7DQogICAgMTQyICAgICAg
ICAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSByaW5nLT5hZGV2Ow0KICAgIDE0MyAgICAg
ICAgIHVpbnQzMl90ICp3cHRyX3NhdmVkOw0KICAgIDE0NCAgICAgICAgIHVpbnQzMl90ICppc19x
dWV1ZV91bm1hcDsNCiAgICAxNDUgICAgICAgICB1aW50NjRfdCBhZ2dyZWdhdGVkX2RiX2luZGV4
Ow0KICAgIDE0NiAgICAgICAgIHVpbnQzMl90IG1xZF9zaXplID0gYWRldi0+bXFkc1tBTURHUFVf
SFdfSVBfRE1BXS5tcWRfc2l6ZTsNCiAgICAxNDcNCiAgICAxNDggICAgICAgICBEUk1fREVCVUco
IlNldHRpbmcgd3JpdGUgcG9pbnRlclxuIik7DQogICAgMTQ5DQogICAgMTUwICAgICAgICAgaWYg
KHJpbmctPmlzX21lc19xdWV1ZSkgew0KICAgIDE1MSAgICAgICAgICAgICAgICAgd3B0cl9zYXZl
ZCA9ICh1aW50MzJfdCAqKShyaW5nLT5tcWRfcHRyICsgbXFkX3NpemUpOw0KICAgIDE1MiAgICAg
ICAgICAgICAgICAgaXNfcXVldWVfdW5tYXAgPSAodWludDMyX3QgKikocmluZy0+bXFkX3B0ciAr
IG1xZF9zaXplICsNCiAgICAgICAgICAgICAgICAgICAgICAgIF5eXl5eXl5eXl5eXl5eXl4gU2V0
IGhlcmUNCg0KICAgIDE1MyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc2l6ZW9mKHVpbnQzMl90KSk7DQogICAgMTU0ICAgICAgICAgICAgICAgICBhZ2dyZWdh
dGVkX2RiX2luZGV4ID0NCiAgICAxNTUgICAgICAgICAgICAgICAgICAgICAgICAgYW1kZ3B1X21l
c19nZXRfYWdncmVnYXRlZF9kb29yYmVsbF9pbmRleChhZGV2LA0KICAgIDE1NiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByaW5nLT5od19w
cmlvKTsNCiAgICAxNTcNCiAgICAxNTggICAgICAgICAgICAgICAgIGF0b21pYzY0X3NldCgoYXRv
bWljNjRfdCAqKXJpbmctPndwdHJfY3B1X2FkZHIsDQogICAgMTU5ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgcmluZy0+d3B0ciA8PCAyKTsNCiAgICAxNjAgICAgICAgICAgICAgICAgICp3
cHRyX3NhdmVkID0gcmluZy0+d3B0ciA8PCAyOw0KICAgIDE2MSAgICAgICAgICAgICAgICAgaWYg
KCppc19xdWV1ZV91bm1hcCkgew0KICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5eXl5eXl5e
Xl5eXl5eXiBDaGVja2VkIGhlcmUNCg0KICAgIDE2MiAgICAgICAgICAgICAgICAgICAgICAgICBX
RE9PUkJFTEw2NChhZ2dyZWdhdGVkX2RiX2luZGV4LCByaW5nLT53cHRyIDw8IDIpOw0KICAgIDE2
MyAgICAgICAgICAgICAgICAgICAgICAgICBEUk1fREVCVUcoImNhbGxpbmcgV0RPT1JCRUxMNjQo
MHglMDh4LCAweCUwMTZsbHgpXG4iLA0KICAgIDE2NCAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgcmluZy0+ZG9vcmJlbGxfaW5kZXgsIHJpbmctPndwdHIgPDwgMik7DQog
ICAgMTY1ICAgICAgICAgICAgICAgICAgICAgICAgIFdET09SQkVMTDY0KHJpbmctPmRvb3JiZWxs
X2luZGV4LCByaW5nLT53cHRyIDw8IDIpOw0KICAgIDE2NiAgICAgICAgICAgICAgICAgfSBlbHNl
IHsNCiAgICAxNjcgICAgICAgICAgICAgICAgICAgICAgICAgRFJNX0RFQlVHKCJjYWxsaW5nIFdE
T09SQkVMTDY0KDB4JTA4eCwgMHglMDE2bGx4KVxuIiwNCiAgICAxNjggICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHJpbmctPmRvb3JiZWxsX2luZGV4LCByaW5nLT53cHRy
IDw8IDIpOw0KICAgIDE2OSAgICAgICAgICAgICAgICAgICAgICAgICBXRE9PUkJFTEw2NChyaW5n
LT5kb29yYmVsbF9pbmRleCwgcmluZy0+d3B0ciA8PCAyKTsNCiAgICAxNzANCi0tPiAxNzEgICAg
ICAgICAgICAgICAgICAgICAgICAgaWYgKCppc19xdWV1ZV91bm1hcCkNCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIF5eXl5eXl5eXl5eXl5eXiBUaGlzIGlzIGRlYWQgY29kZS4g
IFdlIGtub3cgaXQncyBmYWxzZS4NCg0KICAgIDE3MiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFdET09SQkVMTDY0KGFnZ3JlZ2F0ZWRfZGJfaW5kZXgsDQogICAgMTczICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmluZy0+d3B0ciA8PCAyKTsNCiAg
ICAxNzQgICAgICAgICAgICAgICAgIH0NCiAgICAxNzUgICAgICAgICB9IGVsc2Ugew0KICAgIDE3
NiAgICAgICAgICAgICAgICAgaWYgKHJpbmctPnVzZV9kb29yYmVsbCkgew0KICAgIDE3NyAgICAg
ICAgICAgICAgICAgICAgICAgICBEUk1fREVCVUcoIlVzaW5nIGRvb3JiZWxsIC0tICINCiAgICAx
NzggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJ3cHRyX29mZnMgPT0gMHglMDh4
ICINCg0KRml4ZXM6IDZkOWM3MTE3ODZlNiAoImRybS9hbWRncHU6IEFkZCBzZG1hIHY3XzAgaXAg
YmxvY2sgc3VwcG9ydCAodjcpIikNCkNjOiBMaWt1biBHYW8gPExpa3VuLkdhb0BhbWQuY29tPg0K
Q2M6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCkNjOiBDaHJpc3RpYW4g
S8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQpDYzogQWxleCBEZXVjaGVyIDxhbGV4
YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KUmVwb3J0ZWQtYnk6IERhbiBDYXJwZW50ZXIgPGRhbi5j
YXJwZW50ZXJAbGluYXJvLm9yZz4NClNpZ25lZC1vZmYtYnk6IFNyaW5pdmFzYW4gU2hhbm11Z2Ft
IDxzcmluaXZhc2FuLnNoYW5tdWdhbUBhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvc2RtYV92N18wLmMgfCA0IC0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNCBkZWxldGlv
bnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjdf
MC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92N18wLmMNCmluZGV4IDRhNTI1
MmUwODg4My4uYWIxZGVhNzdiZTZlIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvc2RtYV92N18wLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFf
djdfMC5jDQpAQCAtMTY3LDEwICsxNjcsNiBAQCBzdGF0aWMgdm9pZCBzZG1hX3Y3XzBfcmluZ19z
ZXRfd3B0cihzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpDQogICAgICAgICAgICAgICAgICAgICAg
ICBEUk1fREVCVUcoImNhbGxpbmcgV0RPT1JCRUxMNjQoMHglMDh4LCAweCUwMTZsbHgpXG4iLA0K
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJpbmctPmRvb3JiZWxsX2lu
ZGV4LCByaW5nLT53cHRyIDw8IDIpOw0KICAgICAgICAgICAgICAgICAgICAgICAgV0RPT1JCRUxM
NjQocmluZy0+ZG9vcmJlbGxfaW5kZXgsIHJpbmctPndwdHIgPDwgMik7DQotDQotICAgICAgICAg
ICAgICAgICAgICAgICBpZiAoKmlzX3F1ZXVlX3VubWFwKQ0KLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBXRE9PUkJFTEw2NChhZ2dyZWdhdGVkX2RiX2luZGV4LA0KLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByaW5nLT53cHRyIDw8IDIpOw0KICAgICAg
ICAgICAgICAgIH0NCiAgICAgICAgfSBlbHNlIHsNCiAgICAgICAgICAgICAgICBpZiAocmluZy0+
dXNlX2Rvb3JiZWxsKSB7DQotLQ0KMi4zNC4xDQoNCg==
