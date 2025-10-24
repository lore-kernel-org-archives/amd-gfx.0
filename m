Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E019CCD1BF
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Oct 2025 17:28:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D53910EB2D;
	Fri, 24 Oct 2025 17:28:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zkFeGyjp";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010024.outbound.protection.outlook.com [52.101.56.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 561E310EB2D
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 17:28:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YlRa7pMxPy314gPNSjic41fo+VybaO9mxAErN+4x5DkPzmLDjv8uaSAGr0tkbSYN5tTtemIdx4gsJQtr3JHYaXOI/XzI8H5zEKOI2Agornp28ANNR2XdLdppG7ISRZmXhGkWmt4UvOcZAGoX0OQGtGCRWASOpHWykflxXAkcnJZDIh7KO8Y8da5vx8WHtpfumB4VvK60Z5+NDtyWKU3JFNgFbcxqICKfOTp2LPiQg0Q4il99IiiSR54knANKaSyxASu+BtGaUnOCGl8ahXusyc3UucRIHIbTS3ryaxAglve2BLFlw2W/zra39KnYKf8Qgpqq2ErPuLnT51LayDN26g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCB4QDl0bY6CaW/73KWZ2DGNErmvtvFRgfditN5BoiA=;
 b=dgTxZ/gA5vWredo3M7DL1HqkRyaym/J3ncdEyfePc6tbgCJoM00cb++RIiDn2wFvAu0nACXq5/bE5Ld1vxQTit17W2Y2ttF29TCKjAu6QDzRA7cowqBzds+fmqQhJu99UlVeHBOftNC/QIcToWgO8MvKxSP5H8Ngf1tQJt/P1TNLE0HEmeDThOjPtcC5dED0O25AdDaNgdjw6A/3bNHXPmJ1rv3orCk8YD5djFXXZyxGm6/DinPVXcGWNtVOdvemps8JPVCKubVBPTmXqypuCCj5uhJny2gKYbY5D45Gi37rBPRN1et/Uju3e5an66/hh+mtYwH9n+v9tVEiLTNmEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCB4QDl0bY6CaW/73KWZ2DGNErmvtvFRgfditN5BoiA=;
 b=zkFeGyjpYkmqDVJDcwEGgJJBZzglb0uAVCDm8d4zd5/n0raz1nNj5EuvKSAkjNrIDD0GRnPe6cLaCX9U2ZF2cgWah2GDkh+CN5Sgq2+snthOJd914M3a56ZEuFvMORDXt4k2lQEjRTG4Vzav7PeGR3g3zmdKw3ClCHHiQm9GdKQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DS2PR12MB9688.namprd12.prod.outlook.com (2603:10b6:8:27d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 17:28:39 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 17:28:39 +0000
Content-Type: multipart/alternative;
 boundary="------------wSC5RBR0qFGTrHwTdIbd1ky0"
Message-ID: <93be4434-feec-454c-99a9-fdb7e3465a8f@amd.com>
Date: Fri, 24 Oct 2025 22:58:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2] drm/amdkfd: add missing return value check for range
To: "Kuehling, Felix" <felix.kuehling@amd.com>, Philip Yang <yangp@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Shirish.S@amd.com
References: <20251024111602.2128436-1-sunil.khatri@amd.com>
 <9e35463a-777e-4b6b-ad31-47cd7f07fe30@amd.com>
 <859ab89b-833d-fbf6-bc5e-1c4786b4a2c6@amd.com>
 <84127e94-064b-41cf-9be9-ef4aa32fbf10@amd.com>
 <9b697481-8530-4cf0-8f44-fc5f23b542a9@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <9b697481-8530-4cf0-8f44-fc5f23b542a9@amd.com>
X-ClientProxiedBy: MA0PR01CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::10) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DS2PR12MB9688:EE_
X-MS-Office365-Filtering-Correlation-Id: bfedd4f1-e310-4a3b-8efe-08de1322c510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|921020|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bUFGa1J0NVRIY2dzTmthR2MydG1QRjlWcXJ5SSs4OGYxMHkxRCtGRWVMUXJC?=
 =?utf-8?B?R3l1VHgrVndUazRDUnNtWHprT0NZU0orTGQzdms3eUNGelR4UW13N3Fuc3dn?=
 =?utf-8?B?dnBFNUJ1SEpRenZZbm5neGxNaHE1eTcrc1NyTlJ4eEVsbmlQOHJYSko2bWJa?=
 =?utf-8?B?SG1hbGlJVFlkVkRUVEtuVGRWUkNFS0ZabXFtNkJTdWRTbmxsdXlXSDlpV2tp?=
 =?utf-8?B?S09SaVFHUE9yQ3lOUHNod21vUlJVNXZ2K2Q0bGJYS3hGT0hoS1FFNll0djht?=
 =?utf-8?B?UVBtVlpQVDBSSnd5Z3hZMlkxaXVzOEI4M3dtRmt3Q3p1eVRhSW1ZTk5Nc1lU?=
 =?utf-8?B?UWlIQjJOVTJFYmRsaFhscit3WWxFd2Y4MitQT3I4clBJckVnV1VPekZEbG56?=
 =?utf-8?B?SUtpZlFFelZERVcyQ1BYQ3hwcDNSZU03WGFHeEUrem0vOEpQUERwMmExL2Qx?=
 =?utf-8?B?SElmNXRLOVJBWi8xcU9rUUF3THNYRDVING1mYVJLRzVyTlVEcEZtVDVmS2dt?=
 =?utf-8?B?cVJ2T3ViYTZPc0VuWEw0NC9UUVBhVjJrVTNHRFVpNXVpSDVBK0xnQTJrWnhY?=
 =?utf-8?B?VmVIckx0VWREN3orTzVqWEdGeVAwR0o5aWtIQzdFOXcyckxoQ2RHUFEwdG1J?=
 =?utf-8?B?bkRobjJUaGk5Wkd2anR4WHBFYlA3T0JBdXV5UGpHaUdqdXVrMU9TOThVT2U3?=
 =?utf-8?B?S1MrYlhXR2hLQk9VNGpvakczREhCaURJZVhXTUxZSDFJb0RrOTNYaXgyT3Fp?=
 =?utf-8?B?MjVTNXpiR3JNR3RFcXZhc1pmVEJhQUkxcTVpM2tadjR5cUtBOVd6QWcyWVE1?=
 =?utf-8?B?c0RoWncrSWNwYjhKWFpPVWsxMnJEZDM0RS84bExTVVY2aWpSTW11c0Y1Y3Jn?=
 =?utf-8?B?UVdNblczb2hrVkZGUXZ6Nmk0cFNaTGJ1RTlIbDN1QXNJOTBCdUo3dXhyTTRi?=
 =?utf-8?B?azdidndJL2JTQlpxdlVSa240clVESFNRK1JzRzRuckFsQ1JHNGEzbTAzRHJa?=
 =?utf-8?B?ZThtaklBQXVBQVBGRWU3aTl5MEIzYmc3SXlFVGxLckJzR0JJU2Y1VzJLS2Qx?=
 =?utf-8?B?QVMwbXdSd0pFMzFNVUFwOFdSZ1dnL2M3RzJ2elRmMW8vd2J3ZDlDUUp0Qm5V?=
 =?utf-8?B?ZVZBSXd0Y3BCZVk0T3BXYTJma2lVTVVudktDb1REQmhIK1kwNHFJQks1YnhB?=
 =?utf-8?B?TGlaNHNHeFVoMm0rQ21kRWQwYU5jWXNRMXUvVGpLdG1Cb3NTcHVya0pnb05D?=
 =?utf-8?B?dGhackFwVkx0SjBKeU9JUytkY1pZT1BhSU44U1k5eldVQkM0S3hMZWpobVY1?=
 =?utf-8?B?ZUU3TUhYNGdXcFgvM2ZjdkEzREZUQ0IzbDdkMTVNeWVJQ0R1Q2ZNMis0ODFW?=
 =?utf-8?B?eXJ5NVlKRmQxeFpzZGJXSEdsV0s5L2o1RjQ0aCtlUXNaZXYrMDFWVXZrUlI1?=
 =?utf-8?B?eTc5S1kyOG1PYVpYZCt4bTVFT0IzaGxJeUdNTFEyRlNIaVVJMVVoS1BUSGVD?=
 =?utf-8?B?YTA2Nlp5UFl2R216OU1UYzAxcEdFUHVqSTBpZkQwY0lTSjAyRWFTdi84ZEhM?=
 =?utf-8?B?dlY5NXg3N0VERUo0UWJ4dnc2TnhxQlVUVEtJK2hQZ1NuakJ1U2NuK04zMEZW?=
 =?utf-8?B?cUh0UFNlWE40cDN5ci9Cc0VBajFUbm4ydzlaTVkzSGtUZ2xsSmc4ZG9raFNO?=
 =?utf-8?B?R01Cc0hDS1k1dFUwTXRCUWQxZHcvYWIrU0ZLTlFxOEQ5cmcvZGEyd0lQYTJi?=
 =?utf-8?B?Q0pUVnM4eVlQcEpvdkxUSWtOaVhSSzdyY1RlK3dORC9tNk5lSXRNOWJlUDEw?=
 =?utf-8?B?Uko3bHo5dmJidC9adkQrSlJpR2ZYYytFaDFoZFRXeHBkaW5nQXpQbnUyV0tJ?=
 =?utf-8?B?aU5DN09GcGVaOWxVaGdBL0JJWHQwUTZhMjRKWFFJdlJDdGJUQzZPNFN0a1cr?=
 =?utf-8?B?bDc4M0J4TmJRUDQwamU0QTRrSDZKaENyQXd3NFgxcVlaYkdFMy9pcjREbTdN?=
 =?utf-8?B?ZTBIZXMxMzBzYnhEVHpWYUNsOG5IeHIyNXI2R2o0QXR2R1VwU20vSWQvdlBz?=
 =?utf-8?Q?iBmJpM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(921020)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkVEajZuL2xsdnVQeUdsenU1S3ZXdEtja212WHlvbytTN3hXK0xFRHVRTDM4?=
 =?utf-8?B?Wml5SWQ4OCtScCtpK05Ha2paUGs0aklwcGY4Nzc2QWI2anZ1L2FkR3YwcDVL?=
 =?utf-8?B?TTIyT0d1Uk01R2RnSjdrd2pXVFQybDlPMkY5V01HRkJsZjhZaU0zMVk1MENH?=
 =?utf-8?B?M0hrYkhVYzBjZlVIc0tyTTAvUzI5cFduNnhyZlF4allHMHpNbzE5SnFEYStk?=
 =?utf-8?B?SERRQTJKY3NlRVRVL1Z0RTlSUlZwcFBMRTZ3andDMERQTEQxanA4TWZpVW5u?=
 =?utf-8?B?N285MVhoTS9vdVVDQXVwdnB0MVExenhaN0xtMWxwcVJIZWZ6OVN2ZlRXZnZW?=
 =?utf-8?B?bittOFdCK0l3MTNFVE5DNHpSZ1FqRllvZk40R1Z3OUFOZUtDd1lydFEwQm5z?=
 =?utf-8?B?azZlR2RkR2lGeDEwV0luaUx1Ni9Xa040MC9jTVJrTFQvQWhMbmxVUkVYRjhB?=
 =?utf-8?B?U2tRcUtiRUNWNDNXNUNyREp5U2U4WXFpRUJlVWI4T29pUS9rdExPSEJxZlJI?=
 =?utf-8?B?VEswcThoclBkT3lMajVPZkdEdVRicmRLVzhsdmpXZTlnOFNZbEdoSUhqd2Jw?=
 =?utf-8?B?SDFGMzRUSW8vbk5KYnlXU3N6cFFPdlFtUXcyRXBrUGlCY3ZQTVFxTTJ3R2xQ?=
 =?utf-8?B?ZWs4dHVDSUYyWGx6ejFYVmM0cXpRbzBXZk1TTnc0bnRwT09ZSVJjT0Q5d2N1?=
 =?utf-8?B?ajFnbVFQMEJHdkhBNC9lTm5Lak40TEt1OTFFbGRFVEdKT0xuOTRrQkZaUFB0?=
 =?utf-8?B?TVNQR28wRDFaM1JKdjVLUkN0TnBHb2RIaElnbGUvdC8vRkF5dUlvSTcxVkcv?=
 =?utf-8?B?NnovZDZBaWJidm5wdEVIUnVjTTlnMDRDSTZVQTRSQXExbldGZ2ZFUjVvaUpt?=
 =?utf-8?B?bkFab1VoazVFRHNtQjZ0S0VuS04wYVJlZDBIZno5VVF0WWRrd0J4aWxOek0x?=
 =?utf-8?B?WEJKT3RvdVFXUCtWUDlTQ2JTeTgrWnR0TFNjc2psNDM1RmhuSEN2RmNxbFJr?=
 =?utf-8?B?NmxxSUs3Sm9kUmNDeFJjZjl3aVBDWjBON2xzSjAzei85am9lTU9JTUJGMnc5?=
 =?utf-8?B?ajNyVXhMamY2YTFURi9oNURDYk13Y3JzMFFnbEFXa3VtbkpkZy80UGIrZkJ2?=
 =?utf-8?B?N2ZIUlBQdis0S2RCOGhKQTdtaVhRcktaWlFraHRHbWdQRXpxb0tSNElJU2Vw?=
 =?utf-8?B?NG9pM1JteGFMWDBPQTZiZkg5am5sbzFGS054WHZSTzdwNENOdDA5dlV3YStu?=
 =?utf-8?B?Sjd4OGdVZVdUSnlXQWI1b3F2ZHlpRHBONExtVjJPYU5QT1JLY1p2T1QxN1Bu?=
 =?utf-8?B?L1pEZGdKTDJpZlNZTEZHR2NvS21lbGtFdDFWT0ZNYWwzSDEvc2pBeThGQTNQ?=
 =?utf-8?B?UGxuckd3cmxadjAwYUdUMXEyeUZlMGd3a1VCSWdrOFI2YWJ5QlY0Wi9RSE9W?=
 =?utf-8?B?aDVJRHBzK2NhdHFaekdzK21TVzl2VlQ0eXgrNTdmOUxrNHBTUjN2eUwzT3Iz?=
 =?utf-8?B?dUdSUVVCRlhmOU9TSnlvUjJuZ0VBV0ZuQ0N2TXMrTEc3M3p4RUVRZFJRcmFw?=
 =?utf-8?B?U2RsVFdSTm5uMGtxZTZCMzZjZllFdWxEZUNNVFd5Y3hRN1dtekFhQUE5S2NR?=
 =?utf-8?B?VGp1b0NiS1FQMXdwbTU2UXRmUkFvUDBEMWp0Ym1yeCtsUWJtWFRqZTJOZS9m?=
 =?utf-8?B?OXFNOGh3SWNzWTlScmRUSGpWNWdxSUtQa2NETVFWMHZpTlZhQU9NMktkSDlJ?=
 =?utf-8?B?KzF0VXlzbGw1R0NwcDFvZjdmbE1TTWFzSE82bVpsTXFOSExzelBYeklydlc5?=
 =?utf-8?B?c2RheFlFb0NNeEdYUzA1UFNydHhVMlgvejZNL0lkNWRRN1d1eS8ybjdNdTJl?=
 =?utf-8?B?VHB5Q2FaNXZmR0dzKzJ0UlArbS85cTRCVkhMYmtkazJPT25YWDJUcWxqbGk5?=
 =?utf-8?B?ajZZRmpHdFFUak10d2xGbStTdGxjOVVIbzhGd09SK2tuanlVVXcvTnlzMXYz?=
 =?utf-8?B?L2F3TUpkZSsybWpPVzN5NFRPMWozVzJpMkp1UmVzRTFWUld6VDJnNEYvd3dj?=
 =?utf-8?B?Y1g3WXZpVXVvMGxiZU5mZUNRRUhoZ2dCNk9VNFBlNW4vRlBud1hiaXN6TWlQ?=
 =?utf-8?Q?BZXCCYvHeQzjeKRkMfugYq96d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfedd4f1-e310-4a3b-8efe-08de1322c510
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 17:28:39.2577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4XhsvRwDRoN8ouYg2ZG5UK5ls0Ke+Zsu00aH5b69w+fUwHCTZkXPhKo0kl0vePhGH4j0kJHj78kWSYfhs2xvRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9688
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

--------------wSC5RBR0qFGTrHwTdIbd1ky0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 24-10-2025 10:43 pm, Kuehling, Felix wrote:
>
>
> On 2025-10-24 12:55, Khatri, Sunil wrote:
>>
>> On 24-10-2025 08:41 pm, Philip Yang wrote:
>>>
>>> On 2025-10-24 07:45, Khatri, Sunil wrote:
>>>> +shirish
>>>>
>>>> On 24-10-2025 04:46 pm, Sunil Khatri wrote:
>>>>> amdgpu_hmm_range_alloc could fails in case of low
>>>>> memory condition and hence we should have a check
>>>>> for the return value.
>>>>>
>>>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 +++++
>>>>>   1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>> index f041643308ca..7f0ab73e2396 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>> @@ -1738,6 +1738,11 @@ static int 
>>>>> svm_range_validate_and_map(struct mm_struct *mm,
>>>>>                 WRITE_ONCE(p->svms.faulting_task, current);
>>>>>               range = amdgpu_hmm_range_alloc(NULL);
>>>>> +            if (unlikely(!range)) {
>>>>> +                r = -ENOMEM;
>>>>> +                goto free_ctx;
>>>
>>> Can not goto end from here,  this skips the svm_range_unreserve_bos. 
>>> Just set r = -ENOMEM, and the loop will exit and cleanup accordingly.
>>
>> That patch has already been merged now and i have to send another 
>> patch for review. While at it, cannot just set ENOMEM and leave as it 
>> will crash in next step where it access range which is NULL.
>>
>> This is what i am thinking
>> range = amdgpu_hmm_range_alloc(NULL);
>> if (unlikely(!range)) {
>>                 r = -ENOMEM;
>>                 svm_range_unreserve_bos(ctx);
>>                 goto free_ctx;
>> }
>>
>> If that is fine i will send a new patch for this ?
>
> I'd recommend
>
> 	if (unlikely(!range)) {
> 		r = -ENOMEM;
> 		break;
> 	}
Yup, this would work too and is a better approach. Sent the new patch 
"[Patch v2] drm/amdkfd: fix the clean up when amdgpu_hmm_range_alloc fails"

Regards
Sunil khatri

> Regards,
>   Felix
>
>
>>
>> Regards
>> Sunil Khatri
>>
>>>
>>> Regards,
>>>
>>> Philip
>>>
>>>>> +            }
>>>>> +
>>>>>               r = amdgpu_hmm_range_get_pages(&prange->notifier, 
>>>>> addr, npages,
>>>>>                                  readonly, owner,
>>>>>                                  range);
--------------wSC5RBR0qFGTrHwTdIbd1ky0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 24-10-2025 10:43 pm, Kuehling, Felix
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:9b697481-8530-4cf0-8f44-fc5f23b542a9@amd.com">
      
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 2025-10-24 12:55, Khatri, Sunil
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:84127e94-064b-41cf-9be9-ef4aa32fbf10@amd.com"> <br>
        On 24-10-2025 08:41 pm, Philip Yang wrote: <br>
        <blockquote type="cite"> <br>
          On 2025-10-24 07:45, Khatri, Sunil wrote: <br>
          <blockquote type="cite">+shirish <br>
            <br>
            On 24-10-2025 04:46 pm, Sunil Khatri wrote: <br>
            <blockquote type="cite">amdgpu_hmm_range_alloc could fails
              in case of low <br>
              memory condition and hence we should have a check <br>
              for the return value. <br>
              <br>
              Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com" moz-do-not-send="true">&lt;sunil.khatri@amd.com&gt;</a>
              <br>
              --- <br>
              &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 +++++ <br>
              &nbsp; 1 file changed, 5 insertions(+) <br>
              <br>
              diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
              b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c <br>
              index f041643308ca..7f0ab73e2396 100644 <br>
              --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c <br>
              +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c <br>
              @@ -1738,6 +1738,11 @@ static int
              svm_range_validate_and_map(struct mm_struct *mm, <br>
              &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE_ONCE(p-&gt;svms.faulting_task,
              current); <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range = amdgpu_hmm_range_alloc(NULL); <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(!range)) { <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -ENOMEM; <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto free_ctx; <br>
            </blockquote>
          </blockquote>
          <br>
          Can not goto end from here,&nbsp; this skips the
          svm_range_unreserve_bos. Just set r = -ENOMEM, and the loop
          will exit and cleanup accordingly. <br>
        </blockquote>
        <br>
        That patch has already been merged now and i have to send
        another patch for review. While at it, cannot just set ENOMEM
        and leave as it will crash in next step where it access range
        which is NULL. <br>
        <br>
        This is what i am thinking <br>
        range = amdgpu_hmm_range_alloc(NULL); <br>
        if (unlikely(!range)) { <br>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; r = -ENOMEM; <br>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; svm_range_unreserve_bos(ctx); <br>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; goto free_ctx; <br>
        } <br>
        <br>
        If that is fine i will send a new patch for this ?&nbsp;<br>
      </blockquote>
      <p>I'd recommend</p>
      <pre>	if (unlikely(!range)) {
		r = -ENOMEM;
		break;
	}</pre>
    </blockquote>
    Yup, this would work too and is a better approach. Sent the new
    patch &quot;[Patch v2] drm/amdkfd: fix the clean up when
    amdgpu_hmm_range_alloc fails&quot;<br>
    <p>Regards<br>
      Sunil khatri</p>
    <blockquote type="cite" cite="mid:9b697481-8530-4cf0-8f44-fc5f23b542a9@amd.com">
      <p>Regards,<br>
        &nbsp; Felix</p>
      <p><br>
      </p>
      <blockquote type="cite" cite="mid:84127e94-064b-41cf-9be9-ef4aa32fbf10@amd.com"><br>
        Regards <br>
        Sunil Khatri <br>
        <br>
        <blockquote type="cite"> <br>
          Regards, <br>
          <br>
          Philip <br>
          <br>
          <blockquote type="cite">
            <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
              + <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
              amdgpu_hmm_range_get_pages(&amp;prange-&gt;notifier, addr,
              npages, <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; readonly, owner, <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range); <br>
            </blockquote>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------wSC5RBR0qFGTrHwTdIbd1ky0--
