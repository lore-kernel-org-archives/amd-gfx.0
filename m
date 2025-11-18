Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA54CED240
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 03:25:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0868210E139;
	Tue, 18 Nov 2025 03:25:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KyiWd0Gg";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012008.outbound.protection.outlook.com
 [40.107.200.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 468CA10E139
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 03:25:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dLi3rGpvyMPRogmCcF2ojfnzlXwsa7n5/Xk8E3pHdFMJEMfkfYFPcE1cC4SesoKNVb81iYn0+gHXST0OQEXyooZc0qvELEIGSrhNX9hx3/iaM0g4U/S716c/JyaH0JcYuKmyPn/lA69K0ri8KB1GuSkiLXT5ig4pEocpvKumZaKEhegW1vPD4MxWODAjI2Pb2oPYWuf5sL8zi554zdcz+4KvN8F3nEaA7LPZroFvIi1SSLygwrtctbHDEw3EHg7a7MGVVvCa3Q+TymmioQucgs75K6AhdlvKinkgrCZzkHSm8GJhd0sFyJsgGsxUAXOHtRZhl7wD+vr1/o9mSf90Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JymLQi0/flfmBIUOQ8wrhIxPeY0MqU8bdok3MfgGJIk=;
 b=xSp624ljqw/1kQNQuvfvpNVg677Ta6nvCT9HFC8nTU+blu6kL4nbCaizzhqCTT5ai3B+SGdwPLY4z9mpJNX9aQQX+5mBTraqBNIQN6WKvc9/Q34N1Ql1iRbfhOoqiGsryon/bl65z6st5OpKTn9L0acKoSRH1Jp8ut3LIXI1YKNy3Hh5Ex2FEobOOKdqRcmExb2/gepPGbA25+SX4sOa13MhyjtPy8RjS1TMo36hFw9szu3c+2Qyx7OMJyDHiChpl6e4iTVg2Er8F9B/HS7uvQj888aVWEyGUWvpkqx8mO9n2KR0CHQIgd4SVx4irX3cejEvswzbSD7YQLoM354pyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JymLQi0/flfmBIUOQ8wrhIxPeY0MqU8bdok3MfgGJIk=;
 b=KyiWd0GgMWqtxNoShaRz8R53IO1jHMGstM0nRkklv9DzI+Q04X5Xp8Qk9TPY1brqzgk7FVipTLhmTpxbuNnE35MY19d8snpzQ4u7+CY8X4fZYwhJNOEOHW6w2Oj1Ep1VTpMouibb/h130jLl7P7Ln0YfyveH3ojiggW1Mx271P4=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by SA1PR12MB8966.namprd12.prod.outlook.com (2603:10b6:806:385::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 03:24:56 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%5]) with mapi id 15.20.9320.013; Tue, 18 Nov 2025
 03:24:56 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Prevent VA mapping for MMIO_REMAP domain
Thread-Topic: [PATCH] drm/amdgpu: Prevent VA mapping for MMIO_REMAP domain
Thread-Index: AQHcV6YH5FnaHF1zzU+74d708CJRyrT2nZGAgAEogyA=
Date: Tue, 18 Nov 2025 03:24:56 +0000
Message-ID: <DM4PR12MB51524E5A96C89B842C8F18AAE3D6A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20251117093856.857964-1-Jesse.Zhang@amd.com>
 <e8842a03-031f-40df-8b64-5d0222cfeb8e@amd.com>
In-Reply-To: <e8842a03-031f-40df-8b64-5d0222cfeb8e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-18T03:23:20.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|SA1PR12MB8966:EE_
x-ms-office365-filtering-correlation-id: c05af122-5f0f-4d81-a2ee-08de26520c15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?eDZtZlgxU2hreEpNTHl5b2lCQk1hMjBBdVpDMFcyVi9hTVdYVUdPa0xtVFBJ?=
 =?utf-8?B?RUFqREdyTjNsVk1mb3J3N3ZZcExpSm5mMWF2T2tIOXpGQnM5Ui9HNFczT0dZ?=
 =?utf-8?B?OUNaK3FOa0hPV2prV3dqamRoWmhmU1JVN1FvUUx5Qmp5RERscXBTb3YyYUFo?=
 =?utf-8?B?bjQ1a3A0Ylo5Q0xOeEhnd3lxMlVGa2Z3QVlvSytYOVpGQU1PN1RCVkovKzZH?=
 =?utf-8?B?R1dob3hIZkw2NFpPZ2VqamE4dnlPV0VNNGxXNmoweU9mTkhzc1E4c3c1ZUp2?=
 =?utf-8?B?ZGM4dlVNNjNaODRRSEpUb3gwaXhWLzZmQ0JqYUd5UWtuZUM1YUQyUWtkazRC?=
 =?utf-8?B?ME83cUxOVFJkeUdqWXpXZkYzM05NV051S1hTR1FhM2NrY0lRWUVQbGQ5Ry9Q?=
 =?utf-8?B?TTN1cDNzWW5tTHB0Y1RKaTdzM1ZxOWgxQTlUaVl0akFxQVN1ZXI3SWExNmJm?=
 =?utf-8?B?eHV3LzhENTJscDdyd25vaXBINmFuR05acmtHcDliaUNhaG9nakl6OHIrc0x4?=
 =?utf-8?B?RnFzTStLMWhpVWdZcnJJcVNpc1grU2swOW9neHArZlBxMzM4cS9GS05ZaDlZ?=
 =?utf-8?B?MDA0eDZHcWNPWEZCTU9NYjVERzdLTUNoL3NxaUYyNjRuYzhPWGVvYm1TSW5J?=
 =?utf-8?B?dEUvM0JGbXkyTHI5NGpqbGdDMjF4Rms1bFVHTS8vWi9pZmRLTkNadFYyaTRE?=
 =?utf-8?B?eVFkc3R5Z0tWSFpPWFA2MWlEcmVRMWVEazh4dXFROVBJR3p2U0dJd2VuMFNu?=
 =?utf-8?B?NjN1NzNPVjVRWFQxK3hEQkUvazRRWEs0dEdWd3lNM3ExVUF2dTJMTGZGVmFl?=
 =?utf-8?B?dm5tYURmMndMMTNRbXdjd3EwU2NraHZjUGhDWDJseWRmRWdyMFdJVkUrazQw?=
 =?utf-8?B?UWRJSllXTy9QWFBrNE1CZnZMNHhXY0pHcFJRNkJBd2F0bDlzS1V1Tkx4QmdT?=
 =?utf-8?B?bDZod2JpYkpvSXBvTUlxdkpKVTV0ZEFxdEFrWnVQNlZJTTI3dU1JL3hkZGN0?=
 =?utf-8?B?T0hLWDh2RStFVHdza2s0N25YNWNVQ2hOblErbUN5endnVjV4bkcwUEFNd0VG?=
 =?utf-8?B?QTVnRm5KUVg0YXJ4VWdxRUF6eTd2cFlvTUVOMXdIL0RYSzhYMHhyQ0FaL0t3?=
 =?utf-8?B?bk01Q0FBZlRhQXZrUVBBOTNvK0hldTJqdm8zOC9ZR1RJRHk3UXNZQ0x4OURM?=
 =?utf-8?B?M1NlblFHbFhaRHBDR0RUL0NYTU1SR21JbGhwMmV3QWFhemc3ZndKYzNVQmNk?=
 =?utf-8?B?TXdUemVLU3hVQU82bHRTeTlYaTJic2l4QWhSaUc5TURnZ0lLOHQxcDR3QzZR?=
 =?utf-8?B?U0RvK25Ud05XRHBVdExoVERobkd1ekVkY0EweFUyZXNQSGFoL3A3OUNDM2pl?=
 =?utf-8?B?VHJ0aHhFcDhmalpVR2hnWjZ1bE41S0J3a2E2N3U2MkZ2QkhDZXBPTXNZdGZn?=
 =?utf-8?B?dUMwWUlESjZYaEt3clhBSVhDOE9hK2wyZkl1dmVYQk1aR3ovWWVPcDFkaFFI?=
 =?utf-8?B?bzZFM0JBZEdJeXhLa1lsUytQbXhKQk9WejF5aGNUV205TUxNcUJHWHk4KzBw?=
 =?utf-8?B?QWthemFYbWNQb0k5TWtodWxmclVTdWxmRzdYREhHWGpNeGkyU2loMlRJU2hi?=
 =?utf-8?B?ZGE3VEJuMk9xVjM4b2RmZy9zL0FmSFVUbXQwVUlaVXZUdTJ1ZGgvNXlQcFZG?=
 =?utf-8?B?VllJVElVT1F5ci9xWmx0Rm1PZHhaRjVEaCtQUy9oNXYvY29MTldEdnVwTmlh?=
 =?utf-8?B?VlpKQ3I5K09WUGtTdFhvenl0aTNQZzBwYW1tQ05rUC9BTmx5Sk1HNmVxOWQr?=
 =?utf-8?B?TFpIdjZNRG8vbXNjTEFpYUQ5NTBmZlRkR0FsOWxPbFNGVkFIMys2dW1wREV5?=
 =?utf-8?B?TXdFZHlpWXlKY0VxcmZlUE5mWVkvSm8yZkNzZ0QzZXlVUjVzRFZsWjEyNnQ5?=
 =?utf-8?B?WEkvSG5qSEgyRWpEVGhJVG5wcjJEZWVqbjM3TStOVWd2Nmcwc1U5N3E5dDNl?=
 =?utf-8?B?ckY2czhkaDVldzhEcUFOdWlpL0dVb2tLYi9KYldSbTJRTEhhblZqSkg2MFgx?=
 =?utf-8?Q?HGrCcV?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlpLSEpRRTJoY2E0aXRsclB5OUJOQzY2S0pvc3NGWWhCeHJOQmMrZlFhWkZ4?=
 =?utf-8?B?T1VjRW0zV0JNRHkrQ2Noeit1bVR5N0Nra0N5SkhoRVN6QlRyTzRDSEM4aUpL?=
 =?utf-8?B?a2JSVDlFeUI0Y0pVZEJWc2dPQlFEeERLR204Nm9ZUm80L2w3YnRoN2hGcmxh?=
 =?utf-8?B?cEFab2pqdzZnelU4bGQwQ2pCRVpOWUhTWWpWSzJIeTVtUkhRVk5KY1BxK1Zk?=
 =?utf-8?B?ZjFXeWlFZ0RKRytFNThja1REdXlpMFdqc1ZpaVJmWEJYWk84N0RVREdCVlFE?=
 =?utf-8?B?bGdGNUJQT2RrOWQ4NnJDSEw2cUFpYXdSeFJRYjNMYVRyeXZmb0N3bjROM2E1?=
 =?utf-8?B?SHJmNHlXUGc0MDcyVEQ1TElENTh5cDIydXd6ck1kVmI4VVg0TW0xQXdxcGNx?=
 =?utf-8?B?cGoyR2VIWmNmUm9DQkRSNWVnejk2b1lKQUJKeTJxbDh2akY4dGF5YXI1cW9t?=
 =?utf-8?B?VkthLzhSamFhaTF6YnZVTXgwVlNLYUlRSFVUUTNPaUQvTlpHR3dibktqOGVw?=
 =?utf-8?B?dW1DVVVUdVB4UHNORHZsRGVEMkFyQXB5VHVRdFhnNmJ3UEJ2MkJtZDJTNTFw?=
 =?utf-8?B?RTNqdTZ6L0xmR3BCRVR0Qm5PcndZQXpMRCtVN1pUNGdjcnFjdVNWNFJzcXVi?=
 =?utf-8?B?Q2lYTTRQUTV5alNvTk52eWNtN2MyeHpFb0NwdjJoNHVWU3lXam1wb3RNUnFC?=
 =?utf-8?B?TkN4YXBYbFc1S0xDY2tzUnRZbDlmR2Jkd3AxL1M5SGl4M3JFTmlLTjJMRk1x?=
 =?utf-8?B?NnAzOThpUVdSVzhTUU9RL3VpcEd5M2dnRnFrQ2JSblBRaUtjM05DV1gxYXY4?=
 =?utf-8?B?alg5RVdNbWViQVpFSmJPUzE0SFBCNG8xc2NkV0JBZHVwa3N5SGpMQ29kQXlT?=
 =?utf-8?B?VnN1UDdPQTd2cWwvdTdTaFdyQzE2NUJVRDFwVEtSZVlOY2NjMjdoVnFmRU43?=
 =?utf-8?B?YVZLNllmYUY1bHN1ZVBwMGYvbGYvZFZEcUlCRWJpcmJyTDZjTDRVNkdDN1Fl?=
 =?utf-8?B?aXpxNU93NmhIRk9WMThhSkEzOEJyb3lHN1doS0dLZSs2Vy9iOUNYaXpWSWtG?=
 =?utf-8?B?UHJlcmljaENuQkhiVW1ZVlBPN0c3clVmTGJpbEljaHhlaFQxVVpWc1oySFNU?=
 =?utf-8?B?RFlnUEIwMW05dFZsWjl0Y0dVRUVkTE4xMnhseVMySHdNa203SjNKZW11WXRV?=
 =?utf-8?B?NlRjRU9QZEVXN2pGaDJGWUdBbFVIdXA0MzUzQmZmaTFYQ3ROMnVaMSswZXlz?=
 =?utf-8?B?WGV4YVZvbDBMdTlDaVZoTmZyOURXVVBrZWhLRVFXVWgveTBiWWkwYnpta0kr?=
 =?utf-8?B?S2dnMk1RTFFyWkc3QlJ4RnVud3pmd1VDMU5sMXlKeXlZRytjNDNHNEhoVTc3?=
 =?utf-8?B?K2poU2U3VzlvekNQMkpFZ1ZLcFBXaFk2c3kzY2djbCtpVklsY0pmbUJVWHR2?=
 =?utf-8?B?QXM0bURNY1h0RkhnUFpOU29hSmpmaW9ucHBGanUvWWc5ejVSbmFqZTVuTWh1?=
 =?utf-8?B?TDMzVGNHWlZTUWxTdHcvNkJ2VUx4RGZqcVh2dUpIRjVmbStPTldqZ1YvWDRD?=
 =?utf-8?B?TmNaZU9xQ3BvUytLQTVDOFpwbEcycTJydm5OakZKcXpudnQrOW9XWGxmdzgy?=
 =?utf-8?B?Z3I1ampsc0RqMzBpZWJWWkkxakxuMFVoc1ROWjkrRkJ3REkzQ1g0ekgxYTcw?=
 =?utf-8?B?eGNlczNERmh2SDFvRDdaYWJZQksrMnpMd0NvV3M2Wk5zZUtjU3hTTVJGV3Rw?=
 =?utf-8?B?cHVwT3oyNk1hKzRTUWdScS9zbE9uay9NbS9mV3hSSytWNGYwSDcrV2kxUjBF?=
 =?utf-8?B?dVpDY0o3THlEV0ltS0hRUHFWd1ZKMUlPSzhTbTRqSFcxbjJvcFlxV1VPWHpl?=
 =?utf-8?B?eWFPaXF1NzdUcFo4YkNHZjVBd1Z1aWdLRC9rY05UbjhmYXFsNndVYkI0bURS?=
 =?utf-8?B?a01QSjd1cmhKc1dHS1pibmovMGxhaFh6bmZNbjk0NTJUWTFHQWFMcXpBaXRY?=
 =?utf-8?B?SzY1TGN4UFBZcVl5cVJuYWZCMll4cU0wV2d6ZnZCcXJJckdhTFEvZGlaSWJX?=
 =?utf-8?B?ZDB1Uy9rS0pVaVlNRzArMGJ0bWRWbDNSNld3ZjRrbGwxMThRTGZnRGpSbHk1?=
 =?utf-8?Q?O1H8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c05af122-5f0f-4d81-a2ee-08de26520c15
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 03:24:56.4828 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QdCHKRxDW/aLDgPwN0SVuMrGk+zPzC4wYBxKO59B+KfNpDLjRsdfcX+vJzi1G1Oiq8vRaFceulzi+P/s+SN1YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8966
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
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLb2VuaWcsIENocmlzdGlh
biA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTZW50OiBNb25kYXksIE5vdmVtYmVyIDE3
LCAyMDI1IDU6NDIgUE0NCj4gVG86IFpoYW5nLCBKZXNzZShKaWUpIDxKZXNzZS5aaGFuZ0BhbWQu
Y29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IERldWNoZXIsIEFsZXhh
bmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0g
ZHJtL2FtZGdwdTogUHJldmVudCBWQSBtYXBwaW5nIGZvciBNTUlPX1JFTUFQIGRvbWFpbg0KPg0K
Pg0KPg0KPiBPbiAxMS8xNy8yNSAxMDozOCwgSmVzc2UuWmhhbmcgd3JvdGU6DQo+ID4gIEFkZCB2
YWxpZGF0aW9uIGluIGFtZGdwdV9nZW1fdmFfaW9jdGwgdG8gcmVqZWN0IFZBIG1hcHBpbmcgb3Bl
cmF0aW9ucw0KPiA+IGZvciBidWZmZXJzIGFsbG9jYXRlZCB3aXRoIEFNREdQVV9HRU1fRE9NQUlO
X01NSU9fUkVNQVAgZG9tYWluLg0KPiA+DQo+ID4gVGhpcyBmaXhlcyBhIGtlcm5lbCBOVUxMIHBv
aW50ZXIgZGVyZWZlcmVuY2UgdGhhdCBvY2N1cnMgd2hlbg0KPiA+IHVzZXItc3BhY2UgYXR0ZW1w
dHMgdG8gY3JlYXRlIFZBIG1hcHBpbmdzIGZvciBNTUlPX1JFTUFQIGJ1ZmZlcnMuDQo+ID4gVGhl
IE1NSU9fUkVNQVAgZG9tYWluIGxhY2tzIHByb3BlciBzY2F0dGVyLWdhdGhlciB0YWJsZSBzZXR1
cCByZXF1aXJlZA0KPiA+IGZvciBWQSBvcGVyYXRpb25zLCBjYXVzaW5nIHRoZSBrZXJuZWwgdG8g
Y3Jhc2ggd2hlbiBhY2Nlc3NpbmcNCj4gPiB0dG0tPnNnLT5zZ2wgaW4gYW1kZ3B1X3R0bV90dF9w
ZGVfZmxhZ3MuDQo+ID4NCj4gPiBUaGUgY3Jhc2ggbWFuaWZlc3RzIGFzOg0KPiA+DQo+ID4gWyAg
MjI4LjE4ODUyN10gYW1kZ3B1X2dlbV9jcmVhdGVfaW9jdGxbNTEzXSBhbGxvY2F0aW9uIG1taW8g
ZG9tYWluDQo+ID4gIyMjIyMjIyMjIyMgWyAgMjI4LjE4ODUzN10gQlVHOiBrZXJuZWwgTlVMTCBw
b2ludGVyIGRlcmVmZXJlbmNlLA0KPiA+IGFkZHJlc3M6IDAwMDAwMDAwMDAwMDAwMzAgWyAgMjI4
LjE4ODU0MV0gI1BGOiBzdXBlcnZpc29yIHJlYWQgYWNjZXNzDQo+ID4gaW4ga2VybmVsIG1vZGUg
WyAgMjI4LjE4ODU0M10gI1BGOiBlcnJvcl9jb2RlKDB4MDAwMCkgLSBub3QtcHJlc2VudA0KPiA+
IHBhZ2UgWyAgMjI4LjE4ODU0Nl0gT29wczogT29wczogMDAwMCBbIzFdIFNNUCBOT1BUSSBbICAy
MjguMTg4NTU2XQ0KPiA+IFJJUDogMDAxMDphbWRncHVfdHRtX3R0X3BkZV9mbGFncysweDJiLzB4
NjAgW2FtZGdwdV0gWyAgMjI4LjE4ODY3M10NCj4gPiBSU1A6IDAwMTg6ZmZmZjk4NmYwNDU2Mzk5
OCBFRkxBR1M6IDAwMDEwMjQ2IFsgIDIyOC4xODg2ODZdIENhbGwgVHJhY2U6DQo+ID4gWyAgMjI4
LjE4ODY5MV0gIGFtZGdwdV90dG1fdHRfcHRlX2ZsYWdzKzB4MjEvMHg1MCBbYW1kZ3B1XSBbDQo+
ID4gMjI4LjE4ODc4M10gIGFtZGdwdV92bV9ib191cGRhdGUrMHgxMDUvMHg3MTAgW2FtZGdwdV0g
WyAgMjI4LjE4ODg4N10NCj4gPiBhbWRncHVfZ2VtX3ZhX2lvY3RsKzB4NzdmLzB4ODAwIFthbWRn
cHVdDQo+ID4NCj4gPiBUaGUgY3Jhc2ggb2NjdXJzIGJlY2F1c2UgdGhlIGluc3RydWN0aW9uIGF0
DQo+ID4gYW1kZ3B1X3R0bV90dF9wZGVfZmxhZ3MrMHgyYiAgYXR0ZW1wdHMgdG8gcmVhZCBmcm9t
IG9mZnNldCAweDMwIG9mIGEgTlVMTA0KPiBwb2ludGVyIChyZGk9MHgwMDAwMDAwMDAwMDAwMDAw
KS4NCj4gPg0KPiA+IEJ5IGV4cGxpY2l0bHkgcmVqZWN0aW5nIFZBIG1hcHBpbmcgZm9yIE1NSU9f
UkVNQVAgZG9tYWluIGF0IHRoZSBpb2N0bA0KPiA+IGVudHJ5IHBvaW50LCB3ZSBwcmV2ZW50IHRo
ZSBjcmFzaCBhbmQgcHJvdmlkZSBjbGVhciBmZWVkYmFjayB0bw0KPiA+IHVzZXItc3BhY2UgdGhh
dCB0aGlzIG1lbW9yeSBkb21haW4gaXMgbm90IHN1cHBvcnRlZCBmb3IgVkEgb3BlcmF0aW9ucy4N
Cj4NCj4gT2ggdGhhdCBpcyB0cmlja3ksIHllYWguIFRoZSBkb21haW4gKmlzKiBzdXBwb3J0ZWQg
Zm9yIFZBIG9wZXJhdGlvbnMsIGJ1dCBub3QgZnJvbQ0KPiB0aGUgR1BVIHdobyBvd25zIGl0Lg0K
Pg0KPiBTbyB0aGF0IGNoYW5nZSBoZXJlIGlzIGNsZWFybHkgdGhlIHdyb25nIGFwcHJvYWNoIHRv
IGZpeGluZyBpdC4NCj4NCj4gTmVlZCB0byB0aGluayBhbmQgZGlzY3VzcyB3aXRoIEFsZXgvU3Jp
bmkgYWJvdXQgaG93IHRvIGZpeCB0aGF0Lg0KW1poYW5nLCBKZXNzZShKaWUpXSAgVGhhbmtzIENo
cmlzdGlhbiwgIFNyaW5pIHNoYXJlZCBhIGZpeGVkIHBhdGNoIOKAnGRybS9hbWRncHUvdHRtOiBG
aXggY3Jhc2ggd2hlbiBoYW5kbGluZyBNTUlPX1JFTUFQIGluIFBERSBmbGFnc+KAnQ0KDQpUaGFu
a3MNCkplc3NlDQoNCj4NCj4gVGhhbmtzLA0KPiBDaHJpc3RpYW4uDQo+DQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBKZXNzZSBaaGFuZyA8amVzc2UuemhhbmdAYW1kLmNvbT4NCj4gPiAtLS0NCj4g
PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jIHwgMTQgKysrKysrKysr
KysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMNCj4gPiBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYw0KPiA+IGluZGV4IDEwZTIx
ZDJkOWI1Mi4uMWIwOWQ2YjlhZjU4IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9nZW0uYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9nZW0uYw0KPiA+IEBAIC04NjcsNiArODY3LDIwIEBAIGludCBhbWRncHVfZ2Vt
X3ZhX2lvY3RsKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHZvaWQNCj4gKmRhdGEsDQo+ID4gICAg
IHVpbnQ2NF90IHZtX3NpemU7DQo+ID4gICAgIGludCByID0gMDsNCj4gPg0KPiA+ICsgICAvKiBD
aGVjayBmb3IgaW52YWxpZCBtZW1vcnkgZG9tYWlucyAqLw0KPiA+ICsgICBpZiAoYXJncy0+b3Bl
cmF0aW9uICE9IEFNREdQVV9WQV9PUF9DTEVBUiAmJg0KPiA+ICsgICAgICAgIShhcmdzLT5mbGFn
cyAmIEFNREdQVV9WTV9QQUdFX1BSVCkpIHsNCj4gPiArICAgICAgICAgICBnb2JqID0gZHJtX2dl
bV9vYmplY3RfbG9va3VwKGZpbHAsIGFyZ3MtPmhhbmRsZSk7DQo+ID4gKyAgICAgICAgICAgaWYg
KGdvYmogPT0gTlVMTCkNCj4gPiArICAgICAgICAgICAgICAgICAgIHJldHVybiAtRU5PRU5UOw0K
PiA+ICsgICAgICAgICAgIGFibyA9IGdlbV90b19hbWRncHVfYm8oZ29iaik7DQo+ID4gKyAgICAg
ICAgICAgaWYgKGFibyAmJiAoYWJvLT5wcmVmZXJyZWRfZG9tYWlucyAmDQo+IEFNREdQVV9HRU1f
RE9NQUlOX01NSU9fUkVNQVApKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICBkcm1fZ2VtX29i
amVjdF9wdXQoZ29iaik7DQo+ID4gKyAgICAgICAgICAgICAgICAgICBkZXZfaW5mbyhhZGV2LT5k
ZXYsICJNTUlPX1JFTUFQIGRvbWFpbiBub3Qgc3VwcG9ydGVkDQo+IGZvciBWQSBtYXBwaW5nXG4i
KTsNCj4gPiArICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+ICsgICAgICAg
ICAgIH0NCj4gPiArICAgfQ0KPiA+ICsNCj4gPiAgICAgaWYgKGFyZ3MtPnZhX2FkZHJlc3MgPCBB
TURHUFVfVkFfUkVTRVJWRURfQk9UVE9NKSB7DQo+ID4gICAgICAgICAgICAgZGV2X2RiZyhkZXYt
PmRldiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICJ2YV9hZGRyZXNzIDB4JWxseCBpcyBpbiBy
ZXNlcnZlZCBhcmVhIDB4JWxseFxuIiwNCg0K
