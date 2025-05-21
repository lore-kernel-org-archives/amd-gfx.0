Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06203C2D0CD
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 09:04:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8064E10E6C9;
	Wed, 21 May 2025 09:04:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wagil6Je";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EA2710E6C9
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 09:04:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sldEhH8aMoNnwdF1YSPxULVaalMUxMdD22BVM0fccZBawq29GIRkCWipkFEFLEv2FqRD9rAZu49AtYu8rFP4e5lSM7P2c0H+WAvyycsYoPeqkvmn9SeCYcb5tZhA/8nxbg/T6rVr/J22Vhdao/npf1jF1YqCWHfIYipboxrWPgb7PM6DC37kvNiCYNxLuksHLzuACk0pmnkpqzCVAlxMEPrM6ycORtaDdd86rMHSzOj8fsm63v1mc6LEebvrUCs/6AE2MyuejsbxsgU/OKqXKgUYgJxGcCG/P1L0UPX2dfZ3Ycz67TM1fJoQuorhu5654fhXRUlO2Kb/RUEAl7M5PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=at9LRn14JjlCmQTxhZq6klBVgzjkRX9OAHaJHcvq4AE=;
 b=n1q4uCeskmmuihFc4jzLYZ735j4QGFYhU7Dl0MJZ+vxd3VSp+L9c7d7KRpkd0jpnh0A9jU6/dKmE0ZqORk/PNqYgU2FHRS6Cuw9TkrLsafLClqzvyIvJqszAZqmvv8pD7Abhe/eC0LjlWy+apyE72mvhPt8/vrVdrYfmvzt46vMw9T4RN2vhOBR0jBbafQmQNniZo8NTJ45ff2lzdL/6jeLIFbwGDDn86GGLp32stpTguf5JmNrgkfReJGL9BlSlmJo9Bbw1ZBkSroC9qbTR9JqT/tYkGyQXrpI0FPz8jWYv3eeEOc5XR/wL4nOKZ9by5uAD6hqQ/GovWiadDEUaMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=at9LRn14JjlCmQTxhZq6klBVgzjkRX9OAHaJHcvq4AE=;
 b=Wagil6Je0iko2M6b2HVfWfid3oOjWBVC8KhKY8yulYOphGgbwtW57civu/6qr/fRc8FIpuaxsbrJgMi/UYfaqXa69wVOcyAdyKRLop0HsVnfR5/8Wbw2PR2mnK3snakYhq4bSNkbKxkuZsN86f4yCXiBtQMR6uPaRDRCdoJnJ3A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB7134.namprd12.prod.outlook.com (2603:10b6:510:22d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 09:03:57 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Wed, 21 May 2025
 09:03:57 +0000
Message-ID: <7d523eba-7706-409a-aeef-5dc6ef309e24@amd.com>
Date: Wed, 21 May 2025 11:03:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] drm/amdgpu: rework queue reset scheduler interaction
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20250519182209.18273-1-alexander.deucher@amd.com>
 <20250519182209.18273-2-alexander.deucher@amd.com>
 <CADnq5_OWC6ueeMbsgmahQuAULjms3c-dWfFRNLibmrEVMP9KvQ@mail.gmail.com>
 <ce89c13b-a7ad-424e-9cad-141b97138e64@amd.com>
 <CADnq5_PrNiZmgUnBH_p9w70wyczK6RtQnNptKQS9FO7ERHhaPg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_PrNiZmgUnBH_p9w70wyczK6RtQnNptKQS9FO7ERHhaPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0154.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB7134:EE_
X-MS-Office365-Filtering-Correlation-Id: 12625c2c-e313-4d72-3d46-08dd98466ad7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rk42Qm1PUnMvT04yMzd6SERWbHdVaXNBdSt1OEQwU0pTcXNJcUVoU3VzTnJX?=
 =?utf-8?B?Zno2bWVpSm5tV1pxQVVZSFhkaWtxcDJWZTRvbUE1eGpldktiNWlocWZqRUpr?=
 =?utf-8?B?UStwUlFBL3ZzdnVRUFlJdGRyeHB3eE5VcFh1N1VyOWdYOGFPNWhCdXgxUGg4?=
 =?utf-8?B?ek9YNlFla21YQjZ3RzRmRTdnMG53ZFd4Mk1uNmpQQmFUcHBucEJQbmhZMktE?=
 =?utf-8?B?a1NGZjNGaW9QU2hDbFQ4VzZQRlMvdzFYdkJVS0F1V1FWMkZRM3pQcjZybjVQ?=
 =?utf-8?B?ZWtjMzNNT0FydVNxaXVWdm12VGFEcGlvLzAyT0hmTkdFRlh4bUxDbDVlMXRW?=
 =?utf-8?B?dWpGM3pmdmx4REpENWtyNUhQZzRQN2Y0RUZmbm9meGhiRzk1VlJkUXZYdk15?=
 =?utf-8?B?VXZKSTdQN21Ib2JieEdnWVVKWVpzWTlQQ05zZ2RQdWZhR2R1V2V4SmxCOFlm?=
 =?utf-8?B?WFZ4T2NhY3BJU3E3akF6Z2tpMnkwTlBnQ3Zndjh2NXpjdU9JdXdaVFlSaGox?=
 =?utf-8?B?N2MxTXgrcFVvK0JmREV3b2lGRCtTNDcybkxNQ24wYWlBWnFid3ZmWlRDVDN5?=
 =?utf-8?B?alFieE80U2pkOHVCT3JhTWQrN2pPUFVpaWRteUZGTHR5aldkeENNU2R0M1pJ?=
 =?utf-8?B?aitQaVBIdXcwRW5zMDRoTi9uWktCUS9Kc1U3SDRYOVdKSmp3YWUra1BTamU4?=
 =?utf-8?B?ZDJ1UVZ6S1QrNCtRQmdqV1lManV0Um1LV20zT00rTjhUR2xRZkFTdFd3dGR6?=
 =?utf-8?B?VXh4ZVV6VlVYeE1WRHZwOTBTck80cXBHTEZBSGp3M1A0bU5ObUhqWTNZbUww?=
 =?utf-8?B?NjFIOXZSZjVrbXpTQVM4RzAzSWh2MXpWNGhKejVpNm1NdkpmVDY3SW10elMy?=
 =?utf-8?B?NVpVcTk4L0tSUitMc0lyRm4wNHhPeUdXZDZ6RHlGbzUvRUtEaVFJdEZ0WG40?=
 =?utf-8?B?bTJ2UUh3Z1JaS3JqWXptOHRaeC82SG4rb1lnWG5rMmVQd29McHF2cjcvWVJL?=
 =?utf-8?B?aGRkdUV6QXJtaTI0V3Izdk5vZExlN0ZHZkZvQTJrdlc0VTBnbWltTXdXQlVk?=
 =?utf-8?B?MnBpbXNnV3hwWXErK1BQTkZpVTExc0xBOXR5Q2JnUi9DclBwOWFManRWZGhw?=
 =?utf-8?B?MGdhendHVTdpaThoWWtKNHNyQm9JdlF6RTladkJ5M2lVeXVtbUR1cDhnSjA0?=
 =?utf-8?B?Q3VaeW5vbVZtbjhQMUVWS2doVFhiYXJ2OTNoZHRHM2RIZlJXL0pVcDVtTlAv?=
 =?utf-8?B?Z1hWZGRRYWtWbUw5cHp6d3krTzVnY3JTU0pUWkNFbDBXV25GYm5oQWZwRmM3?=
 =?utf-8?B?aHhWUVp2SFluUjFOdjY3U1BPMTh1SHlUV0c2cjRBdXM5SkxkUGhUeWVmOXk2?=
 =?utf-8?B?UXo5Y0FsSi9EaXUxd2U0aDNyWlFzekxzVW1PL3licjZJcXJ1Ris3SUdBUE8r?=
 =?utf-8?B?Nk13TW40RkxWcy9pZWdvTWZVRllpOEMvV3prNkFRT0lNVFFUb1B5TU9RajRJ?=
 =?utf-8?B?Wkp0TFdFY0oxOTd4S3BTU08yZlVlekZCL3NNOEVYWXJYNFBVck10Z21MT3lR?=
 =?utf-8?B?c0NJSE5MM3hkTGJaZWhydXNlTlF3VzRSU1VmTGtFcDkybjJQZTQzWGM1Ti9B?=
 =?utf-8?B?UzR1cVh3RFZJbHFLOGpER1ZaZzlrNHpHY1R3UW1tOGFNQXo2TU53U2dPR1Za?=
 =?utf-8?B?bjJnOWI0MWRkZ2w2Nmx3VWxNVEJvR0ZvU0wrQ2d5VEhhaHBZaHhVblJJb1Bp?=
 =?utf-8?B?VWtzbHZKYnFyUmVMek1ML3EvM3Y3NDJoK1JDMWVWcmNoZ3FvekQ3TjM3TTFj?=
 =?utf-8?B?c1p2VkRFQm1XSVlMTXBiNllRaEV2cjlBSTBYdm5EWjRrdGwxRXpnbDZ0d1Uv?=
 =?utf-8?B?OE5CaVovQkVHT2FudU5md1JodGxNMkF5Y3Z1Y2l1ZytRV1dVYThXcS90c1NB?=
 =?utf-8?Q?zClP3jv9WZk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3RnanJ0ZmRvLzE4ekFsRmtJbGZ1Z0lOWGc4dko0Nkdsc25XazBLL0dCdDdl?=
 =?utf-8?B?RGg2RzJYTTlVQXZoTWNNa0JxL0JMUzMrQ0xibS9KcEhaTGtNUVQvTDNFdEJz?=
 =?utf-8?B?aFhWdlJ1aDBRd05xbGNtNWJaRGd1aEF2YSsvWnZlbERBclZORHFzaEJONUZ3?=
 =?utf-8?B?bjBOR01mT0EzWDF4SlB1eDFRT1hkSDYxdGtYOFRJazJrdjdXejdEbXE1N250?=
 =?utf-8?B?SUt3R0ZsU2NIdjN5bUE3WFduMTUyWUM2TWxSc1IralF1L1pKUlFySU9HeTFy?=
 =?utf-8?B?Sy9ZYXh0dHV0R2hORlAzdlphc2plVHJPTksySnIxWWlXUVVSbm4wNEUvbGpt?=
 =?utf-8?B?bXdqTDhvZU5tN21IUUxDSCs3eVMvakROSzVqdXk4RGpjZmR0eXZjMC9oQVNw?=
 =?utf-8?B?dlYrbTFHVnBEdWJLbjh2d0YrZUs4RWxRUTRTbkhMUnhRSEhBZWNUUzFYU1BI?=
 =?utf-8?B?MlplLzJsRXhyL2JxWjl4c05rOW1hTWs1Zldzbjh1UDAxNCtXWFpsREtvNUx4?=
 =?utf-8?B?T2pqQXJtSjdSTlhOQ1RoSGRkR2diSGpEWG9rOXJOSERNaVRqT09tVnVkRDZJ?=
 =?utf-8?B?UExhRFBBYVRVZm10Ly8rTHRXMDlVbVJaVEZqaExqb0F2RFZCMVpFY0wwWElE?=
 =?utf-8?B?d2FQL3N0SzN6RzRuemZMYWQzUGNIYVl1bGFIbk0zREtZR2ZNZUVLbTdvWFZI?=
 =?utf-8?B?OWNPbDRwL2JZbXluNmNPY0lLUW5XQmJHWHVETHpBZ1RhOFhROGxKdERUNWNi?=
 =?utf-8?B?TWt2Z21McmV1ZkFiVUNSWmRIM1ZwWDRJb1U4akxveXlPSGR3NWt4V2hiR0tJ?=
 =?utf-8?B?Vmw1SmpHUVFndE42a0htY0VLWUk2YnVteFoyamZZNVdEajlSLzFoaG5rVk4x?=
 =?utf-8?B?RG90LzVYZTVvREllUTM0T1RrRkhxSmwxTEI4NTNpbjVZQkFGWnR2U2NJWGdl?=
 =?utf-8?B?eUVnNnZEbGtFR0lHbDdtWFhIYzd4Zk9FWEhMeFAza2wrTjJDRlAyTE95MXJs?=
 =?utf-8?B?LzRFRGpreUdZWlRLV2lDckRDcWtzOEo5QlJVUk5pakZrT0l5YUhMUng5NGlE?=
 =?utf-8?B?WTNLS25zZEZFWDZEN1ZsOGpJaUhBQVRMTXZPWkp5WmN5dGVEbGg0eWJseDB4?=
 =?utf-8?B?RnN6ODRSbmxPanVJMVNIREhhTVlRa0RaYUFjVThyK0RhTUNjRGpjYjVKWUJw?=
 =?utf-8?B?VldIbDVCWDNiQ3FhV0g2MjB3K2xXQldLb2Z4K3ExenloRzZoQlo3em1ma3BH?=
 =?utf-8?B?aGgvL3F0eXJRWlI2aERCMUMvS0lDMjBlUDhza3VQNFhmU1ZuaGY3S21QTWpN?=
 =?utf-8?B?Qk1kYmxoRGZQYmZGZGNVODlJaW5aeW8yWkhDWHVwQmhmY1poQW81ZGpGemdx?=
 =?utf-8?B?Z3lDcitFM1ZkRWtJNDIyeDNtS0h6ZjZnNjVidG92bWlpNW5TZmR0SE04eFhD?=
 =?utf-8?B?UE5zQXNBWTZGQjB0cEVleTB5QmgyTnltd0FhU3YrR3lBWW1CbnkyelFjNDBT?=
 =?utf-8?B?clNqL3pBOXNyRno3cWdJTVVKUlQ3MDlCb05OWERLaFlMNS9tUDh1UmU4ZHlv?=
 =?utf-8?B?eStKWm1tM1VaSW1iS0h3S1ZCdXlIdHhtZFRZYnpNWXFjL1BMYzNUQy9BYnpD?=
 =?utf-8?B?cHdncTNJd0hJb1UzM1RjaTlBWWQyOGlHK213TUV2d29ZWUN4VjM2ZmxIL29T?=
 =?utf-8?B?N0lSNEphZXN1eGNycGZGd1lPejJSSUxqbXdJalJvbEJFRnJPNzMxWWhpWHpO?=
 =?utf-8?B?dDlFME5GRFI4QXhUZnhrUTJ6QUdHbnBrVXlSNkhEU1dDR056WERRNHJWcGVI?=
 =?utf-8?B?a0VMMVNnZlp4ZFdKNk5yL05RK0p2Y05sdjBQWlp4S1RIS2IrUVlscnY5aE1k?=
 =?utf-8?B?SUpEcDVIM0JBNnlrYmtIWGNzcnhXck5tMms2T0pybFpKaThUOXZEbldNQ3BV?=
 =?utf-8?B?V2hnaDhyWll6RmMzakM4RHI2eTFwU29EL2lIcU5SbGRITjV4YjdnRWY3RVJJ?=
 =?utf-8?B?dEV2NWJSTUNPV2IxcXRMVFVyMVd2U09uOEEzY2JGb2xtdE95ZnJKVEJic1Jv?=
 =?utf-8?B?d3lNcjhia0xCMzNtSGZXMDZsY0Q3WnZ2bXQ5K1B6U1l5WHNIZnhFd3BCMkxP?=
 =?utf-8?Q?e9gxMtgzU9tZFal0yB2bc2kSN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12625c2c-e313-4d72-3d46-08dd98466ad7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 09:03:57.2316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ogOW2G8gFzzHXPsTFmpnVB0DlIc/2Ct588ABy57GfKbHSEXX4BjWA3HfdsQCqQsl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7134
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

On 5/20/25 18:38, Alex Deucher wrote:
> On Tue, May 20, 2025 at 9:49 AM Christian König
> <christian.koenig@amd.com> wrote:
>>
>> On 5/20/25 15:09, Alex Deucher wrote:
>>> On Mon, May 19, 2025 at 2:30 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>>>>
>>>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>>>>
>>>> Stopping the scheduler for queue reset is generally a good idea because
>>>> it prevents any worker from touching the ring buffer.
>>>>
>>>> But using amdgpu_fence_driver_force_completion() before restarting it was
>>>> a really bad idea because it marked fences as failed while the work was
>>>> potentially still running.
>>>>
>>>> Stop doing that and cleanup the comment a bit.
>>>>
>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>> ---
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 27 ++++++++++++-------------
>>>>  1 file changed, 13 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>> index acb21fc8b3ce5..a0fab947143b5 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>> @@ -136,10 +136,12 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>>>>         } else if (amdgpu_gpu_recovery && ring->funcs->reset) {
>>>>                 bool is_guilty;
>>>>
>>>> -               dev_err(adev->dev, "Starting %s ring reset\n", s_job->sched->name);
>>>> -               /* stop the scheduler, but don't mess with the
>>>> -                * bad job yet because if ring reset fails
>>>> -                * we'll fall back to full GPU reset.
>>>> +               dev_err(adev->dev, "Starting %s ring reset\n",
>>>> +                       s_job->sched->name);
>>>> +
>>>> +               /*
>>>> +                * Stop the scheduler to prevent anybody else from touching the
>>>> +                * ring buffer.
>>>>                  */
>>>>                 drm_sched_wqueue_stop(&ring->sched);
>>>>
>>>> @@ -157,19 +159,16 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>>>>
>>>>                 r = amdgpu_ring_reset(ring, job->vmid);
>>>>                 if (!r) {
>>>> -                       if (amdgpu_ring_sched_ready(ring))
>>>> -                               drm_sched_stop(&ring->sched, s_job);
>>>> -                       if (is_guilty) {
>>>> +                       if (is_guilty)
>>>>                                 atomic_inc(&ring->adev->gpu_reset_counter);
>>>> -                               amdgpu_fence_driver_force_completion(ring);
>>>
>>> Do we still need this in the case of rings where we reset the entire
>>> queue?  E.g., compute or VCN?  In which case we should move this to
>>> the ring->reset callback.
>>
>> No, it shouldn't be necessary in the first place as long as the rings still execute their fence packages.
>>
>> And that should be the case at least for both graphics and compute.
>>
>> Forcing completion only makes sense when the whole ASIC was resetted and nothing executed any more.
> 
> This seems to result in a deadlock if you reset the entire queue
> rather than just the vmid.   I.e., if you test with just this patch
> and not any of the following patches.  In that case, the queue is
> reset so none of the fences are signaled.

That is just because of a specific behavior of the GFX/Compute engine.

When fences are issued while a reset is ongoing the CP writes the fence value not to the requested location, but rather to fence_addr + 4. See amdgpu_debugfs_fence_info_show for more details.

That's why I cleared the reset before issuing the fence command in the follow up patches.

Key point is that the stuff still executes and telling the core os that it can release the memory by force completing the fences is a really bad idea in that case.

Regards,
Christian.

> 
> Alex
> 
> 
>>
>> Regards,
>> Christian.
>>
>>
>>>
>>> Alex
>>>
>>>> -                       }
>>>> -                       if (amdgpu_ring_sched_ready(ring))
>>>> -                               drm_sched_start(&ring->sched, 0);
>>>> -                       dev_err(adev->dev, "Ring %s reset succeeded\n", ring->sched.name);
>>>> -                       drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE);
>>>> +                       drm_sched_wqueue_start(&ring->sched);
>>>> +                       dev_err(adev->dev, "Ring %s reset succeeded\n",
>>>> +                               ring->sched.name);
>>>> +                       drm_dev_wedged_event(adev_to_drm(adev),
>>>> +                                            DRM_WEDGE_RECOVERY_NONE);
>>>>                         goto exit;
>>>>                 }
>>>> -               dev_err(adev->dev, "Ring %s reset failure\n", ring->sched.name);
>>>> +               dev_err(adev->dev, "Ring %s reset failed\n", ring->sched.name);
>>>>         }
>>>>         dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
>>>>
>>>> --
>>>> 2.49.0
>>>>
>>

