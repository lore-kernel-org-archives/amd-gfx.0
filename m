Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8283C531DC
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Aug 2024 14:13:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6075D10EB37;
	Fri, 23 Aug 2024 14:13:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qh6ZolIh";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2042.outbound.protection.outlook.com [40.107.100.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D308D10EB37
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Aug 2024 14:13:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WCwDdbBHoyrmp9ob/k2NJSsO9n+DqYht0HI6WvytaR2C+AaI617MGbZQq1DwaHPG9iOIjh5rBy3iO5GiXnc2nkcX4MiI8ABiFQkZ+kuR6UHUrF8MLSedezbxNWhHS3SDhsu5w+ZCJwSByRVnu/W1NG7GLVdqNrXYR4j/uO/987ZB/oDgUYfozq4SAx9PfjjYkn3sF3A7SyK38BvQ8wcAhl+oFDoEKoPnfPX5jV1xDgC0kBDMqu3QT/vOE6Cz9RPW4sSrRZ1aFZ1laoGrcUIHFRplfOrodcVg5swTesAqcvUisqWVusok8AzKt3jYbZs8o/pgUKd6XMt7ZOsEbko38Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwZlJlUJ6VQiIXqcEMg30f/HxyzgEKlGrKsdfmPcQ90=;
 b=mQxLqWHQ8zbBlNTuHHU+4ZEz9XYZijpssDjUqEPIkIKsRiLdnE/Dh9d9rE1mnwsj8FTs161ZeLtWWKLaVJFqWimnD+/8HKcYf7K3I8TLqOUD8Wnx/vi+FQSsxf05Cs6n1gucDbSEWoOOD4nuQ930HOaRjBs/2hb1aNvgLKyvqB5ECVLsssW6pATqjtK9zPEGdqzS5/V0iXyBfUdXRd1ukXVF3hJDfoGOygR0sCLbctLSYNVPPIKWpMxcfvd/darRzJD41iMV0OP52EvZFC+m2NjfyxryYv2iGpdPP+LAIYULv5xUKmrU7kkW6eJWq1oZong70Qc2wa8adDzvDYsysA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwZlJlUJ6VQiIXqcEMg30f/HxyzgEKlGrKsdfmPcQ90=;
 b=Qh6ZolIh4780dRNUfG15VuCHb5UQdnxRDsEZuD7cliYrk+BUmy734Gn2Aam/ERi+EBuOkVGxsif59C5FBvRt6HKrdyzWvNpUxqFJqIRR7v+/Yf1QmjZmbvFP9nbdRb1UOIVQhPmm1Hmd22/JHhr/no4FznL8biISnjlAakiga+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ1PR12MB6099.namprd12.prod.outlook.com (2603:10b6:a03:45e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Fri, 23 Aug
 2024 14:13:44 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7875.016; Fri, 23 Aug 2024
 14:13:44 +0000
Message-ID: <0e8d0a26-3dca-4669-96fc-d9f4bffbe5f6@amd.com>
Date: Fri, 23 Aug 2024 09:13:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Don't wake dGPUs while reading sensors
To: Alex Deucher <alexdeucher@gmail.com>,
 Mario Limonciello <superm1@kernel.org>
Cc: amd-gfx@lists.freedesktop.org
References: <20240820020435.472490-1-superm1@kernel.org>
 <CADnq5_O3uTj_Zu9+iY_k8i2MQhXH=Ac2+GhCe5DeW=CWY6jn4w@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_O3uTj_Zu9+iY_k8i2MQhXH=Ac2+GhCe5DeW=CWY6jn4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0412.namprd03.prod.outlook.com
 (2603:10b6:408:111::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ1PR12MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: 180084d0-1673-45e3-7e92-08dcc37dcc26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R3JtNi9jbllYK3VLcjdVQXp5Y0c3OWs0Y0hQQ3M5SXVMckhmOGx6aEVXSjFm?=
 =?utf-8?B?WXJMb3dmL2ZnWnhEZ2Z1MTZKZHRNY2lrenhBUUVNUEZJOWhETG5SYjlLWHhP?=
 =?utf-8?B?MU1ncGxIbllNMEp6TVQ2QjZpNWUyRm9WMUl5WGxlL0Qrak9oeFJyTklsNXNs?=
 =?utf-8?B?Q2J4bVhFeU9xdlk0VWZlWlZkNWtjRGpjM2JlTEpwcGxtbUtBOFRCYkJhaGdG?=
 =?utf-8?B?YUw2WlRqWWFKN2JHM2lGMnphWHhZMXlESUQxbE0xdE1WWFhnOWlhOTBBNkZN?=
 =?utf-8?B?MWI0WjA5dnIwbWFxTUE1dFlIcHFsYmJSN1VPd0FlSXlocTN0WEl3OFVnS2VG?=
 =?utf-8?B?STlzcUNPajF2ZmM4Z1J3eGRkckgvR2tzeXZVQ0ozWUNybTN1WVQrKzBVRnVq?=
 =?utf-8?B?QVFpcFdNQzdGYTVSY0R5U3BYNFNoSGM4OXRwaW9pcVJkMG00QXM3Nm1vRzFI?=
 =?utf-8?B?aWFkSkNLZklEN2xRRVhnakJwdzlOdkM3aWliam9WWUJ3dDV1QmYwUEYrdTVD?=
 =?utf-8?B?MUdmQmZ4ZU1JR2VPSmRFcnBRL0xWbk9OY0t2dUhCZ292WWFkUFJ2Um9mTlhL?=
 =?utf-8?B?MXVrcUI3dmJxcWFPZ2FkbGhqMWQ0TWJlWERHZmhzVEV6eVUvWnZQMDlVOHda?=
 =?utf-8?B?SVNOYjBObmwxdkdCSnNxbmdPYnM3MnBQNGJTZ1NHd2xIaDRXaXQvQTN5OFVj?=
 =?utf-8?B?WGhSOGRqK01iakFhRnU3c2tiUEp2V2RWZWtZdzZPaUV0Wk5Hc1JDejFJVkZr?=
 =?utf-8?B?czZYSGZTMFdDOFBBeTd6UnJUaStpQ1c3aG5OcFRQTXlRSjh0UCtJTFhsSUpm?=
 =?utf-8?B?N09uSnRWQktYc2cwUjdCYXNBUXJjUS9xOXBSMWsybkZKNm4yaS9tQnNlK0w4?=
 =?utf-8?B?ajA2a1NFaTZyWWc5Y0l5WFV6dk84UGJpdFlnOWxVemh2eEdVRENSaGt3WmxP?=
 =?utf-8?B?QkRxZGY4czZQNGEzS01nYjBZeEFDQ0x1Y20waVhabjROdVJMSm1CWkZIRFlH?=
 =?utf-8?B?Q0hIQTNoSGEwK242TUdqSmhYWDRDWkFJSEtzQ0Y2aElCNkQwTFN4MEpremVq?=
 =?utf-8?B?OWpRMGUrK1pDY1I2YVVTSC80Zyt2SzhLQUZ4cE4vOE9nZnk2RTVWS1NNcDl6?=
 =?utf-8?B?OGNmVXJGNUVNcG9uS0xONUllRElPSWlVM1B5bUJkWDFLU0I4NHBsMUMrTGx5?=
 =?utf-8?B?Z0NTbW01K3ZKdkJFeWtJU2RDandBRWFoMFJWRFRBVlVHWnNGckROUm5ZaFpO?=
 =?utf-8?B?Y0ZYaENpUksyalpwNjY1aFhZd1pYc0VLL2Z4ck8vL1RteXcxV09qRlVURnkr?=
 =?utf-8?B?V1FjcFVXcGczWXZCa2lXekY4Qm5nTDZpMk43RmRmRC9uelNDVXBlTkx3V1pt?=
 =?utf-8?B?eHN5cFpzRWhNNU9tUjMwMEgxZnNYUUZyY1hBVG92WkdHK3Y2VXhMNVdpK0pi?=
 =?utf-8?B?NDFRL285M1Npb2VSWk05KzNUNE9lancyU09qWUlCU2sxR1p5UjJkWTY0YnZr?=
 =?utf-8?B?VFZpUGJzRFArR0dSalZXai83N3pHSXZaMWRyL09uVm9zVXJQVGV2T3pDY3Y2?=
 =?utf-8?B?QkJ0NGxpSGU4MXZkMmlaZlJoS1g4d1UxekFDREhuemgvT0I1dUZmR3hacFNK?=
 =?utf-8?B?NDNpKzFHcUt2RkU2NWRaVEJ2K21aaWFZM0lFSXdsRE83d3NURUlhemJXamJx?=
 =?utf-8?B?WDR2TVdPTlY5NUl3RER3bURWTU5pcDZkazNrWGh5YjFsMmIyeS9CN041MHFY?=
 =?utf-8?B?ZFIvRDc5T3dMNDZ3c09HcFdlTnRiVGYyNm9aVytzZEc0aGdBRzUrOURKRVlG?=
 =?utf-8?B?ZGoyYXZrMVNqRjFSWlhFUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXNGRWZjOWxTRFhiQVB3cGc3NlhKQ2g4NlMwYks0UkxTcW9EZmpZbVpOdmJj?=
 =?utf-8?B?SEdLdHRwaWlQenVsQ29YSFlGSnpRUkh1dkF0VXRtTmxtN2lBS1Z0c29LemFz?=
 =?utf-8?B?akkydkRYN1lZTEtyYjJHMHNzUUthU1I4MUhOQlBLSmVUMmQvQlo1Z1AyYUlt?=
 =?utf-8?B?Qzd2SUxBVnZiMldMUlhmcm8rOXo0dGNUZGloeE16MnlkZ254Ym5YV2R0NSsr?=
 =?utf-8?B?aldSSFZ1eEJnNjhWdzNOdGRtQ0pIYlpnajRacllqdXdkcllUWis0a2VyV0FK?=
 =?utf-8?B?VXp2Q2hYOE5md09XVzdwR2hVRU9QU1dEZXNMcWI5czkvTHJRblNVOHFHYlNJ?=
 =?utf-8?B?MXh3NWhKU3FWSFBiaFlER1ZnQzhLYWtrNXk4b0EyUlJqN3Z6bmZVVWhuSG5s?=
 =?utf-8?B?cFVGWFZrMStyRGNwM1pKZm55Z0hqZlBaN3VubVhQTGJOSUl2SU90MkJkRVlC?=
 =?utf-8?B?S2MwOTF3dDZKZXFMb3V1Q1lLSVVFY1FSYVdqQ3llTVhkUHJnMm5oNk9HQ25Q?=
 =?utf-8?B?U3pCR2JWK091VHBTMU9DWVlQazI4Rmp4bk1lOVlXd3UzTGZrZitESTI1eEZU?=
 =?utf-8?B?UG85aDlFSjJSc3JNMFM4N0JlbjhvSklzQ1pVN3ZFSVhMYkF5RlZwN1I1bURO?=
 =?utf-8?B?RHByVnYvRGFpMjNVZUVpRXZxeDR5endqTFVIN2lsd3doOXNENVNXb29lM1d0?=
 =?utf-8?B?UVFTRkxtL28yWVFtamZlMGJCKzY0RmUxT3M0T0MvR3RZQVBFVmNTT3E3Vjh5?=
 =?utf-8?B?WFY1TlpVWXgzTzIrNE9NamMxZms5YWJWV3UvRkkxc0c3MUo1WGlNaUFwQmlM?=
 =?utf-8?B?UWpjT0RKZTQ0eW1aZXdxY1d1ajlucDM1MGlqRllvU09YU0E5T3YvaUtqb1c2?=
 =?utf-8?B?ZGJRTUJ4TWUvSUNNL2NpbmZlcWs5TGFkdTlqYUlGTXBPOXNpTndaK3doL1cz?=
 =?utf-8?B?aDlLK0pMZzBGNHNmWG42NkNNaVMyeGd0RDF0T2dHRFg2M1F5Y0k1d2VTTmUr?=
 =?utf-8?B?TXFReTBPbkthTmJ1V1FiVjgrYStjdWR3SG01YnpDb1dJVkRXNlVTOEx0bDE0?=
 =?utf-8?B?YzBqRE5vb2hkWHRVQnVDTUZ4UXN0bmF6ZkcrMThFQnY2QVJsSWtZTHJZa0FK?=
 =?utf-8?B?Yk9Kd1JzbmUvNjhBTy84U284MWxtSzk3c2ZzT2E2RmdYK0M4TFNZTTQvSHpj?=
 =?utf-8?B?RHg4cTZ5M2xETjYxNzRUdDI2OU9iVW5rUzgrVlh5QURXMnlQWHdML1g4ZVZG?=
 =?utf-8?B?cUZSY2NHNHNneWsxRmZtMmh5UG1XT3ordkpQMkVjd2FUbWthUS9rRUowZXJ1?=
 =?utf-8?B?ajIzTU5mdG1tem41bjROS3Zib1Jha255NzlUcy9ydVJ6S3NzUStJb1VvUVBa?=
 =?utf-8?B?aWt5WE9nSmNiSytqUkM1UVpjakV3K1E4bXZDTVd2Y3ovY1pGVmdwU1Q2MlpC?=
 =?utf-8?B?ZWJqYVAvZ21QRnpTanFaYi90czQzZ3ovYTdMQjJ4OWtraDJhZmRsU0pXVXR3?=
 =?utf-8?B?QTM2bnVHZ0VSaVlrZXc4c0MxNmluc2lwN2tFRnV5RFBhWWlDWTJtdUVwY2g3?=
 =?utf-8?B?WUtPdDIybnBuVnhnRDBSWlpvK1FrMEhnR0R0YUhBSC9CNnRuOTFSNDQzc25K?=
 =?utf-8?B?ck9va29sVVNrUlZTN3pWVWF2a2hhWE42dDdzNGtLZmNiSmpzaGxqaHNEUDRl?=
 =?utf-8?B?SVhBK3BON0NqQkNvVnI3UHZLdFQrSkFRSlBkVzNQaTdJWlBhTks4OFc2ZXpu?=
 =?utf-8?B?Z2JnUHIyQ3lqV2Z2WlpXaDdybjVqNE5vNGp0clFMMW40MnVROTFEYU5EZXF2?=
 =?utf-8?B?aHQxOXA1aVVUaWtUa3FHd0tPTVYvT1RnazZIdWxwcXp0Vm5CQmhWUnN3RG9K?=
 =?utf-8?B?L2RCVmRndUxOMUZ3WDVZbDI2NCtsMDdZMzdSNWg0WWdRMWhFNWtsdXdwRElU?=
 =?utf-8?B?NFh1Q2xCcytid0p2djBSYjlybkduVGYrRHJ5cWZOUWpnUnBFOURVT0tTQTBh?=
 =?utf-8?B?UjR4aFhYVy9jYnlnN0NGUFZKQUI0cFgxK09mZFZNMlhza0lTQVVPTld2TEdU?=
 =?utf-8?B?eERid1gxOWp2QVhnZTczTFJjdk1MOSt3Z1dBUDlGRVV5RTVoa0JWaU84VDdX?=
 =?utf-8?Q?3/HpnbWcxSwI1JVaMUsET8cSr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 180084d0-1673-45e3-7e92-08dcc37dcc26
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 14:13:44.5019 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H8gF4c0Xq2uPTT3+40cxHtfTPDYP3KWqMWEdHehNl7psU9m5SE+aluwbSH79cAJPA7A8VvmV8qz4lQtbb71FXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6099
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

On 8/23/2024 09:09, Alex Deucher wrote:
> On Mon, Aug 19, 2024 at 10:30 PM Mario Limonciello <superm1@kernel.org> wrote:
>>
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> If the dGPU is off, then reading the sysfs files with a sensor monitoring
>> application will wake it. Change the behavior to return an error when the
>> dGPU is in D3cold.
> 
> I'm a little concerned that this will generate a flurry of bug reports
> if this now reports an error.  One more comment below.
> 

Do you have a particular app you're worried about, or just a general 
worry?  I've had a lot of people reach out to me complaining about 
battery life on A+A systems, and it comes down to the use of sensor 
monitoring software waking the dGPU which people don't seem to expect.

I did double check that software like 'sensors', 'mission center' and 
'nvtop' don't freak out from this change.

Here is what 'sensors' shows on my local workstation with this change.

amdgpu-pci-6100
Adapter: PCI adapter
vddgfx:           N/A
ERROR: Can't get value of subfeature fan1_min: Can't read
ERROR: Can't get value of subfeature fan1_max: Can't read
fan1:             N/A  (min =    0 RPM, max =    0 RPM)
edge:             N/A  (crit = +97.0°C, hyst = -273.1°C)
ERROR: Can't get value of subfeature power1_cap: Can't read
PPT:              N/A  (cap =   0.00 W)

>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 90 +++++++++++++++---------------
>>   1 file changed, 45 insertions(+), 45 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> index c11952a4389bc..d6e38466fbb82 100644
>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> @@ -142,7 +142,7 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          ret = pm_runtime_get_sync(ddev->dev);
>> @@ -173,7 +173,7 @@ static ssize_t amdgpu_set_power_dpm_state(struct device *dev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          if (strncmp("battery", buf, strlen("battery")) == 0)
>> @@ -270,7 +270,7 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          ret = pm_runtime_get_sync(ddev->dev);
>> @@ -309,7 +309,7 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          if (strncmp("low", buf, strlen("low")) == 0) {
>> @@ -371,7 +371,7 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          ret = pm_runtime_get_sync(ddev->dev);
>> @@ -409,7 +409,7 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          ret = pm_runtime_get_sync(ddev->dev);
>> @@ -448,7 +448,7 @@ static ssize_t amdgpu_get_pp_force_state(struct device *dev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          if (adev->pm.pp_force_state_enabled)
>> @@ -471,7 +471,7 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          adev->pm.pp_force_state_enabled = false;
>> @@ -541,7 +541,7 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          ret = pm_runtime_get_sync(ddev->dev);
>> @@ -577,7 +577,7 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          ret = pm_runtime_get_sync(ddev->dev);
>> @@ -760,7 +760,7 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          if (count > 127 || count == 0)
>> @@ -862,7 +862,7 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          ret = pm_runtime_get_sync(ddev->dev);
>> @@ -922,7 +922,7 @@ static ssize_t amdgpu_set_pp_features(struct device *dev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          ret = kstrtou64(buf, 0, &featuremask);
>> @@ -957,7 +957,7 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          ret = pm_runtime_get_sync(ddev->dev);
>> @@ -1026,7 +1026,7 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          ret = pm_runtime_get_sync(ddev->dev);
>> @@ -1095,7 +1095,7 @@ static ssize_t amdgpu_set_pp_dpm_clock(struct device *dev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          ret = amdgpu_read_mask(buf, count, &mask);
>> @@ -1280,7 +1280,7 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          ret = pm_runtime_get_sync(ddev->dev);
>> @@ -1309,7 +1309,7 @@ static ssize_t amdgpu_set_pp_sclk_od(struct device *dev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          ret = kstrtol(buf, 0, &value);
>> @@ -1342,7 +1342,7 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          ret = pm_runtime_get_sync(ddev->dev);
>> @@ -1371,7 +1371,7 @@ static ssize_t amdgpu_set_pp_mclk_od(struct device *dev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          ret = kstrtol(buf, 0, &value);
>> @@ -1424,7 +1424,7 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          ret = pm_runtime_get_sync(ddev->dev);
>> @@ -1463,7 +1463,7 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          tmp[0] = *(buf);
>> @@ -1517,7 +1517,7 @@ static int amdgpu_hwmon_get_sensor_generic(struct amdgpu_device *adev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>> @@ -1630,7 +1630,7 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          if (adev->flags & AMD_IS_APU)
>> @@ -1673,7 +1673,7 @@ static ssize_t amdgpu_get_unique_id(struct device *dev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          if (adev->unique_id)
>> @@ -1846,7 +1846,7 @@ static ssize_t amdgpu_get_pm_metrics(struct device *dev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          ret = pm_runtime_get_sync(ddev->dev);
>> @@ -1887,7 +1887,7 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          ret = pm_runtime_get_sync(ddev->dev);
>> @@ -2005,7 +2005,7 @@ static ssize_t amdgpu_set_smartshift_bias(struct device *dev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          r = pm_runtime_get_sync(ddev->dev);
>> @@ -2227,7 +2227,7 @@ static ssize_t amdgpu_get_xgmi_plpd_policy(struct device *dev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          mode = amdgpu_dpm_get_xgmi_plpd_mode(adev, &mode_desc);
>> @@ -2250,7 +2250,7 @@ static ssize_t amdgpu_set_xgmi_plpd_policy(struct device *dev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          ret = kstrtos32(buf, 0, &mode);
>> @@ -2652,7 +2652,7 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          ret = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>> @@ -2684,7 +2684,7 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct device *dev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          err = kstrtoint(buf, 10, &value);
>> @@ -2742,7 +2742,7 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct device *dev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          err = kstrtou32(buf, 10, &value);
>> @@ -2787,7 +2787,7 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          err = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>> @@ -2817,7 +2817,7 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct device *dev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          err = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>> @@ -2881,7 +2881,7 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          err = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>> @@ -2912,7 +2912,7 @@ static ssize_t amdgpu_hwmon_set_fan1_target(struct device *dev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          err = kstrtou32(buf, 10, &value);
>> @@ -2956,7 +2956,7 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct device *dev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          ret = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>> @@ -2988,7 +2988,7 @@ static ssize_t amdgpu_hwmon_set_fan1_enable(struct device *dev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          err = kstrtoint(buf, 10, &value);
>> @@ -3128,7 +3128,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_generic(struct device *dev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>> @@ -3209,7 +3209,7 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          if (amdgpu_sriov_vf(adev))
>> @@ -3663,7 +3663,7 @@ static int amdgpu_retrieve_od_settings(struct amdgpu_device *adev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          ret = pm_runtime_get_sync(adev->dev);
>> @@ -3747,7 +3747,7 @@ amdgpu_distribute_custom_od_settings(struct amdgpu_device *adev,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          ret = parse_input_od_command_lines(in_buf,
>> @@ -4626,7 +4626,7 @@ static int amdgpu_debugfs_pm_info_show(struct seq_file *m, void *unused)
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
> 
> I'd prefer to keep the current behavior for debugfs.

OK.  I'll exclude it for debugfs in the next spin.

> 
> Alex
> 
>>
>>          r = pm_runtime_get_sync(dev->dev);
>> @@ -4671,7 +4671,7 @@ static ssize_t amdgpu_pm_prv_buffer_read(struct file *f, char __user *buf,
>>
>>          if (amdgpu_in_reset(adev))
>>                  return -EPERM;
>> -       if (adev->in_suspend && !adev->in_runpm)
>> +       if (adev->in_suspend || adev->in_runpm)
>>                  return -EPERM;
>>
>>          ret = amdgpu_dpm_get_smu_prv_buf_details(adev, &smu_prv_buf, &smu_prv_buf_size);
>> --
>> 2.43.0
>>

