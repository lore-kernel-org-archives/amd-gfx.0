Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D8F1C6FA8F
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Aug 2023 14:32:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 324F410E3A1;
	Tue, 29 Aug 2023 14:32:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E44FA10E347
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Aug 2023 14:32:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3r0UeLe0VK0Oi6ZA8s/q4YSpnagP/sy+RkTeae0508Jw2NgKlb8ATKhgPbTgv1W/lwt+MaM2ILUBHRVABFrhrMRjJA5gwnN2xAPgnzdVv3G7gmos2SlQC3R56oTaq4kvAKjEydQqT45d12CGCbkOM3Q4duVvar4KJT+kDC1GDR/7M/2Yu2ai2or4CF6kI+sKp2y+SnC5CjquVB8gZ8oUe0SpSdFhC3iNqD2b/yiuiiK7+qc/+hUmUKC/qDDWc81VXGUsLlXLbZ8y6bRTvl5x2Rwlpdh8w44b05wx8EGGfFL5qpPQWyxQ7dz4woI87Wuw4XSafklgxfuZT6mFjmmCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUEpvKxzjyvqdaSUwzymAiySRNYHh3iw3jtxWFrvY0k=;
 b=ZZhDOmiurk20T1k2GFuHA7omObHGjXWtcLxnIgWI1I3ZAK3sjmL4BN2g5VPen51Jqz+nr6htgDhkQ8zF58jhKdi1hRuKAv3AOLLCes6YK1TLSBLedMGrO3v7F2zkUKxfVPajDuiU7sqV6SJUkMghlpQ0BYRbPiQuswNJufTF5u1iLVQbK5sJYO03kixeOk3YRGZXwO8vO16lAWeEtd1YYvCHWzA0qY+XOPpe6FBA9yAycoUkel9geOiw9/7K76KWU5ZVmU/myGO+kq/ZbqTxVbY604HTmKz6cJaxKtvnnWIF49wTXmSDbnX5QAbgSgsZzuS4538Gj7/qb35fOtGNHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUEpvKxzjyvqdaSUwzymAiySRNYHh3iw3jtxWFrvY0k=;
 b=QIIDsydpjvwIEK7QRRTIYBZQRBmSAfHf4DSF0K1vpFJxFhzTRviRHbZWKjumDMLmzK9gxffqPwwvuzFyRq4AFvZyX3REjyHvZ8SMRyeDZqxuoM3yVqSTo+dIlbcPie1NmYp6ZrgcILnE7A3p4eEHzJP4y1vh1L8Ioyd7XgfFWP8=
Received: from DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16)
 by SA0PR12MB4351.namprd12.prod.outlook.com (2603:10b6:806:71::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Tue, 29 Aug
 2023 14:31:59 +0000
Received: from DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::b573:a190:877d:2dfa]) by DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::b573:a190:877d:2dfa%4]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 14:31:59 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH3PR12MB8186.namprd12.prod.outlook.com (2603:10b6:610:129::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 09:44:27 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81%4]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 09:44:27 +0000
Content-Type: multipart/alternative;
 boundary="------------hrK5UbCytPktlYeWoLWOSnOF"
Message-ID: <e212275c-5783-5ca0-f2a9-e7de20bc445a@amd.com>
Date: Tue, 29 Aug 2023 11:44:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Keyword Review - Re: [PATCH v3 2/2] drm/amdgpu: Put page tables to
 GTT memory for gfx10 onwards APUs
Content-Language: en-US
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230825003348.3978418-1-yifan1.zhang@amd.com>
 <20230825003348.3978418-2-yifan1.zhang@amd.com>
 <IA1PR12MB635664DEA385477CF3996C8DC1E0A@IA1PR12MB6356.namprd12.prod.outlook.com>
 <4f64681c-11de-7c9d-c71c-d96b4099a9bf@gmail.com>
 <CY5PR12MB6369567CA37A1148A55BC2ACC1E0A@CY5PR12MB6369.namprd12.prod.outlook.com>
 <a7d9611d-32a1-df24-2d7b-0031dde56cb4@amd.com>
 <BL1PR12MB5144A8C64BA08B326BEFE330F7E0A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <CY5PR12MB6369A28D10CBB70F702C507AC1E7A@CY5PR12MB6369.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <CY5PR12MB6369A28D10CBB70F702C507AC1E7A@CY5PR12MB6369.namprd12.prod.outlook.com>
X-ClientProxiedBy: FR2P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::14) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CH3PR12MB8186:EE_|SA0PR12MB4351:EE_
X-MS-Office365-Filtering-Correlation-Id: 959ed24c-d476-4d61-56df-08dba8748904
X-Moderation-Data: 8/29/2023 2:31:57 PM
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s8Vm5/XSbthmWvtS6QF3FraZstJo70f93m+L25PeBnBx6wSyYInfcTVDKLlKBOYu/PnRpJbUn9FLzMHYbhnz0vwEZsm6lQDdmcuc7VIXmvzWxJMrqanCAR/LD1Sn1+OrZEO029ilDGcgXjArN2nlT+Ge1tKFQior2vvgEhKOpOFQbP3pL5uh5uMlJ2twBIURv2rXnOjmQoCiSN01SSk6PEWOJQovAWLt2msTjhCgTEIr5lUslNnv0XJ69sQbB6ODSK7QMq7kRsmqKZRGs/MQJI7JbwDpDWxOELG9yj30kyVsVhbpMNUo6U98KMWtyJTON/+lJOaETtaU0MNNYh0MHS2nYjsD1Mn/qFHx1cd663dB5bsG1wQ7IF3BwnXXvqgFyHS/NBAvrd5lPsPNa9adA4yfoLKubru0SlQ36DRawjhjhaqUPzmtqpb33rQbgqKPx75h64dnYUNMH3ZTJTmf0p/rPBZu4gyX8RjrVOecnW5kp4CyZdJMXtV78YAmButKqPZA+cjlL0ive1P/ObQnFK62bhj5tcXWSrO/0aLcU7weg79BAdumvjgfKtJQyiQEcqsjYzduIuB6xm9VRmcg65DN6809EX2eOicUO/eK5PiwXCy/D1cRZRxegeIABwHRhGSZE6o4QhTzORFFn7pd+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8502.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199024)(1800799009)(186009)(8936002)(6666004)(110136005)(53546011)(478600001)(31686004)(6506007)(66556008)(66476007)(66946007)(6486002)(33964004)(316002)(38100700002)(41300700001)(6512007)(36756003)(26005)(8676002)(5660300002)(83380400001)(31696002)(2906002)(2616005)(86362001)(66574015)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VW5pSjRQQ1c1U0lOSGZYWlRqbU90WVVvOW9tbFcwN1FYK3k5WFFiaVNFVy9Y?=
 =?utf-8?B?S0h6VWpvYzZIbHRocFhCcDRyUDV0RWFWbnZiTUhHWVlEVUlkOXA5Uk5uaFBq?=
 =?utf-8?B?NjJIMno5aXhiRnpMeU81T2tGeklFMlNaWnBTc1ppNjVnTkNoM2lHVytKdFVT?=
 =?utf-8?B?WGw1MUhKOHNlVVZLc2xleWdGNXRicXFrd3pHR05GcU1tS0xKUDVzVi9iMGpH?=
 =?utf-8?B?ZEJ1Sk9Cc3hPQ0ZEUDJZQmwwbS9LTFl0bTFFMUx6TllBZ1NldUZwbm1Lei9i?=
 =?utf-8?B?U01jdi9tb25WOHdPeTZOLy9uV0dpL1Z6TUlFTVFxbDJHbys0c1RpN2NNN2Zm?=
 =?utf-8?B?TndBdDhBSjEwL0Rka3Z4WEI0blpZRGl6MXVYVG51VjBzVWxQZ20rQ1pYdHFq?=
 =?utf-8?B?cGJYaU5xOG1vdm9UVWNBMWFXbUxFZjl3WVdpSk1ORmF0UTZXcWZKVzl2bEZr?=
 =?utf-8?B?bUNYMHNHY3U2S1cyTFVuVllPdkpoYnhsK25zcU9jVDFRZXFxdnFLb3R2T2Qx?=
 =?utf-8?B?V2xjZ0toNVA0alZEWTFGK3VCSkt4S3JoUE5GNGsvb3N4Q0pCTVVWZm1XTzlC?=
 =?utf-8?B?TWoxVGsvRWZ6TVAxOXN6MGJFVWI1T3AxSEtyRFo5aGRZM1lTUFBZM1NuZnFF?=
 =?utf-8?B?cXlXWnJSeERzVGZNb3dYQW5ieXMwcHBHdTIxR1Rmd2owZXRiNXlqOTNhb0VG?=
 =?utf-8?B?STdHcTBuakM3a0NvbzRKU3UwbitJZTBUUUdDaTNRZnNzUGxOOXEvUmFZeGw4?=
 =?utf-8?B?ODRWNUxlbUFQaWEybThyeW5DSzQ4dlplUG5qS1R0V3FTamU2eWtSdmsrT1Ns?=
 =?utf-8?B?SVFXK1BlMVRTM081ZS9ZVVdKQTI3c0o3SCtJY1hrSDhsSUlWalJBZG55QndB?=
 =?utf-8?B?Z3EySjBoc1NXaXpiRjEwQ1R2TlVDclhRN0pRbFpST0hMYkVVUEZoUkowSlBv?=
 =?utf-8?B?cHFmK01oZnRlS3J0Q25ZZ2FZU20zUkN2UzVOVzQxYWt5d1I4SlpyV21hYTNQ?=
 =?utf-8?B?cGJmTHNOZlpEcit5azZGS2UxbGp5QUYvbXFxM3ZtNlp0dUxYS0dpd2hPQ3I4?=
 =?utf-8?B?NisrdVd2a2ZLVEUyeE1GcXc1djZncWp6MHZTUC9oWjRvWTExMitpaXFIYm1H?=
 =?utf-8?B?RCtBVXVVTXRidEZ3RjhlRVVReEQzaEtoUW5xZ3dadE04TERIdkt1K282UDN2?=
 =?utf-8?B?a2tUTlJ4Wk1yc3l3MlZyZ1Z1cmYyK3VUbHdaazZBcmQrbWhLdWkrcHJ5cGlt?=
 =?utf-8?B?cHJsd1JUTGlFMmVZODZLTlhuWXU4ZGVZTWhoZzdya2FhOGl6VFNYNitEYXNx?=
 =?utf-8?B?VlpSOUQzSCtrd0lrcitiL0NZNHhQK1B3T2haaDRhN0RHMlY1OVVVMHVxQUFU?=
 =?utf-8?B?eHYvSWVoVjNjQncxLzFQWGpDNnJ4Y2hZSFVxazliMWJFaVZHZ05LOTd3UmQ5?=
 =?utf-8?B?OG1OYW5KaHZOaUhHZDN0R090NjBSWm5JbithanJpUnpRME83Y2R3WEV6NkNS?=
 =?utf-8?B?aVo0cG1sSFJTVC94U0xwQ2lqZmxNTGpraE4wU1dTSm9XNXlpRDVFbEErMW5Z?=
 =?utf-8?B?ZjhMeEFGU3ExUDR2RytzUWk0UCs3c1p5bFc2NVBXa3Q5WGhNaVFzVlFxd2w3?=
 =?utf-8?B?WXZ5cVcxYUNmSWN0RU9QbE5YOUZKQzEwTEZqcEl5bVQvcWVwQkwydjVqRW5Z?=
 =?utf-8?B?WStITHpyRVFwT1pnZm5UQnptZ3Npdnl4dGE1UTJUWUVuSitid3lIMXJDNE5L?=
 =?utf-8?B?WUN5cmtjM1k2SlcrLzd6N2lPKytQdkN0cU5VdWVSbU5oV0d2NUZQT0xQaFdi?=
 =?utf-8?B?bVpjaHZyNDU1cVBYaWRPOWR4UTZBalQ3WG5hSW9WUGFKa1FqR05yYXhtbTVJ?=
 =?utf-8?B?UldvWTNvcGl0QnVVUW5qaE5hQTIwTkM0NUo5S2JQd3hza0p6Y1VzR0JKMktV?=
 =?utf-8?B?TGpSaVk1REtwbGJ3OC81Ym9EVnJ2amVVaDFyVUFWR2hvMjVEbUxjWFZsdkdX?=
 =?utf-8?B?UmlNdTlTUHpkMGJ3VCswdjRidENidFhEcE1ueTVWOXo2WUM3akdWSllzdzZS?=
 =?utf-8?B?M01uSUp5TC9qWTA0akhCaEp5WUJYKy9RZGw2M1M3citacVVwVko0SWY0TDFx?=
 =?utf-8?B?QWlnRDNBZ0ZtWFZjTUxkSS9zTlNPZENWYnlyRDI4djZpSzFJWW1oSGJaQzdP?=
 =?utf-8?B?eU14aUltcW1wSTk5U3c1V0VhU2pOTXdDeVhpQzltWk1FUUFuNFNmdWRqbnM5?=
 =?utf-8?B?citqVmhDTGdZQUxaVjJQK3N2d3hueUJMLzlLYkZXRnlQMW9tUmxCVjVGcHBF?=
 =?utf-8?B?L2VwdEF5djN0U1d4Y0xVSE5XM1dwZ3MxeGpqTmVpb0QrY3FUeUhrd21XNmp0?=
 =?utf-8?Q?yNpFCX//F6sPIKeKlkL2Iim+O8ScjZIMkWk2T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 959ed24c-d476-4d61-56df-08dba8748904
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I6iqGdpeA2fnSKWwG29v8HyoaUuqx4qQYonru8l74YZ8oncAI9jf74StygdvZJMzJaviKycshHclzciziy1+/g/0e8dr7Q62n9TTcc6m4PUfWzyme+gRggi3yYo965cXGJM70QJam1bc4oBEIuUtPXKrvAzUOkhmL/6Witnu7uki2nDHC7sjI6jjhQ4qNDK3+wKOVKpa42dSjnxFIe0XThl4v/89tR9Oi6Nnl69BDbIczNRCyH7KBiie1VPSvY4L
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 14:31:59.2125 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4351
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

--------------hrK5UbCytPktlYeWoLWOSnOF
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

*sigh* yeah that's exactly what we have seen before as well. Let me know=20
when you need help with that.

Regards,
Christian.

Am 29.08.23 um 08:17 schrieb Zhang, Yifan:
>
> [AMD Official Use Only - General]
>
>
> Validated on Phoenix and Raphael w/ IOMMU remapping mode, and found=20
> random page fault when launching Xorg. I will debug this issue and=20
> update the patch.
>
> Best Regards,
>
> Yifan
>
> *From:* Deucher, Alexander <Alexander.Deucher@amd.com>
> *Sent:* Tuesday, August 29, 2023 2:06 AM
> *To:* Koenig, Christian <Christian.Koenig@amd.com>; Zhang, Yifan=20
> <Yifan1.Zhang@amd.com>; Christian K=C3=B6nig=20
> <ckoenig.leichtzumerken@gmail.com>; amd-gfx@lists.freedesktop.org
> *Subject:* Re: [PATCH v3 2/2] drm/amdgpu: Put page tables to GTT=20
> memory for gfx10 onwards APUs
>
> [AMD Official Use Only - General]
>
> Technically the AMD IOMMU uses direct mapping mode for any device=20
> which claims to support ATS in order to support the IOMMUv2=20
> functionality, but that was also the case with Raven systems which=20
> were problematic when remapping mode was enabled.=C2=A0 That said, now th=
at=20
> IOMMUv2 support has been removed, there's no reason to use direct=20
> mapping in the IOMMU driver so that may change.
>
> Alex
>
> ------------------------------------------------------------------------
>
> *From:*Koenig, Christian <Christian.Koenig@amd.com>
> *Sent:* Monday, August 28, 2023 7:30 AM
> *To:* Zhang, Yifan <Yifan1.Zhang@amd.com>; Christian K=C3=B6nig=20
> <ckoenig.leichtzumerken@gmail.com>; amd-gfx@lists.freedesktop.org=20
> <amd-gfx@lists.freedesktop.org>
> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>
> *Subject:* Re: [PATCH v3 2/2] drm/amdgpu: Put page tables to GTT=20
> memory for gfx10 onwards APUs
>
> Well, there seems to be a very basic misunderstood here: The IOMMU
> isolation level is *not* ASIC dependent!
>
> Try to set amd_iommu=3Dforce_isolation on the kernel command line.
>
> This is a configuration option customers can use to harden their systems
> and when this isn't properly tested we can't allow page tables in system
> memory.
>
> Regards,
> Christian.
>
> Am 28.08.23 um 13:23 schrieb Zhang, Yifan:
> > [Public]
> >
> > Not yet. It will be only enabled for gfx10.3.3 and later APU=20
> initially, IOMMU is pass through in these ASIC.
> >
> > -----Original Message-----
> > From: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>
> > Sent: Monday, August 28, 2023 5:41 PM
> > To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,=20
> Christian <Christian.Koenig@amd.com>
> > Subject: Re: [PATCH v3 2/2] drm/amdgpu: Put page tables to GTT=20
> memory for gfx10 onwards APUs
> >
> > Is that now validated with IOMMU in non pass through mode?
> >
> > Christian.
> >
> > Am 28.08.23 um 10:58 schrieb Zhang, Yifan:
> >> [AMD Official Use Only - General]
> >>
> >> Ping
> >>
> >> -----Original Message-----
> >> From: Zhang, Yifan <Yifan1.Zhang@amd.com>
> >> Sent: Friday, August 25, 2023 8:34 AM
> >> To: amd-gfx@lists.freedesktop.org
> >> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,=20
> Christian <Christian.Koenig@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
> >> Subject: [PATCH v3 2/2] drm/amdgpu: Put page tables to GTT memory=20
> for gfx10 onwards APUs
> >>
> >> To decrease VRAM pressure for APUs, put page tables to GTT domain=20
> for gfx10 and newer APUs.
> >>
> >> v2: only enable it for gfx10 and newer APUs (Alex, Christian)
> >>
> >> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> >> ---
> >>=C2=A0=C2=A0=C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 9 ++++++=
---
> >>=C2=A0=C2=A0=C2=A0 1 file changed, 6 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c=20
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> >> index 96d601e209b8..4603d87c61a0 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> >> @@ -515,10 +515,13 @@ int amdgpu_vm_pt_create(struct amdgpu_device=20
> *adev, struct amdgpu_vm *vm,
> >>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bp.size =
=3D amdgpu_vm_pt_size(adev, level);
> >>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bp.byte_al=
ign =3D AMDGPU_GPU_PAGE_SIZE;
> >>
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!adev->gmc.is_app_apu)
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 bp.domain =3D AMDGPU_GEM_DOMAIN_VRAM;
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (adev->gmc.is_app_apu ||
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ((adev->flags & AMD_IS_APU) &&
> >> + (adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(10, 3, 3))))
> >>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bp.domain =3D AMDGPU_GEM_DOMAIN_GTT=
;
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 bp.domain =3D AMDGPU_GEM_DOMAIN_VRAM;
> >> +
> >>
> >>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bp.domain =
=3D amdgpu_bo_get_preferred_domain(adev, bp.domain);
> >>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bp.flags =
=3D AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
> >> --
> >> 2.37.3
> >>
>

--------------hrK5UbCytPktlYeWoLWOSnOF
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
  </head>
  <body>
    *sigh* yeah that's exactly what we have seen before as well. Let me
    know when you need help with that.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <div class=3D"moz-cite-prefix">Am 29.08.23 um 08:17 schrieb Zhang,
      Yifan:<br>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:CY5PR12MB6369A28D10CBB70F702C507A=
C1E7A@CY5PR12MB6369.namprd12.prod.outlook.com">
     =20
      <meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered
        medium)">
      <!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]-->
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Aptos;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}span.EmailStyle21
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
      <p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt=
;font-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left"=
>
        [AMD Official Use Only - General]<br>
      </p>
      <br>
      <div>
        <div class=3D"WordSection1">
          <p class=3D"MsoNormal">Validated on Phoenix and Raphael w/ IOMMU
            remapping mode, and found random page fault when launching
            Xorg. I will debug this issue and update the patch.<o:p></o:p><=
/p>
          <p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
          <div>
            <p class=3D"MsoNormal">Best Regards,<o:p></o:p></p>
            <p class=3D"MsoNormal">Yifan<o:p></o:p></p>
          </div>
          <p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
          <div>
            <div style=3D"border:none;border-top:solid #E1E1E1
              1.0pt;padding:3.0pt 0in 0in 0in">
              <p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander
                <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:Alexander=
.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a> <br>
                <b>Sent:</b> Tuesday, August 29, 2023 2:06 AM<br>
                <b>To:</b> Koenig, Christian
                <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:Christian=
.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Zhang, Yifan
                <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:Yifan1.Zh=
ang@amd.com">&lt;Yifan1.Zhang@amd.com&gt;</a>; Christian K=C3=B6nig
                <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:ckoenig.l=
eichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a>;
                <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:amd-gf=
x@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                <b>Subject:</b> Re: [PATCH v3 2/2] drm/amdgpu: Put page
                tables to GTT memory for gfx10 onwards APUs<o:p></o:p></p>
            </div>
          </div>
          <p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
          <p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-fa=
mily:&quot;Arial&quot;,sans-serif;color:blue">[AMD
              Official Use Only - General]<o:p></o:p></span></p>
          <p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
          <div>
            <div>
              <p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-f=
amily:&quot;Aptos&quot;,sans-serif;color:black">Technically
                  the AMD IOMMU uses direct mapping mode for any device
                  which claims to support ATS in order to support the
                  IOMMUv2 functionality, but that was also the case with
                  Raven systems which were problematic when remapping
                  mode was enabled.&nbsp; That said, now that IOMMUv2 suppo=
rt
                  has been removed, there's no reason to use direct
                  mapping in the IOMMU driver so that may change.<o:p></o:p=
></span></p>
            </div>
            <div>
              <p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-f=
amily:&quot;Aptos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p=
>
            </div>
            <div>
              <p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-f=
amily:&quot;Aptos&quot;,sans-serif;color:black">Alex<o:p></o:p></span></p>
            </div>
            <div>
              <p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-f=
amily:&quot;Aptos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p=
>
            </div>
            <div class=3D"MsoNormal" style=3D"text-align:center" align=3D"c=
enter">
              <hr width=3D"98%" size=3D"2" align=3D"center">
            </div>
            <div id=3D"divRplyFwdMsg">
              <p class=3D"MsoNormal"><b><span style=3D"color:black">From:</=
span></b><span style=3D"color:black"> Koenig, Christian &lt;<a href=3D"mail=
to:Christian.Koenig@amd.com" moz-do-not-send=3D"true" class=3D"moz-txt-link=
-freetext">Christian.Koenig@amd.com</a>&gt;<br>
                  <b>Sent:</b> Monday, August 28, 2023 7:30 AM<br>
                  <b>To:</b> Zhang, Yifan &lt;<a href=3D"mailto:Yifan1.Zhan=
g@amd.com" moz-do-not-send=3D"true" class=3D"moz-txt-link-freetext">Yifan1.=
Zhang@amd.com</a>&gt;;
                  Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.leicht=
zumerken@gmail.com" moz-do-not-send=3D"true" class=3D"moz-txt-link-freetext=
">ckoenig.leichtzumerken@gmail.com</a>&gt;;
                  <a href=3D"mailto:amd-gfx@lists.freedesktop.org" moz-do-n=
ot-send=3D"true" class=3D"moz-txt-link-freetext">amd-gfx@lists.freedesktop.=
org</a>
                  &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org" moz-=
do-not-send=3D"true" class=3D"moz-txt-link-freetext">amd-gfx@lists.freedesk=
top.org</a>&gt;<br>
                  <b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexa=
nder.Deucher@amd.com" moz-do-not-send=3D"true" class=3D"moz-txt-link-freete=
xt">Alexander.Deucher@amd.com</a>&gt;<br>
                  <b>Subject:</b> Re: [PATCH v3 2/2] drm/amdgpu: Put
                  page tables to GTT memory for gfx10 onwards APUs</span>
                <o:p></o:p></p>
              <div>
                <p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
              </div>
            </div>
            <div>
              <div>
                <p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Well,
                  there seems to be a very basic misunderstood here: The
                  IOMMU
                  <br>
                  isolation level is *not* ASIC dependent!<br>
                  <br>
                  Try to set amd_iommu=3Dforce_isolation on the kernel
                  command line.<br>
                  <br>
                  This is a configuration option customers can use to
                  harden their systems <br>
                  and when this isn't properly tested we can't allow
                  page tables in system <br>
                  memory.<br>
                  <br>
                  Regards,<br>
                  Christian.<br>
                  <br>
                  Am 28.08.23 um 13:23 schrieb Zhang, Yifan:<br>
                  &gt; [Public]<br>
                  &gt;<br>
                  &gt; Not yet. It will be only enabled for gfx10.3.3
                  and later APU initially, IOMMU is pass through in
                  these ASIC.<br>
                  &gt;<br>
                  &gt; -----Original Message-----<br>
                  &gt; From: Christian K=C3=B6nig &lt;<a href=3D"mailto:cko=
enig.leichtzumerken@gmail.com" moz-do-not-send=3D"true" class=3D"moz-txt-li=
nk-freetext">ckoenig.leichtzumerken@gmail.com</a>&gt;<br>
                  &gt; Sent: Monday, August 28, 2023 5:41 PM<br>
                  &gt; To: Zhang, Yifan &lt;<a href=3D"mailto:Yifan1.Zhang@=
amd.com" moz-do-not-send=3D"true" class=3D"moz-txt-link-freetext">Yifan1.Zh=
ang@amd.com</a>&gt;;
                  <a href=3D"mailto:amd-gfx@lists.freedesktop.org" moz-do-n=
ot-send=3D"true" class=3D"moz-txt-link-freetext">amd-gfx@lists.freedesktop.=
org</a><br>
                  &gt; Cc: Deucher, Alexander &lt;<a href=3D"mailto:Alexand=
er.Deucher@amd.com" moz-do-not-send=3D"true" class=3D"moz-txt-link-freetext=
">Alexander.Deucher@amd.com</a>&gt;;
                  Koenig, Christian &lt;<a href=3D"mailto:Christian.Koenig@=
amd.com" moz-do-not-send=3D"true" class=3D"moz-txt-link-freetext">Christian=
.Koenig@amd.com</a>&gt;<br>
                  &gt; Subject: Re: [PATCH v3 2/2] drm/amdgpu: Put page
                  tables to GTT memory for gfx10 onwards APUs<br>
                  &gt;<br>
                  &gt; Is that now validated with IOMMU in non pass
                  through mode?<br>
                  &gt;<br>
                  &gt; Christian.<br>
                  &gt;<br>
                  &gt; Am 28.08.23 um 10:58 schrieb Zhang, Yifan:<br>
                  &gt;&gt; [AMD Official Use Only - General]<br>
                  &gt;&gt;<br>
                  &gt;&gt; Ping<br>
                  &gt;&gt;<br>
                  &gt;&gt; -----Original Message-----<br>
                  &gt;&gt; From: Zhang, Yifan &lt;<a href=3D"mailto:Yifan1.=
Zhang@amd.com" moz-do-not-send=3D"true" class=3D"moz-txt-link-freetext">Yif=
an1.Zhang@amd.com</a>&gt;<br>
                  &gt;&gt; Sent: Friday, August 25, 2023 8:34 AM<br>
                  &gt;&gt; To: <a href=3D"mailto:amd-gfx@lists.freedesktop.=
org" moz-do-not-send=3D"true" class=3D"moz-txt-link-freetext">amd-gfx@lists=
.freedesktop.org</a><br>
                  &gt;&gt; Cc: Deucher, Alexander &lt;<a href=3D"mailto:Ale=
xander.Deucher@amd.com" moz-do-not-send=3D"true" class=3D"moz-txt-link-free=
text">Alexander.Deucher@amd.com</a>&gt;;
                  Koenig, Christian &lt;<a href=3D"mailto:Christian.Koenig@=
amd.com" moz-do-not-send=3D"true" class=3D"moz-txt-link-freetext">Christian=
.Koenig@amd.com</a>&gt;;
                  Zhang, Yifan &lt;<a href=3D"mailto:Yifan1.Zhang@amd.com" =
moz-do-not-send=3D"true" class=3D"moz-txt-link-freetext">Yifan1.Zhang@amd.c=
om</a>&gt;<br>
                  &gt;&gt; Subject: [PATCH v3 2/2] drm/amdgpu: Put page
                  tables to GTT memory for gfx10 onwards APUs<br>
                  &gt;&gt;<br>
                  &gt;&gt; To decrease VRAM pressure for APUs, put page
                  tables to GTT domain for gfx10 and newer APUs.<br>
                  &gt;&gt;<br>
                  &gt;&gt; v2: only enable it for gfx10 and newer APUs
                  (Alex, Christian)<br>
                  &gt;&gt;<br>
                  &gt;&gt; Signed-off-by: Yifan Zhang &lt;<a href=3D"mailto=
:yifan1.zhang@amd.com" moz-do-not-send=3D"true" class=3D"moz-txt-link-freet=
ext">yifan1.zhang@amd.com</a>&gt;<br>
                  &gt;&gt; ---<br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amd=
gpu_vm_pt.c
                  | 9 ++++++---<br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp; 1 file changed, 6 insertions(+=
), 3
                  deletions(-)<br>
                  &gt;&gt;<br>
                  &gt;&gt; diff --git
                  a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
                  b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c<br>
                  &gt;&gt; index 96d601e209b8..4603d87c61a0 100644<br>
                  &gt;&gt; ---
                  a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c<br>
                  &gt;&gt; +++
                  b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c<br>
                  &gt;&gt; @@ -515,10 +515,13 @@ int
                  amdgpu_vm_pt_create(struct amdgpu_device *adev, struct
                  amdgpu_vm *vm,<br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; bp.size =3D amdgpu_vm_pt_size(adev,
                  level);<br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; bp.byte_align =3D
                  AMDGPU_GPU_PAGE_SIZE;<br>
                  &gt;&gt;<br>
                  &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-=
&gt;gmc.is_app_apu)<br>
                  &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.domain =3D
                  AMDGPU_GEM_DOMAIN_VRAM;<br>
                  &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
                  &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&=
gt;gmc.is_app_apu ||<br>
                  &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((adev-&gt;flags &amp;
                  AMD_IS_APU) &amp;&amp;<br>
                  &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  (adev-&gt;ip_versions[GC_HWIP][0] &gt;=3D IP_VERSION(10,
                  3, 3))))<br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.domain =3D
                  AMDGPU_GEM_DOMAIN_GTT;<br>
                  &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
                  &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.domain =3D
                  AMDGPU_GEM_DOMAIN_VRAM;<br>
                  &gt;&gt; +<br>
                  &gt;&gt;<br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; bp.domain =3D
                  amdgpu_bo_get_preferred_domain(adev, bp.domain);<br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; bp.flags =3D
                  AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |<br>
                  &gt;&gt; --<br>
                  &gt;&gt; 2.37.3<br>
                  &gt;&gt;<o:p></o:p></p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------hrK5UbCytPktlYeWoLWOSnOF--
