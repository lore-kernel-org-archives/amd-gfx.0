Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F67C55AB9
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Feb 2026 13:35:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8F0D10E770;
	Fri, 20 Feb 2026 13:35:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NhT6igwn";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012003.outbound.protection.outlook.com
 [40.107.200.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94EA610E770
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Feb 2026 13:35:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mCoGiU8zsCNqhA8OkxFPYM8s/T8PjASV0tP+ksP6J8mVcxiuS4uKWkPiRZcjD+2+mMPY02vmWVUPYty/PmzgzVajQ4pRkCJqnzvX0Cc8ogB5MIVAPS3EUkGvpBeTaSSV+Nljw9XcQXXQxZhJLMhRgmdCtGUKac8FtSyals03MybBQrQIooz33oOH5+MNYsPImqK3OKmcqfWpsqDAkvip38u5/CKYWsMXtd8C7c63KsEzgijqEAvOCvoEX4S6UlyOyGgeCHsFkBI/a1I97Y0iFGU5Sl8hxqcgnJ3kodbBkwcEkk8lTbsGWa7K2mXbvfx6FbiaZCf1QggnZ/Lf3v/jNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SddjMc2NCoG7Hf35C/8D/kZeUcG/1FCrSJ1S06LHViU=;
 b=xUEKhonO/mZwWPgtcHrM+Gr1uf8rXpcaMmAY0ulV6968ayE+euCZ6yQfCLa83/Xt9KGI7OXHAHZAVmeMezL3yFsnvUPUPSM/Bft5UFzUyvXT7uw8gsUWaL/dojjO/JpIQALOGshVARYNQSr3n99+DDFlCm1e9/m6IYSwlU7A+EmVe8MGGpG8kjBNhN+n7wZtH3PZ43iposDQp/zVu6dIFrqCbAzEP3s3kAvMh9/FU7BatM71b8JJvSuneg2yTVIhoTzgcAYkuEx3cepdTysfhpFKp1mfP9ZBfmUgtp01Hpy6hB0Xb1AlAi0+ArlHEdY7BIVyj/YFz0NkJ1WGlQ674w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SddjMc2NCoG7Hf35C/8D/kZeUcG/1FCrSJ1S06LHViU=;
 b=NhT6igwnsfgh5nbvRbGrEkJF7quSyTFjqTA8Gwht9ZMxkih6MXF853GUtdIgFgNgn/HdpMjm0hwpE1HUcqSKSuIjswhv8dFPxfi2fAkjkSOElNQihv66d1eQqq6JcmdNxqCvxDWbri6IwUShpFQRjPRpgvvtIV4slJFmplKfyPM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DM4PR12MB5963.namprd12.prod.outlook.com (2603:10b6:8:6a::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.16; Fri, 20 Feb 2026 13:35:00 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 13:35:00 +0000
Message-ID: <e1d8e922-8ad9-48d1-b5e4-d9d8cc2af8cf@amd.com>
Date: Fri, 20 Feb 2026 19:04:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] drm/amdgpu/userq: Use memdup_array_user in
 amdgpu_userq_wait_ioctl
From: "Khatri, Sunil" <sukhatri@amd.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com
References: <20251205134035.91551-1-tvrtko.ursulin@igalia.com>
 <20251205134035.91551-7-tvrtko.ursulin@igalia.com>
 <92caea0a-470a-4b76-b2b2-23f5af0a4d6b@amd.com>
Content-Language: en-US
In-Reply-To: <92caea0a-470a-4b76-b2b2-23f5af0a4d6b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:274::12) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DM4PR12MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: aba7deb6-904e-42d5-2162-08de7084d826
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVIxT0xNdzNVakZRdkNuVGNtVUZDaFR2eGlHMHFIY2c5MWpQM3NWdmVXRGJh?=
 =?utf-8?B?K2dSOUQ2OURWc2p5T1ZIMTg5MlpZS0haZU9IeFErRlhEVDV5MXVCWnlaanRr?=
 =?utf-8?B?bTJaK05xaDV0SUN3dkROSDRud1p6M3NuYzFFQlRoTW9aUXRaNjltZVhyUFFa?=
 =?utf-8?B?cTBjRC85Y0RQSkhDajg3K2szd0JxaUNReG5ZWWZXNXBWK3RFNE50Qisrbkoy?=
 =?utf-8?B?T3lmZmhwMGUxT2hrU3JSeUtONGNWTUdoUUpuWjBodjNUcHVGWHYrNDdYMDhh?=
 =?utf-8?B?WWFsQ3JiME9QTEtCeFY3ZW5lSlhsdGV0V1dsU25TclFCWENOUnFNNzA4WlV0?=
 =?utf-8?B?OVBnNCtpdXpCMWZ2V2RNd1Q2ak1KWmFLT2dVZzFWdyt3cy9tbGtZQ2Y5RVA3?=
 =?utf-8?B?d1ZEMUtCNDUzd1B2Q1E3SjNzaENHRlBVVitHYURndjdoaVpaUm1sVE5vazRN?=
 =?utf-8?B?ZzJmL1RHYWhIMk01T2dKMXMvd0I4cGpOZU5uSmtROFVBUVl1M1Mrb3lpU3ly?=
 =?utf-8?B?d0JCdmtGZWd6MkROV2VGdzV3RlgvZmg0K3pLdDJBTmd5MUVoT25URTlUVnJz?=
 =?utf-8?B?S1hXeG4yN0JNUkRwUlJKdjVjQm1PWVFOSFJTMU1USUlRc3NOQVZZLzlLblVD?=
 =?utf-8?B?SktvT0JJUEJmOTZ4VkNvZlNXTUtTT25CLzFrbWlLWWhkTFVEU0NvazFFSTZR?=
 =?utf-8?B?RGR1MCtseW9rQlVYSTB2aEtaSHdWZG1RNlI0TjNERE5iVmZ1eVM0SkdMUGZ2?=
 =?utf-8?B?QXZXdDNteG9xY0dPMHBOa1lZZ0FhYmJjZ1RHeWFxRUNUbG92UG80M1RGNnVm?=
 =?utf-8?B?eGFnMjZWREdna0JQdXltQlNoTVNQYk1nbmR0amh4RlJaN3gzZVRaeVVhb0hU?=
 =?utf-8?B?UnJXSUNNWFBTNXhSSWNBTEwrc1pXWCtZdjNPV0IxTDJlMlo2TnpXcEMrSXZG?=
 =?utf-8?B?bWtJQmM4QWs3YjNMZGNrQ0VMWmh0cStmNG5Sekh5NUpEeHc1TDRvSVVjd0h0?=
 =?utf-8?B?SEtwbUhQK3dkaVZKaXA0TGRXaW5yLyt6Rk9qY0xQQUlyMjlkbUdIYnpwSUdh?=
 =?utf-8?B?eEV2M2Q3YTd3Vm56WVBjT1VNK2pNZlBBVUp5VEZXcHdFWmx4UENUSWYvK2ZK?=
 =?utf-8?B?QUlFZHVyOTVIUHN6QllidkloWU1INlRiSFhQZW1vZVd5VW51SmhIbHQzRDJ2?=
 =?utf-8?B?WDFDdUhFU0VxZ0ZIdDZ5VUpaM29HekFXRTVVVVRlbVV2T3U4cnFnUHA5Wkg3?=
 =?utf-8?B?dStNdmhvUS9FK0pXamYyS1pITitXWGtVZDlsNUdyRkZBdFJHMy8rQlNibE1j?=
 =?utf-8?B?bk92eEw0MFNQQ3htVTVrUXBheWhTRHJqWWxUTXcydk92YzN5bVo0aCtjM1V1?=
 =?utf-8?B?M2hnZzlYSk5LdXY5TVNOaFhDeDBFTzFqakdNRGVpcmRGSU42V1F4SmZYL0t5?=
 =?utf-8?B?L2I3WWpFTldlRGM2WXJjUW1zdCtJVkNaODBRU3JqT2R1V25sc3Q0RHllMDFN?=
 =?utf-8?B?N084RUR0clN3aWVqTHpVc0JxUnJmNnR1LzB1dGVvVDRkYys4ZytyQmV0UnNk?=
 =?utf-8?B?aFZaWkJ3OFNHZWk5WCtRY3FSVzV0N2RUZlg1am11OVhoQmIyYWVBUzZtWlNU?=
 =?utf-8?B?ZHVmRWE5NEtGRm9HbnpGQWJEM0JNNUk5cFZtU3NER3h0MU1XL0tYTU1RUVRQ?=
 =?utf-8?B?ZzArTkt2bk1yMUVPNGNUOGQzK0ltbE45MnpNT0tmU1V5OElkMlJ2QURnZE1j?=
 =?utf-8?B?Y0NHaVZKSTJwNkxOcW1TVENDa3JlbTdSd0Fyd2ttOHNPbzhLeFF2MFc2UHNR?=
 =?utf-8?B?NHdnMUZnTW9TMVRDaDlsMWFmblhYY2d5bC82dVY1cERjU2JHbVBEUnpyQ25L?=
 =?utf-8?B?clZJNEhyL2lqWWRUNlFzS3dCSTVVWTByeUVKTmFubEk1cU4yV20vU2lybitI?=
 =?utf-8?B?MVZoRU1wMEVBeDc5K25uUEV0MG5weEpMbm5BS3hPN3lJejBRV2JOMktBUmR1?=
 =?utf-8?B?L0JiZ2J1WW5zMG5VRkdXN1hxUENpaklRSzRhMDdvM0JEMXhIdmc5eTdpM2N0?=
 =?utf-8?B?b1BWbzhsMncwcUxKMUI5OXRvWWZheWtaaDNMUzAyNWd6alNMUk52VWdYLzRo?=
 =?utf-8?Q?9yxg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUhmWjhLaDVBY0VRNkd2c2pRaWR6WlB5WlZ0Y29xQW1JL3FPZXEvVmoybTVi?=
 =?utf-8?B?NE9nTUZiNHBFMENCUWVOMjhDQmxUZWZIeTFDc0lyS2U0ZVM0YS9Sa04rbzBl?=
 =?utf-8?B?YWE2RUdYcGxPSVNDQUNVb3dxVEQzUWRMaUFCdkpyK1N6NGpGdUVUbjNiZ2lH?=
 =?utf-8?B?Yk4ydElmYmNMbUh2Q3p0d1NOSTN5VG9DYnZ6QzBXRExFYzdNRGQvTFN3SzFI?=
 =?utf-8?B?TmNpcGpYNStYSlBqNzRhanRWaDVqeDNTNjdmVVRGL3o2MUg4N3l4dGRWT1Y1?=
 =?utf-8?B?dDI5TkZxcVhBalpyOTBXVFFLejNBNDdjenJVWXBpdEFJNVdZSnVVdmFwcSt6?=
 =?utf-8?B?MC8rM0lnRnRGWGdLQTIrSC85S01LTGs5R3hYeEM3bEFVV3prZllFQ2JnVnU5?=
 =?utf-8?B?UDlsQzByb0x3TUZxM1o2SThwR0czSTBSSW5zNjVYNDF6ek5kc3RacWh4YWkw?=
 =?utf-8?B?VExjN214ckwyV084M1pVQzdMZW9zS1RZVXUzM3VQU2pGamltNzRoWHFUYldl?=
 =?utf-8?B?VytoU3VVekw2dVZqbE9vUFVHY0pMTm9Pb1VqSWErdVR6cG8xVDdtUXVqbWRV?=
 =?utf-8?B?SmxyYTIvY0ZOUC9DYzJFU0xGbno2VWJrWUtTdGlIWFVwVjd4bHRPd0pSWFV0?=
 =?utf-8?B?WVZ0d0NTREdERWs1N3pCUGt2eTJ4S3VkdlRIWFFnV3NhTEhFTTRvN0dyd2Q0?=
 =?utf-8?B?U21WeFlRc1RPaCtNSGVtVWMycW9RZnR6ditpZFBpa3luRGo2S09JTXZpY0w2?=
 =?utf-8?B?QjkwUUlGUisrblBrU0laRWlYVGlsVlRyZjZ6NVU4c0JpMkI3UW8xRXVMMDVq?=
 =?utf-8?B?Z3FKdkordm9LM0FZRmRpYzBMc2NOWVNPSS9pZFJaQXFuNXRQaXNHN1pFeEpO?=
 =?utf-8?B?enovaVRBOEkxRjNERDJPbkxDUGZMNlJHTVRxMkdaZ0MvZDYrdkpvbGxBZVlt?=
 =?utf-8?B?NDBoVlhmVkYvNURpaXB3MndwS0diWExuOEoyOU8zYW56cEJoVUU3NXVxN1ds?=
 =?utf-8?B?V3dEVXVQaGMrVVFvRTNjU093RlF0U1BkbDlTKzA0dVJqSFpjbVkyaUc5NVpR?=
 =?utf-8?B?ZVprWU1MTGlIRDZWb1lrcDJ3aHlkanJ0UW5LcTNqT2tZclBMbnRMUk5EUU95?=
 =?utf-8?B?Qzl3ZW9rOGJEMFppNU9MdzJIYS9ZbnZTaXJwTHg3VXcwdTFoYjRrZnFxNXpU?=
 =?utf-8?B?SThVTU5ZdDQ5NW5ZWmp2MnRvMHB1NnZqeXFkTkFkOU1HcnJQc3piSXpBY0NE?=
 =?utf-8?B?M1hLY0JEQ1BZUjgxWEU4MnJiOEVTcjR6ajgvdmZ3bjlrOFpPU0x0Y09YRU5y?=
 =?utf-8?B?VkUvaW1IUSt3NTVKckV1cEp3cWxjQWpsSUpCb2J1YlcvTXJmc0hIaS9vV2xo?=
 =?utf-8?B?UnpYVG9Fd0lhZ0NoaHp2ZmlQZ1VBZUUwK1B3UVhGUE9YVm1xYm55RFI1aVNH?=
 =?utf-8?B?N0NVRWxudUgyNXBtV2lweGhYZ3BWd0lidjJFRFU1ZGZYLzVWaGNaWU1SV0dr?=
 =?utf-8?B?RFY4S2F5amFOL1RETkF2YmxrbjVMU1VsYlhaSlBvYVBoQStwdTBseDlQUTBk?=
 =?utf-8?B?N2lRanBKb2VRZ2tpYXVsRkRZNlVFNEpsRzJsb0FwaDFEYlVpek41YmhieW8r?=
 =?utf-8?B?SzIrRGVqenZvQ2wyUUpDc3EreUNOY1F3Ty9oMmJNSVdnK3Jwd1I0ank5Smpz?=
 =?utf-8?B?L2llb2VZNXJTT0pacjVzR2hMVHIra1F3ODZYLzJTRzJDd0VHR01aMHBJMlVV?=
 =?utf-8?B?RjRrSzU3Y21qbm9VZUFHay9VcllKK2tkb3ZrbjRCL0I5YlhGYTVNVzhoT1Rz?=
 =?utf-8?B?TFREa2tpOXR0b3NEUHZ2YzduZGp4dGdEaVdhNEYySEducGNBaW5KbWJRREND?=
 =?utf-8?B?d1ZlWUNHK0dqV1VsU2FkQzBHcHhqRFBOTUtEbTZYYmphOHpHUVdDS0o3YVhO?=
 =?utf-8?B?T3gwOWlmdXFLUFhOMUNVYXdqWjBvMWNJZU9pUFBhZ1h2ZlZqU0xIVGN0QzN4?=
 =?utf-8?B?T3Z5WjlUL0J4NC84bWlDdmhYVlljRldCUVNQWDJ2MDNvZjlhcThYbmFnb0ZU?=
 =?utf-8?B?d3BsK3pUY1d1QUhOcGg5eTEvS1lQUWE1aWN0Z2hTNjN1OEgzQVlEVkZ0enJX?=
 =?utf-8?B?WlpMZXBUQmV1V2wzTTA2MFZSMTBOcnd1a3dPb2U4dGoxUHpzcFdIRnUzOEFt?=
 =?utf-8?B?dE1aOWlPTGVTOG1oSnBMdVV6YUwrd014S1pIUldDS1V0aGYwN1ovREwrTWNy?=
 =?utf-8?B?S0Y2WERPcmNwQkd0dllPSWYxWThUUEc2aGJudC9uaXk0SGRJYitvc2tSWWZw?=
 =?utf-8?B?eWdKWHdIN0FxTmY4QytOSE5WRlNzQ2sxbzNmSFo1VGRvV2pXSlhsdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aba7deb6-904e-42d5-2162-08de7084d826
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 13:35:00.0686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: omYFKKzAjAPOnnCoBTf/BqILGUrvmiXrKMCySIlNGRFfAXsJ59d4kSLBm7lJugE1Tc0uiv2TmCDrTGFyWfMCHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5963
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

Can you please get these two changes merged please,

Regards
Sunil Khatri

On 20-02-2026 07:01 pm, Khatri, Sunil wrote:
> Please make sure the changes are made for all memdup_user
> Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
>
> On 05-12-2025 07:10 pm, Tvrtko Ursulin wrote:
>> Use the existing helper instead of multiplying the size.
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> index 7aa26e88c8ec..f979e896c714 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> @@ -618,21 +618,21 @@ int amdgpu_userq_wait_ioctl(struct drm_device 
>> *dev, void *data,
>>       int r, i, cnt;
>>         num_syncobj = wait_info->num_syncobj_handles;
>> -    syncobj_handles = 
>> memdup_user(u64_to_user_ptr(wait_info->syncobj_handles),
>> -                      size_mul(sizeof(u32), num_syncobj));
>> +    syncobj_handles = 
>> memdup_array_user(u64_to_user_ptr(wait_info->syncobj_handles),
>> +                        num_syncobj, sizeof(u32));
>>       if (IS_ERR(syncobj_handles))
>>           return PTR_ERR(syncobj_handles);
>>         num_points = wait_info->num_syncobj_timeline_handles;
>> -    timeline_handles = 
>> memdup_user(u64_to_user_ptr(wait_info->syncobj_timeline_handles),
>> -                       sizeof(u32) * num_points);
>> +    timeline_handles = 
>> memdup_array_user(u64_to_user_ptr(wait_info->syncobj_timeline_handles),
>> +                         num_points, sizeof(u32));
>>       if (IS_ERR(timeline_handles)) {
>>           r = PTR_ERR(timeline_handles);
>>           goto free_syncobj_handles;
>>       }
>>   -    timeline_points = 
>> memdup_user(u64_to_user_ptr(wait_info->syncobj_timeline_points),
>> -                      sizeof(u32) * num_points);
>> +    timeline_points = 
>> memdup_array_user(u64_to_user_ptr(wait_info->syncobj_timeline_points),
>> +                        num_points, sizeof(u32));
>>       if (IS_ERR(timeline_points)) {
>>           r = PTR_ERR(timeline_points);
>>           goto free_timeline_handles;
