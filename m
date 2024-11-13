Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51122D41C02
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 05:32:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E760E10E343;
	Wed, 13 Nov 2024 05:32:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5ib2geLS";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2056.outbound.protection.outlook.com [40.107.96.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE02110E343
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 05:32:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nWaUf0Prx42F7xWbUOhKlCTLSotuhH5zW5dqMjSGRT9T8KJp3YpnHDKPPC4nXvyOrDQuQ5tBn7LTaNaqZ+tTbjD/ooGy3WtAAGna5auAT8HIMqkBk6QVCOfdsGLdle4uWWRiKlPnCkgNVIoJaZ1oOi079fGxDTyPXST0FavB8QNVfComdq/yFiN2drwyO2ZJKb88biE2+M1w11/ZoHkiX2DmKT4FF7GT4btzIYST9AuRAZTTNd/xJmBaOpZ2NRUmeTUfenq1XRJ3AsNGwdGORSCtRhbUYzgTfktg2pDPavRpgUjO8W2W5yERPxOJTvLanVLrv/S5My5ox0gy20c7zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNy4HT7HQBueAM3V+i6zwlRwGeKqR2mRgRVBT6kED28=;
 b=v2sZOq2XzJv408lDOyGO4oLZjkW0Uaw12KxBmBvN8mwgwGEBCg8vasqATG11Rphk48zkAEKXTGwXM8q3OQ4iy2nKnDXnlinrqBd2oW3uEIYUIugky2d2PDGKT1YXqSqc+d1kw6dH3UqY/P87sXbg2SYRNoFe3PNX/DCDT0qA8FAekshom1k5kPzjAdqhH2/QP0VcxBz1BfZjhGOnHY61zUyqrzKySDtFy4LrebKBtY8DmduOK+3FcFGTUny5reQ/g0TVXNXgcyGeMuKP65jSJVVbXbeW8ij2STe2OYBL81qZtgiqNduSo5U/DxuFf8+pGcpmiQbgKANsHk7xUBrRlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNy4HT7HQBueAM3V+i6zwlRwGeKqR2mRgRVBT6kED28=;
 b=5ib2geLSL6LCY5zcmS6mfOCEmGExSZOsVxXcIMex7SJDuGo0gpM/PuVGqdcxabnMm2ju1tGXfleERlte0iuLxzeJD1HdxU8F9cqlnwiMeFsLNoBpIn0GsveByw2iZealMQ2qF9i3f8oMMhf4Li+CgYWRJbZCK/aP3yVocJQ2cmI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CYYPR12MB8732.namprd12.prod.outlook.com (2603:10b6:930:c8::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.17; Wed, 13 Nov 2024 05:32:49 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 05:32:49 +0000
Message-ID: <e568ec2b-028c-4221-ab21-940e600e1508@amd.com>
Date: Wed, 13 Nov 2024 11:02:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: fix vcn sw init failed
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>
References: <20241112143050.1931822-1-jesse.zhang@amd.com>
 <20241112143050.1931822-2-jesse.zhang@amd.com>
 <910caa3a-802a-41d6-ae07-c39292081d4d@amd.com>
 <DM4PR12MB51524E90E5A98A03BF7FDD8CE35A2@DM4PR12MB5152.namprd12.prod.outlook.com>
 <63fcdfc5-af2a-4065-ab5a-81ca5dca6db9@amd.com>
 <CADnq5_Pix7r90tHzXF85vNMrqk+KZSOGSgHRuCvHH1LSG6JVgQ@mail.gmail.com>
 <e8698f59-6fe2-41b3-b023-5e9af848a0c1@amd.com>
 <CADnq5_MNGZKhmd3JMy_=ZahBzUMPxgOtT+T-7j12GDBx7mF=Pg@mail.gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_MNGZKhmd3JMy_=ZahBzUMPxgOtT+T-7j12GDBx7mF=Pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0231.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::7) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CYYPR12MB8732:EE_
X-MS-Office365-Filtering-Correlation-Id: 289fe4d2-fc62-43a4-8739-08dd03a49bfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmtWam5CZGNhVGJvRzR2SjhoUm5HL0NKcDBHc3kzRmtOUEI5TUhzL1VFY29C?=
 =?utf-8?B?aU94UHJCUkFadlFNNkJqdVN6aXpINVZET2VDeFdwQk43RXN0aG5ER3R4cjZp?=
 =?utf-8?B?U2JqZkR5WDZqeXQvYkhiN0diRHZpczczR1VNeUxwRlV6cjlQR25UY29FNmtq?=
 =?utf-8?B?NlphUm1peUEwY0J2dnZheWRYR1VCQ2RJNE5DalIyMlRpcUJ1cU5xYkZFdDVV?=
 =?utf-8?B?dkcrUG5oQWZMWFJ3ZXdpV1hsNzV4b3RCKzlsaFZJdllmdzc3VXFnVWJYNnRa?=
 =?utf-8?B?UEpjT3RqM2czREkwVndIS2haQWlyL3VPM08yU09zeWl5ZUhmaXd1SjZVVTF4?=
 =?utf-8?B?T2thZGFnMzlmNHFFaWV2dFQzdTluM3dkOWwweWJkVHAwNmIvMnBBMVJxWlRP?=
 =?utf-8?B?MkhIb1o5TFdmUVBqN0xkZ256YTExa2REWDNYTzZIZE42Z0FuSGhlSWVPbWQv?=
 =?utf-8?B?M2xwUDlvUmphZC9SSXNMRTFuelFtUC9PVDdKUUZocXJvVGFONGNxUStEc05t?=
 =?utf-8?B?MjRCanZ6YWxaVEsxQXNvc2lzS0tIUDRoSnZ1SHF1T1JGeEUrcThHN04zV1lR?=
 =?utf-8?B?M0FFRU1OLytFalY1NzFNbi94V0gwNkJYKzlod1NDdmpURktNQUlYWm1qdUlk?=
 =?utf-8?B?WEQ5aUU5U240cWl1L1J4aEZOS2lOdUlPQTlDSU5jUFEvNk9qMW11bzhCbGpz?=
 =?utf-8?B?bWZYT0ppa090VFVacHZ4RVBhVlpnRnBzRnJEWU9VcXN6bFdhcDRxbjFSQ1dV?=
 =?utf-8?B?WjlQVFF2WXNndGhnQ2RrdE1qcDVvR3B5clFzYStzckdienJQeEFtL1BqekhH?=
 =?utf-8?B?ZjRaYUtkNGljak9JOVZhUmJ2K0tXS3IrV3F5Sm9uMjgzK015VldpT3FEUHRp?=
 =?utf-8?B?bU96SDZmM0hURm1EOGUvMEh3V20rQXNqeWcvUk14UGdiT1kwQkUrcVdsUlBs?=
 =?utf-8?B?YW1zandTM0lYN2pESHVMNFROTjFvTDd4Y0xBZFJWK2VXYXFmdE1ROTFMNkg2?=
 =?utf-8?B?dUpYeExIVXF5NnFyS1FoMk5nNXJmd2RDRm9VbHgwK2liMVBYSmZpd0ZvQVVx?=
 =?utf-8?B?QjNGRy96N3l2NnR0WVh6VzJ6SkNpcllLVW9OTFdHTzZtbG1oVzU4QUx4dXY1?=
 =?utf-8?B?a0tmV3N3OXJWQldIbG9ycFk3bFY5UXo0OFdpa1hDQmQzSVVHbEQ2QVhjTXRE?=
 =?utf-8?B?aGQ3c2hNbVRveTVsOWZUZHRsS0Z4ams0M3owcHdwSVpJWDkxekdtU1g2TlZW?=
 =?utf-8?B?eU0rWEpqbzdiV2JHWW9yUTh1TXlkMDh3OWRvWkx5cFVYenpEYUR5Nm8rT2FG?=
 =?utf-8?B?QmkyTHZEOVFlUVJvVVBVaERQT0ZuYmo2dlU4MFBLZDVUcXlSUlkxZnpsMXo5?=
 =?utf-8?B?RWRpMkdYd1VEV1lZLzMxbzRFanhzZ09rSzVoYkhzT0pvR1VXdEJMclYwSmx3?=
 =?utf-8?B?UXNaYVBxNnYyRGQ4eVZGLzlHRG4xclh2YW5LL3lEVllKWGd2Tm00Qmo2OGFR?=
 =?utf-8?B?RjNBUmVXaWRCWncxSXhCRTZNOWdwVVI1VHVqbFIzNHhuOUM4dTdnOEh2RVBL?=
 =?utf-8?B?R2s3cHlqbFRENlIvR1hJZFgyZjFyUTdHekNSZWVwYXVGTlFPVDFyVzMxRUJJ?=
 =?utf-8?B?cUpXbGhxQVJObkY2bjFEd2FDajFwUUhzZVIwclNXUG51eVZUeXJSSlU3eXV0?=
 =?utf-8?B?U1JITzg1dTY2dFlnNkhJeVNYQU5lYXNEKzBDQmFOaW5VcG9MTjNRSFVVOFI2?=
 =?utf-8?Q?3osFXxrEY9HK2bOgVcTziTIr7WmGlyhl0RCmtJT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3J2bThSazcyc3ZUei84OE9PeTlmNmNJd21VYzdDTVNMZ0pGT1RiVVZnTnlE?=
 =?utf-8?B?UEdnNnBza2tFL1VYUEk3MEtUd2x6NDYrR2ZBMEdDN1E2UEp1U0V6ZmR4ZFl2?=
 =?utf-8?B?di9zbU5oWWRPVXk4SW5VZEJ5ZTBrV1p5bGtnaGV2WlNqeHltYXU2UWRBMGdz?=
 =?utf-8?B?NDByemtNcDZOcjhMV2p6eUxGNTNXVFB2My9HMzNvS1RJVkVZOXRCR29oS25X?=
 =?utf-8?B?UytmZlowTnNKNmNJY1FKZ2ZMeTExaW0zM0hrdWp2R0lpbEhYUlJMZ05WMzBl?=
 =?utf-8?B?dGFNbXRXWlJZcDFwZk15ZmVBbE9MYkwwUVFBbExWME15RmRUZEd1RWtFLzZ4?=
 =?utf-8?B?RDZlU3RleHBYRzZJTlB5cXAxOWdMY2JReFQ2em1EV2VRd0pBMUVQVFpOVUdn?=
 =?utf-8?B?eXBPVys3bVdGTUZVVXArV3J4a01IcDBBbnZZSEU4M1lKTzlqdmlZL082STdP?=
 =?utf-8?B?SGs1WldFcGtBRDNNQkdub25LWDQwMi95Y0xOYUI4REhtTEFVT0J0RUNuOVIz?=
 =?utf-8?B?R29vOWs1WkNsVktWMFoyMFIzT082aEh0cGVkZHBZZ05wTmpzaXlWRVdkQ2tZ?=
 =?utf-8?B?SWJOLzVwalJVYmJtL2U5V2lkUTFRNWxtWEhOSStpWDZ5ZE51M3MrWUxUMjVI?=
 =?utf-8?B?bkt6M3pOQzJDUlc3dDV6N1JnYmZFYlpHTEN5clB6VmpGMmNQZlFDSmJ3Umo0?=
 =?utf-8?B?OFpJVlhmQmlXdStLTWNHa2ZJa2R1Mi93VER3QmZwY2xYVHliemcySVhpMU9o?=
 =?utf-8?B?ZklRNVhKQ2hSQloyWXQzSVJ6MEdEOGdXVXJGdzg2T0ZoMVZmUFJNLzdsVzhF?=
 =?utf-8?B?OFNWcEJxRitubGhXbWNBZ1JQOFQvM0o4bjFJVGM3RUxnajl2YTlDZmtNUWo5?=
 =?utf-8?B?d2ErdzJLZkhRNFRpdkg2RUFJOHd2R3BWdEVEZUI3SFFHVFJtM2lpcnBaNHdh?=
 =?utf-8?B?SFBFZVJaYVNaSUEzWXhUcVAyTjZkUzJ6TTdEWHpjdXY5c1lKeGswbkRDUVFk?=
 =?utf-8?B?eFhLSndNTGkwQys1RzF1Zmsyelord25VUTNqUHorRzQxaUVKL2tSNldWODlP?=
 =?utf-8?B?ZlFiNFM1RE9tMXAwK1oyb3R5V3VjWXNIVlJmTXUzOGI0VDNMTDZNd2dTY1dF?=
 =?utf-8?B?OXBSeFJ2VVhEN1pXODk4NngxUitFcDBkLzMvMHI4MVdiWEFUTjdNRGdWYXVK?=
 =?utf-8?B?MnJ3YS9hZWR0VnZmQ0U2Q01lU1ZQTjZYQUdJVnpzWDRhdFEwNW1HU2Y2bmdw?=
 =?utf-8?B?SlR0dldITndaT0lXdmtyZU4rS2VDNFduSStvNkJnVUZGWC9Za1k0S0FMaTVV?=
 =?utf-8?B?bXJ3Rk1KQmpneHhZYnBLN2RRcTdZQ1huTXNtcWxyQ0VUTlZBajNEN3BPaFkr?=
 =?utf-8?B?Sy96K3l2d1NHWSt2RitldXZLbkRVS2oydEtiV3d3T3NuM0tLL3VJYTNadVZ5?=
 =?utf-8?B?VWJ0ZGM2WDdqQlF1N0VGTDVRS1loUW9COVdPTWFaa2hibzhUcG5xSFhnTFo4?=
 =?utf-8?B?Tnd2TmpXR0syUVVOdGIzdTQyM0JocVBOSHpxUWlzZmtzcXNnRnF1VXkzTHVT?=
 =?utf-8?B?Z2lJUk1BNlgzaHFka2dlVW5ZVjJwaHZTVyt0MVdIWmR0U3phc0xxRXJ5Unp0?=
 =?utf-8?B?cWR3UURkb3lFSDhBVHlhRUdkaUdHVmg0OTEvbmxPbGpLYjJtMWxLZ2JGbHZp?=
 =?utf-8?B?UVFWbllmb3BzZTNJWjgyWUMzcWt2REZKUFlTdG9xWGxrVnVBOFZQRGtSeG1E?=
 =?utf-8?B?Nkxwb0g3VzZKS3lOd3MrNU5Ba0lkQjAxd2NUakE1dndteGVuS1orOThpSkhk?=
 =?utf-8?B?aXo0VUdwdEdwYzF6MGg2dEJjNFppMkczYUtWaVhqVkQvM2FiYWcwMjdnSXdm?=
 =?utf-8?B?b3ArSWlXbmhyM1FPcW5pZmNvclVnTlV6UHlaT2Qyclg4UjkvM25vRkorNHVB?=
 =?utf-8?B?NEJtckVPS3dhZXU5QUJBS3pPMkNpdW5XR2gyeW0vSDR4dzc5dnF1eUNvRmov?=
 =?utf-8?B?QllFTG1VOG9CZ1NHVlQ3T0tDNFc2eFVpN0MrUlFPZ2VxbnRabkJpRi9PMlRz?=
 =?utf-8?B?TWpFamFqM0xtdlZVeWYzMTgzZHJUS0dCQzNQVXN1ajdwN0FYVFpqWTVsRW5k?=
 =?utf-8?Q?fMf9T+9RFpUkjO0+b0c7+QLCn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 289fe4d2-fc62-43a4-8739-08dd03a49bfa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 05:32:48.8010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1kQt7UgE2KHCyjMIb7uNSjZU7wm+QODYQLnzy/ruLuRbPgWpr+ukLn2pZl1ULJYU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8732
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



On 11/13/2024 10:54 AM, Alex Deucher wrote:
> On Wed, Nov 13, 2024 at 12:03 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>
>>
>>
>> On 11/13/2024 10:16 AM, Alex Deucher wrote:
>>> On Tue, Nov 12, 2024 at 10:24 PM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>>>
>>>>
>>>>
>>>> On 11/13/2024 7:58 AM, Zhang, Jesse(Jie) wrote:
>>>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>>>
>>>>> Hi, Lijo,
>>>>>
>>>>> -----Original Message-----
>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>> Sent: Tuesday, November 12, 2024 10:54 PM
>>>>> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>; Huang, Tim <Tim.Huang@amd.com>
>>>>> Subject: Re: [PATCH 2/2] drm/amdgpu: fix vcn sw init failed
>>>>>
>>>>>
>>>>>
>>>>> On 11/12/2024 8:00 PM, Jesse.zhang@amd.com wrote:
>>>>>> [ 2875.870277] [drm:amdgpu_device_init [amdgpu]] *ERROR* sw_init of IP
>>>>>> block <vcn_v4_0_3> failed -22 [ 2875.880494] amdgpu 0000:01:00.0:
>>>>>> amdgpu: amdgpu_device_ip_init failed [ 2875.887689] amdgpu
>>>>>> 0000:01:00.0: amdgpu: Fatal error during GPU init [ 2875.894791] amdgpu 0000:01:00.0: amdgpu: amdgpu: finishing device.
>>>>>>
>>>>>> Add irqs with different IRQ source pointer for vcn0 and vcn1.
>>>>>>
>>>>>> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
>>>>>> ---
>>>>>>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 19 +++++++++++++------
>>>>>>  1 file changed, 13 insertions(+), 6 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>>>>> index ef3dfd44a022..82b90f1e6f33 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>>>>> @@ -83,6 +83,10 @@ static const struct amdgpu_hwip_reg_entry
>>>>>> vcn_reg_list_4_0_3[] = {
>>>>>>
>>>>>>  #define NORMALIZE_VCN_REG_OFFSET(offset) \
>>>>>>               (offset & 0x1FFFF)
>>>>>> +static int amdgpu_ih_clientid_vcns[] = {
>>>>>> +     SOC15_IH_CLIENTID_VCN,
>>>>>> +     SOC15_IH_CLIENTID_VCN1
>>>>>
>>>>> This is not valid for 4.0.3. It uses only the same client id, different node_id to distinguish. Also, there are max of 4 instances.
>>>>>
>>>>> I would say that entire IP instance series was done in a haste without applying thought and breaks other things including ip block mask.
>>>>>
>>>>> If the same client id is used, it returns -EINVAL (because of the following check) and sw init fails at step vcn_v4_0_3_sw_init / amdgpu_irq_add_id.
>>>>>
>>>>> amdgpu_irq_add_id:
>>>>> if (adev->irq.client[client_id].sources[src_id] != NULL)
>>>>>         return -EINVAL;
>>>>>
>>>>
>>>> We had some side discussions on IP block-per-instance approach.
>>>> Personally, I was not in favour of it as I thought allowing IP block to
>>>> handle its own instances is the better approach and that could handle
>>>> dependencies between instances. Turns out that there are more like
>>>> handling common things for all instances as in this example.
>>>
>>> We tried that route as well before this one and it was ugly as well.
>>>
>>>>
>>>> I would prefer to revert the patch series and consider all angles before
>>>> moving forward on the approach. Will leave this to Alex/Christian/Leo on
>>>> the final decsion.
>>>
>>> Do the attached patches fix it?
>>>
>>
>> This is kind of a piece-meal fix. This doesn't address the larger
>> problem of how to handle things common for all IP instances.
> 
> I think we'll need to handle them as we encounter them.  We can always
> split common stuff out to helpers which can be used by multiple
> instances.

I don't think so. It made a fundamental change. We changed the base
layer of considering IP as a single block. A common swinit or swfini is
no longer the case. Consider how a sysfs initialization like
enable_isolation could be handled if the same approach is taken for GFX IP.

I would still say that we broke the current foundation with this
approach and hoping that uppper layer fixes can help to hold things
together. Or, it needs a start-from-scratch approach.

Thanks,
Lijo

  But I think once we get past this refactoring it will put
> us in a better place for dealing with multiple IP instances.  Consider
> the case of a part with multiple blocks of the same type with
> different IP versions.  Those would not easily be handled with a
> single IP block handling multiple IP instances.
> 
> Alex
> 
>>
>> Thanks,
>> Lijo
>>
>>> Alex
>>>
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> Regards
>>>>> Jesse
>>>>>
>>>>>
>>>>> Thanks,
>>>>> Lijo
>>>>>
>>>>>> +};
>>>>>>
>>>>>>  static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev);
>>>>>> static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device
>>>>>> *adev, int inst); @@ -150,9 +154,9 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
>>>>>>       if (r)
>>>>>>               return r;
>>>>>>
>>>>>> -     /* VCN DEC TRAP */
>>>>>> -     r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
>>>>>> -             VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst->irq);
>>>>>> +     /* VCN UNIFIED TRAP */
>>>>>> +     r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
>>>>>> +                     VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE,
>>>>>> +&adev->vcn.inst[inst].irq);
>>>>>>       if (r)
>>>>>>               return r;
>>>>>>
>>>>>> @@ -174,7 +178,7 @@ static int vcn_v4_0_3_sw_init(struct
>>>>>> amdgpu_ip_block *ip_block)
>>>>>>
>>>>>>       ring->vm_hub = AMDGPU_MMHUB0(adev->vcn.inst[inst].aid_id);
>>>>>>       sprintf(ring->name, "vcn_unified_%d", adev->vcn.inst[inst].aid_id);
>>>>>> -     r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
>>>>>> +     r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[inst].irq, 0,
>>>>>>                                AMDGPU_RING_PRIO_DEFAULT,
>>>>>>                                &adev->vcn.inst[inst].sched_score);
>>>>>>       if (r)
>>>>>> @@ -1734,9 +1738,12 @@ static const struct amdgpu_irq_src_funcs vcn_v4_0_3_irq_funcs = {
>>>>>>   */
>>>>>>  static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev, int
>>>>>> inst)  {
>>>>>> -     adev->vcn.inst->irq.num_types++;
>>>>>> +     if (adev->vcn.harvest_config & (1 << inst))
>>>>>> +             return;
>>>>>> +
>>>>>> +     adev->vcn.inst[inst].irq.num_types = adev->vcn.num_enc_rings + 1;
>>>>>>
>>>>>> -     adev->vcn.inst->irq.funcs = &vcn_v4_0_3_irq_funcs;
>>>>>> +     adev->vcn.inst[inst].irq.funcs = &vcn_v4_0_3_irq_funcs;
>>>>>>  }
>>>>>>
>>>>>>  static void vcn_v4_0_3_print_ip_state(struct amdgpu_ip_block
>>>>>> *ip_block, struct drm_printer *p)
