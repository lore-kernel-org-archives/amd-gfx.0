Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7999EC3601E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 11:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2178410E974;
	Thu, 10 Apr 2025 11:58:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VncBBmdW";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4792D10E974
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 11:58:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGZM7lOmNnl+y/g4309faxc7Y4qXeWX0wh9MB64YtDCSIGlpczBlzixmBJWyCp/RjGInB/IX0K3HTcuvFS4vlAWi/S05/1EV65qRcdRqv3L7JieW5wp0W/JmFTD/utu/n5qXItfWbU8S/Np1dx58iPgS4yGR0MyhHOXdlxSEdaTrEjkzYhMUwvp+HY0gb5KD55nJkfj2oKh6OcDn74acZ5TrKyxUMjBRyEvA6KhPZBtPONWU9ia8BGdtqtTf6fd5UrQjl7TutMbZkQ7I//q0BSt9nOtVHFKL4vu6inBKZorbWOxmW3HqhaIeO80zK7OfrXZxQg4Yr8e+5jlSobTIIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dU4wrKVvJU1XxDwKh3KKrow4ohEnHdKVhpwYgHApYAo=;
 b=WrFOm4W9mauXKbvzSoYe4jiQTkJgaSDKvrsdBCmVXkDfdLUn5ag0t87iwaO3+LXq4FHqMwB4t+iGVoN0M0YPcmeOPXHzR+7IPYQS4keTlodHVWO2H3ZGX5cNA6K/c8g2ClpIkximghe1r+9IrHKnZ6V4ycA4TmO/ZCSTErNxpVUAcoj7aatfcFC5Dmw1MeGZcgZ5CnFmFBToBvk5o/Ofq0wnk3plNY4GLOGTix2NdCWiYPZmVHSjgQbcca5GeytvUXi1i65DwrxdYwmPWc5iPC22LGaj6DYN8gSEYWaMpGKfqDGBc/JhHY9YPKVJ5yOVBXtBpfQRdGr1FsI8rGi16Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dU4wrKVvJU1XxDwKh3KKrow4ohEnHdKVhpwYgHApYAo=;
 b=VncBBmdWB0Do5x/8w2mbzJk2uwYsggLYXZL8xE0X/q7Y8RYozU0n8S9D2fZ9iOSCu5T2r0L4k8Ot9ef9IwHgSX+iTr3po3ufczOCaumoVmXKXsOcabAyzgaCtTPtl/yfCcBSUQ5XkI7qUFt/4DqBlhvVY9cM7DIMtgF5M4ks/nI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by CH1PR12MB9646.namprd12.prod.outlook.com (2603:10b6:610:2af::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.25; Thu, 10 Apr
 2025 11:57:56 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%3]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 11:57:56 +0000
Message-ID: <dfba2351-8cf4-498f-9acc-78ec66afe02c@amd.com>
Date: Thu, 10 Apr 2025 17:27:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: adjust enforce_isolation handling
To: amd-gfx@lists.freedesktop.org
References: <20250408160000.3149409-1-alexander.deucher@amd.com>
 <20250408160000.3149409-3-alexander.deucher@amd.com>
 <243270dd-f7a6-4eee-a5c7-904085b25472@amd.com>
 <CADnq5_MY9wi9ytZ1xhVoauQHVrEDGsO3xyH=9PyJRwPafooqSQ@mail.gmail.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <CADnq5_MY9wi9ytZ1xhVoauQHVrEDGsO3xyH=9PyJRwPafooqSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0152.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::7) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|CH1PR12MB9646:EE_
X-MS-Office365-Filtering-Correlation-Id: 49d37ea0-d389-4b91-cd47-08dd7826ee9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dFdOSlNLVkNkTEFjYytzYlBWMTFaeUlOUUxTeEFkdzUwTUYrbUphT2RmNXRq?=
 =?utf-8?B?MDIwZkRnOTRNaGdhUnJoSTJ5cWpvMUhSYWhsTHNESHNkOGhFWWZaeVhFckJQ?=
 =?utf-8?B?UkZFZTNJN2UxQUxzUTZ5d2RnckZESmlCZDhLZkFIbE9hWXYvSnRCem5EcDJE?=
 =?utf-8?B?OGQvSi92bVpuY01nSzMzOHgweWVFdFp6VHoyNTN6SUpkTlRaZjFINk5hY3h6?=
 =?utf-8?B?TlJ0UW9uTGszd2JZR0pSUlR0ZERCSXRGUmdCZDhqOVN5Qm9GMFgzWnRMQzBU?=
 =?utf-8?B?V3VHSjc4dy9JTHBUZ2Q0NWd4b1JXS20rYkRMNklWKytnNjBjdnh3aXZiMkZj?=
 =?utf-8?B?Yi9Nbko0YlJaQVM5em0zcTMxNEN6SHh4Qi9uYUxxTkF1cStEejljSDMvVi9u?=
 =?utf-8?B?V2MzVnNjL1NtSEQyZW80UTlPY3JCdGkvUzZydjVRTnRkUkJ5OElkSUlydG0v?=
 =?utf-8?B?UXBpVERwcmIyVG5BZW81bXBKZ2JNV0d3cEVHM2czMktaeTZ0aWRqcjN1aXEw?=
 =?utf-8?B?bnJ3MjhlT3ZNTEhGdXNTTFMrQllFQURaMFFEaG9Ld1VZQWczYS9HYWdZRmFs?=
 =?utf-8?B?MlkrNjB4RmdtMnlNT0FKbUdSOWFvN0ovTlozTm01eEVXVzNtUC9RUFM1Vzkr?=
 =?utf-8?B?WkgyY240cGhTSWFFellhQ0NtV1ZObXZ1Q3NZTWVoQVAzeDMrU3VzUjNJU1RR?=
 =?utf-8?B?b2dqanhicGhLNEhhUDA3eC9jRTdudVhpZHJDOFYzV09menVtOHlMTWd4SmFm?=
 =?utf-8?B?djFtTHZyaERkblhNTHMwVWI1RkpJNXdwaXM2S0diUGFDcHJyMFloYVVtUlRh?=
 =?utf-8?B?NjM0OUdNc29DcTNsL2NXbTZYRmkwczFGbmltc3o3NzEyd0ZnS29OajF0Ny9K?=
 =?utf-8?B?TGo2RXE2RXhaSHV5TDhEUW56MzR2b1hjeE5oUEdBdDgwM3RCdDAzVXhsNDFj?=
 =?utf-8?B?SFk2ZEIxV2UwQU9Sb010Ym9vSXhJQ05aaDVLQnRWZjJpenNIK1NyMzRnUkRI?=
 =?utf-8?B?OFU1VjkxclYvSXZicFdhakNDNDVabTREeFRHeExVYklHcjNpMlc5N2ZwSDBq?=
 =?utf-8?B?WU1TRU9nNXo1YlFiZkpRdHNJdittSGR5YmNpS0VPRWxqZGZrMW82MjlwNGVS?=
 =?utf-8?B?M2NqaGhGRUdNZ1RvU0hPaHRMeVRKVm1LS09VOHdKYm9ISDh2KzI1WnVJU3pR?=
 =?utf-8?B?b2k1QUQ2UXRuQ1o3bi84bEl6YXFsV2lpZW96dUtaYzA5Q1pIMjJ4YnlTNzBh?=
 =?utf-8?B?Z0g2eFNUL3lRaUpIbVg2dExBd2RMS2kxTSswSFVoWEdGRkk2Y1BMK0UwTVNa?=
 =?utf-8?B?b05HYjh1SDFrSmhqajlCS0p2OGRmVjBWdWtFajFCb3VMbFZZOHE1RlQwR2xU?=
 =?utf-8?B?MHMrZExma2RlSU9qZkpndXNwM3Z6cGY5MlhZSEdZQ2FsY29nVDhQYUxxUDlq?=
 =?utf-8?B?VUdSQVZ2RVlLZnpmaldteXl2M0VCMk5zTnlHdjFyTGg0SGdDZXVJZnlJTUlh?=
 =?utf-8?B?RFJxY3h5RnFOZHQwWWg2V0xQNGRuSUpGcVZ5SnFBMi9yRVpGb20zY2gyQjhT?=
 =?utf-8?B?ODFkUGM1K1BCaXdLcVlKbTdFR2lVQTBzV095S0I2bCtGSm5FM2o5Q1dPWTRS?=
 =?utf-8?B?VUJOVUxETkd3d1Y4WlFmU3pkblp1eVlWWlhNQTFsbW5uU1hRY0l4ZWs2d0l6?=
 =?utf-8?B?SDRPREhEWVFKdXR0YStINnJrRS9GbjgxTVNHQWMzOXBzeCs0Sy9kN09UeFUx?=
 =?utf-8?B?d0pGLzNlSmJZN3JGZmNibkdDRVBKaEtZUjNLQ0cwclRMVUJTUTNTNVZGZWND?=
 =?utf-8?B?aE9FRStneG1jRFlTZG1Ba3k3VVd5WWlmdVJ3aUJSKzRmRk5JRWE5Q21DcDJX?=
 =?utf-8?Q?8hMj+2H8OnnVg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWh5L2ZseHpacVpta0pzMCt0RWEvbk1sYmlRQi9ETTArMjFCcFhpVklGZ3RD?=
 =?utf-8?B?elFBYkVBcnFWRVpXL3BVTyt2Vk00VWp2Y21FNUwrekUwMFpKRmdHU0x1SU52?=
 =?utf-8?B?d3paT0E3NVdQNFBPNnREUEZ1QU1RdHNUSHVaMkJVTnVPZFpQMzg5YjhJN1NL?=
 =?utf-8?B?Z3pabHJnUnVKdWpJazVUdmJPRjhweWJpa2xyVmhqVkl6WHg2ZWVwdFF2NEhr?=
 =?utf-8?B?bE9kRnJpZW84aUlZWVA3RXlFcDBObHdxQ2Z2Q0x6bDMyamJGVFBWc1Y1bFU1?=
 =?utf-8?B?SjQ5R0JydzFXcnBEVmc5UDlwb3h2SmVsTFVoZGVSNzR6SUpXR0pFdUVNNWFU?=
 =?utf-8?B?OE54MUlrRUc5aWkzVHZBNTRjbTdsL1g2VHRxUUovUThSY2Rsa2tXazNSVEs5?=
 =?utf-8?B?NmttQWVwQklyNHZyRVdIREpDazJkdlR1aTE3Tncrc2ZESFJUVzRFZGJTbE9a?=
 =?utf-8?B?VzVybklhbEcrUUpOUlJiZ1A4Zis0QTNYUE1tM1h6VFJDY1psZ1ZNaC92QUZV?=
 =?utf-8?B?TkprL3VwRVVZMHNEellUeXR2Z29HSC9JVU9QaWlrYWVrMEgxV0xZZnl5dyti?=
 =?utf-8?B?NnV0aDhNSDlROVd4VXlBUFdsa29KdGFvNjNpeG8xTXVnQWs0ajRzU25GR2Fz?=
 =?utf-8?B?SUNOalhXRjZXY2ZXMlJzRFZ1OTBzOXdJV0ltK0szbUdNSHMybzhjbE9vNnZB?=
 =?utf-8?B?M0EvMllibERkR0ZLOUJoS1I3bHFqbXlGbzVlMTFFRTU2YVZ4eGdJNXJzZng1?=
 =?utf-8?B?bzd2djRKbEhzMEM5ZXkvWEMxNFlSL0hrTS90M2o0dUdlcUh1RTFXbGRRSHhW?=
 =?utf-8?B?aU1VdkM0QUJsNUVIQmVTOEVWY1JWYzBta1QyVEtkT2t0WVdtVFlyeXprb2kx?=
 =?utf-8?B?SGx5cEd3OE9SdERvSUFBVXpiYjNScEZTZDcvVmdCZE9Rd1oyRVRKc3lTNzF1?=
 =?utf-8?B?T3dnNkxlR0VqdXB4eUNNcU9OZDg0WW5ZRGpqYmhIM25KL3c4dmRyS1pZWmlt?=
 =?utf-8?B?REIrM3RScFFBcHp5Qk5Dbi9SbnJyVm4yeWt1U0dtVWg3dzVxd2JtODFySXNh?=
 =?utf-8?B?TU1OSlFsVnJoeTJJM2lQTHpKWlR4bTZ4SVplZGVINmRVclczb1gvSXFpOGFi?=
 =?utf-8?B?TGluTTdhQytDYjQ5WFJBWTBYeGVaWCsrNGhMaDA0cXo2VGM2bDQyd2ZiTStw?=
 =?utf-8?B?Y09ZZTdPYWpUT3BVU1FUMlYvMTFvSGhEd2FreklJb2NkU3NOYWMwa2ZMSXVO?=
 =?utf-8?B?eVN5MVliUUw5UlA4K1VGVUErTjJrbmkvS0Q5T1d2N2IweWNaQ0sxMSs2SWlI?=
 =?utf-8?B?WlgxcEJuN0Qvc00rREZIMlYySmViNlIwL0JOV25tbUxiU0F2QUQ2NSt2REFy?=
 =?utf-8?B?VXBZYUFQL3UyNjJHZzJvcWR4SDFJQTUyd09KRVFuQUlUdzYxcDlVUnJWNktr?=
 =?utf-8?B?cG9FNWFTYVNtTkVDQTBFb3RKbjQ3Z0tDNjc5TU9SQkhxYmJwS0tzakk4K2Uz?=
 =?utf-8?B?UmdIb2xYcnFWeGx0d1VVOFBGMzR2SmJSWnlOeHB2YWZlZUtIbXdWWFJzMDZw?=
 =?utf-8?B?YVJ5ZHRJN3ROUFVYdGc0bXMranRlUzZnaDhZak9IRjA3ZzlHV1ZKRDYzWnU1?=
 =?utf-8?B?bVhFVGo3THM5aTlwQk8wUVJjVTNzdm15MEgzOW42M05XM0xYdUxSU3l2aDlI?=
 =?utf-8?B?S2ZFcFd5NGtLdmw1T2t6Tm12Y1NJK0FzZGwwb0FlTU4za1BLS2E0RklDamp2?=
 =?utf-8?B?djA4Mzl0c3lrVGtwNGN2dXAycDU4UGV3YWQ4QWpjemN4WVdpZlNzOFhWVEtv?=
 =?utf-8?B?SzBQbno4dSt0QjVxMzVlMTNVMERlUE9VUDBpSC84ZHU0MDVGL1JoR0tpUnlo?=
 =?utf-8?B?RVIraDJkSUw5ZjhvS1ZnWXh3UFRiRmZuM1JFTVJrOHE3K2Y3bHI0K0lGUy80?=
 =?utf-8?B?TDVKZzFTMmlpZytaN0ZBL2lXTFVyck9qNzFKemcyNUd6NVJhN3RqaEFHUDRN?=
 =?utf-8?B?bXZFUC9jby9zRnlSMDAwMlJqRktEbFdwUkNlbCtFZ1VaOWJmMk1xbkVlSlNJ?=
 =?utf-8?B?RmIyZEplRmx6V3NZRm9xeGVxa2dKZEY1TG9JYnZKVHRJQVBFREJPZ25NQjUz?=
 =?utf-8?Q?dbbfX9G7Of3J11Qy/n/aRTrlE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d37ea0-d389-4b91-cd47-08dd7826ee9e
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 11:57:56.6932 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kmo15WvVDqj9CEn3xS9cSUKfNTbYx0Mry9Kc96wQ2/7NuyjYGToWSPtXGEsWbjdgPPh+ZqGuLJUNnWAlRGviCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9646
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


On 4/9/2025 8:12 PM, Alex Deucher wrote:
> On Wed, Apr 9, 2025 at 10:36 AM SRINIVASAN SHANMUGAM
> <srinivasan.shanmugam@amd.com> wrote:
>>
>> On 4/8/2025 9:30 PM, Alex Deucher wrote:
>>> Switch from a bool to an enum and allow more options
>>> for enforce isolation.  There are now 3 modes of operation:
>>> - Disabled (0)
>>> - Enabled (serialization and cleaner shader) (1)
>>> - Enabled in legacy mode (no serialization or cleaner shader) (2)
>>> This provides better flexibility for more use cases.
>>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 11 +++++-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        | 16 +++++++-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 22 ++++++++++-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 12 +++---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       | 39 ++++++++++++++-----
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c       |  2 +-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_job.h       |  1 +
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |  2 +-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  3 +-
>>>    drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  2 +-
>>>    drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        |  2 +-
>>>    .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 11 +++---
>>>    12 files changed, 93 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index 804d377037095..468c6ce09e3ef 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -230,7 +230,7 @@ extern int amdgpu_force_asic_type;
>>>    extern int amdgpu_smartshift_bias;
>>>    extern int amdgpu_use_xgmi_p2p;
>>>    extern int amdgpu_mtype_local;
>>> -extern bool enforce_isolation;
>>> +extern int amdgpu_enforce_isolation;
>>>    #ifdef CONFIG_HSA_AMD
>>>    extern int sched_policy;
>>>    extern bool debug_evictions;
>>> @@ -873,6 +873,13 @@ struct amdgpu_init_level {
>>>    struct amdgpu_reset_domain;
>>>    struct amdgpu_fru_info;
>>>
>>> +enum amdgpu_enforce_isolation_mode {
>>> +     AMDGPU_ENFORCE_ISOLATION_DISABLE = 0,
>>> +     AMDGPU_ENFORCE_ISOLATION_ENABLE = 1,
>>> +     AMDGPU_ENFORCE_ISOLATION_ENABLE_LEGACY = 2,
>>> +};
>>> +
>>> +
>>>    /*
>>>     * Non-zero (true) if the GPU has VRAM. Zero (false) otherwise.
>>>     */
>>> @@ -1224,7 +1231,7 @@ struct amdgpu_device {
>>>
>>>        /* Protection for the following isolation structure */
>>>        struct mutex                    enforce_isolation_mutex;
>>> -     bool                            enforce_isolation[MAX_XCP];
>>> +     enum amdgpu_enforce_isolation_mode      enforce_isolation[MAX_XCP];
>>>        struct amdgpu_isolation {
>>>                void                    *owner;
>>>                struct dma_fence        *spearhead;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> index 4a5cd7a111fc4..34a688fc5bf35 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> @@ -296,7 +296,21 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
>>>                                       num_ibs[i], &p->jobs[i]);
>>>                if (ret)
>>>                        goto free_all_kdata;
>>> -             p->jobs[i]->enforce_isolation = p->adev->enforce_isolation[fpriv->xcp_id];
>>> +             switch (p->adev->enforce_isolation[fpriv->xcp_id]) {
>>> +             case AMDGPU_ENFORCE_ISOLATION_DISABLE:
>>> +             default:
>>> +                     p->jobs[i]->enforce_isolation = false;
>>> +                     p->jobs[i]->run_cleaner_shader = false;
>>> +                     break;
>>> +             case AMDGPU_ENFORCE_ISOLATION_ENABLE:
>>> +                     p->jobs[i]->enforce_isolation = true;
>>> +                     p->jobs[i]->run_cleaner_shader = true;
>>> +                     break;
>>> +             case AMDGPU_ENFORCE_ISOLATION_ENABLE_LEGACY:
>>> +                     p->jobs[i]->enforce_isolation = true;
>>> +                     p->jobs[i]->run_cleaner_shader = false;
>>
>> Hi Alex,
>>
>> Even for legacy enforce_isolation, just to double check, we expect
>> cleaner shader to run, cz by default when we trigger modprobe amdgpu
>> enforce_isolation = 1, for this usecase, we expect cleaner shader to be
>> triggered that means legacy , am I correct pls?
> The idea is that this option brings back the enforce isolation
> behavior prior to adding the cleaner shader functionality if you
> select 2.  So no cleaner shader and no serialization with KFD; just
> serialization within KFD.  So:
> 0 - enforce isolation disabled
> 1 - enable serialization between KFD and KGD and within KFD and KGD,
> cleaner shader between processes
> 2 - enable serialization within KGD (the original enforce isolation behavior)


Alright, thanks for your feedbacks and for this series, the series is:

Acked-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>


>
> Alex
>
>> Best regards,
>> Srini
>>
>>
>>> +                     break;
>>> +             }
>>>        }
>>>        p->gang_leader = p->jobs[p->gang_leader_idx];
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 8b43f350447a9..700304bbe3982 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -2115,8 +2115,26 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
>>>
>>>        adev->firmware.load_type = amdgpu_ucode_get_load_type(adev, amdgpu_fw_load_type);
>>>
>>> -     for (i = 0; i < MAX_XCP; i++)
>>> -             adev->enforce_isolation[i] = !!enforce_isolation;
>>> +     for (i = 0; i < MAX_XCP; i++) {
>>> +             switch (amdgpu_enforce_isolation) {
>>> +             case -1:
>>> +             case 0:
>>> +             default:
>>> +                     /* disable */
>>> +                     adev->enforce_isolation[i] = AMDGPU_ENFORCE_ISOLATION_DISABLE;
>>> +                     break;
>>> +             case 1:
>>> +                     /* enable */
>>> +                     adev->enforce_isolation[i] =
>>> +                             AMDGPU_ENFORCE_ISOLATION_ENABLE;
>>> +                     break;
>>> +             case 2:
>>> +                     /* enable legacy mode */
>>> +                     adev->enforce_isolation[i] =
>>> +                             AMDGPU_ENFORCE_ISOLATION_ENABLE_LEGACY;
>>> +                     break;
>>> +             }
>>> +     }
>>>
>>>        return 0;
>>>    }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> index d7b27b7a0d519..5132003d85a29 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> @@ -179,7 +179,7 @@ uint amdgpu_pg_mask = 0xffffffff;
>>>    uint amdgpu_sdma_phase_quantum = 32;
>>>    char *amdgpu_disable_cu;
>>>    char *amdgpu_virtual_display;
>>> -bool enforce_isolation;
>>> +int amdgpu_enforce_isolation = -1;
>>>    int amdgpu_modeset = -1;
>>>
>>>    /* Specifies the default granularity for SVM, used in buffer
>>> @@ -1038,11 +1038,13 @@ module_param_named(user_partt_mode, amdgpu_user_partt_mode, uint, 0444);
>>>
>>>
>>>    /**
>>> - * DOC: enforce_isolation (bool)
>>> - * enforce process isolation between graphics and compute via using the same reserved vmid.
>>> + * DOC: enforce_isolation (int)
>>> + * enforce process isolation between graphics and compute.
>>> + * (-1 = auto, 0 = disable, 1 = enable, 2 = enable legacy mode)
>>>     */
>>> -module_param(enforce_isolation, bool, 0444);
>>> -MODULE_PARM_DESC(enforce_isolation, "enforce process isolation between graphics and compute . enforce_isolation = on");
>>> +module_param_named(enforce_isolation, amdgpu_enforce_isolation, int, 0444);
>>> +MODULE_PARM_DESC(enforce_isolation,
>>> +"enforce process isolation between graphics and compute. (-1 = auto, 0 = disable, 1 = enable, 2 = enable legacy mode)");
>>>
>>>    /**
>>>     * DOC: modeset (int)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> index ff53401aae5a4..9b4272fbc470c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> @@ -1460,6 +1460,8 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
>>>                goto err;
>>>
>>>        job->enforce_isolation = true;
>>> +     /* always run the cleaner shader */
>>> +     job->run_cleaner_shader = true;
>>>
>>>        ib = &job->ibs[0];
>>>        for (i = 0; i <= ring->funcs->align_mask; ++i)
>>> @@ -1591,7 +1593,7 @@ static ssize_t amdgpu_gfx_set_run_cleaner_shader(struct device *dev,
>>>     * Provides the sysfs read interface to get the current settings of the 'enforce_isolation'
>>>     * feature for each GPU partition. Reading from the 'enforce_isolation'
>>>     * sysfs file returns the isolation settings for all partitions, where '0'
>>> - * indicates disabled and '1' indicates enabled.
>>> + * indicates disabled, '1' indicates enabled, and '2' indicates enabled in legacy mode.
>>>     *
>>>     * Return: The number of bytes read from the sysfs file.
>>>     */
>>> @@ -1626,9 +1628,10 @@ static ssize_t amdgpu_gfx_get_enforce_isolation(struct device *dev,
>>>     * @count: The size of the input data
>>>     *
>>>     * This function allows control over the 'enforce_isolation' feature, which
>>> - * serializes access to the graphics engine. Writing '1' or '0' to the
>>> - * 'enforce_isolation' sysfs file enables or disables process isolation for
>>> - * each partition. The input should specify the setting for all partitions.
>>> + * serializes access to the graphics engine. Writing '1', '2', or '0' to the
>>> + * 'enforce_isolation' sysfs file enables (full or legacy) or disables process
>>> + * isolation for each partition. The input should specify the setting for all
>>> + * partitions.
>>>     *
>>>     * Return: The number of bytes written to the sysfs file.
>>>     */
>>> @@ -1665,13 +1668,29 @@ static ssize_t amdgpu_gfx_set_enforce_isolation(struct device *dev,
>>>                return -EINVAL;
>>>
>>>        for (i = 0; i < num_partitions; i++) {
>>> -             if (partition_values[i] != 0 && partition_values[i] != 1)
>>> +             if (partition_values[i] != 0 &&
>>> +                 partition_values[i] != 1 &&
>>> +                 partition_values[i] != 2)
>>>                        return -EINVAL;
>>>        }
>>>
>>>        mutex_lock(&adev->enforce_isolation_mutex);
>>> -     for (i = 0; i < num_partitions; i++)
>>> -             adev->enforce_isolation[i] = partition_values[i];
>>> +     for (i = 0; i < num_partitions; i++) {
>>> +             switch (partition_values[i]) {
>>> +             case 0:
>>> +             default:
>>> +                     adev->enforce_isolation[i] = AMDGPU_ENFORCE_ISOLATION_DISABLE;
>>> +                     break;
>>> +             case 1:
>>> +                     adev->enforce_isolation[i] =
>>> +                             AMDGPU_ENFORCE_ISOLATION_ENABLE;
>>> +                     break;
>>> +             case 2:
>>> +                     adev->enforce_isolation[i] =
>>> +                             AMDGPU_ENFORCE_ISOLATION_ENABLE_LEGACY;
>>> +                     break;
>>> +             }
>>> +     }
>>>        mutex_unlock(&adev->enforce_isolation_mutex);
>>>
>>>        amdgpu_mes_update_enforce_isolation(adev);
>>> @@ -2026,7 +2045,7 @@ amdgpu_gfx_enforce_isolation_wait_for_kfd(struct amdgpu_device *adev,
>>>        bool wait = false;
>>>
>>>        mutex_lock(&adev->enforce_isolation_mutex);
>>> -     if (adev->enforce_isolation[idx]) {
>>> +     if (adev->enforce_isolation[idx] == AMDGPU_ENFORCE_ISOLATION_ENABLE) {
>>>                /* set the initial values if nothing is set */
>>>                if (!adev->gfx.enforce_isolation_jiffies[idx]) {
>>>                        adev->gfx.enforce_isolation_jiffies[idx] = jiffies;
>>> @@ -2093,7 +2112,7 @@ void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *ring)
>>>        amdgpu_gfx_enforce_isolation_wait_for_kfd(adev, idx);
>>>
>>>        mutex_lock(&adev->enforce_isolation_mutex);
>>> -     if (adev->enforce_isolation[idx]) {
>>> +     if (adev->enforce_isolation[idx] == AMDGPU_ENFORCE_ISOLATION_ENABLE) {
>>>                if (adev->kfd.init_complete)
>>>                        sched_work = true;
>>>        }
>>> @@ -2130,7 +2149,7 @@ void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring)
>>>                return;
>>>
>>>        mutex_lock(&adev->enforce_isolation_mutex);
>>> -     if (adev->enforce_isolation[idx]) {
>>> +     if (adev->enforce_isolation[idx] == AMDGPU_ENFORCE_ISOLATION_ENABLE) {
>>>                if (adev->kfd.init_complete)
>>>                        sched_work = true;
>>>        }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>> index 4c4e087230ac5..359c19de9a5b9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>> @@ -588,7 +588,7 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *adev)
>>>        }
>>>        /* alloc a default reserved vmid to enforce isolation */
>>>        for (i = 0; i < (adev->xcp_mgr ? adev->xcp_mgr->num_xcps : 1); i++) {
>>> -             if (adev->enforce_isolation[i])
>>> +             if (adev->enforce_isolation[i] != AMDGPU_ENFORCE_ISOLATION_DISABLE)
>>>                        amdgpu_vmid_alloc_reserved(adev, AMDGPU_GFXHUB(i));
>>>        }
>>>    }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>> index ce6b9ba967fff..f2c049129661f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>> @@ -78,6 +78,7 @@ struct amdgpu_job {
>>>
>>>        /* enforce isolation */
>>>        bool                    enforce_isolation;
>>> +     bool                    run_cleaner_shader;
>>>
>>>        uint32_t                num_ibs;
>>>        struct amdgpu_ib        ibs[];
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>> index 36f2e87161264..38ea64d87a0ac 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>> @@ -768,7 +768,7 @@ int amdgpu_mes_update_enforce_isolation(struct amdgpu_device *adev)
>>>        if (adev->enable_mes && adev->gfx.enable_cleaner_shader) {
>>>                mutex_lock(&adev->enforce_isolation_mutex);
>>>                for (i = 0; i < (adev->xcp_mgr ? adev->xcp_mgr->num_xcps : 1); i++) {
>>> -                     if (adev->enforce_isolation[i])
>>> +                     if (adev->enforce_isolation[i] == AMDGPU_ENFORCE_ISOLATION_ENABLE)
>>>                                r |= amdgpu_mes_set_enforce_isolation(adev, i, true);
>>>                        else
>>>                                r |= amdgpu_mes_set_enforce_isolation(adev, i, false);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index b5ddfcbbc9fc9..dadf6715b98be 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -676,7 +676,8 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>>        pasid_mapping_needed &= adev->gmc.gmc_funcs->emit_pasid_mapping &&
>>>                ring->funcs->emit_wreg;
>>>
>>> -     cleaner_shader_needed = adev->gfx.enable_cleaner_shader &&
>>> +     cleaner_shader_needed = job->run_cleaner_shader &&
>>> +             adev->gfx.enable_cleaner_shader &&
>>>                ring->funcs->emit_cleaner_shader && job->base.s_fence &&
>>>                &job->base.s_fence->scheduled == isolation->spearhead;
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>> index 344d32268c3cd..f7aa45775eadb 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>> @@ -724,7 +724,7 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
>>>                                        mes->event_log_gpu_addr;
>>>        }
>>>
>>> -     if (adev->enforce_isolation[0])
>>> +     if (adev->enforce_isolation[0] == AMDGPU_ENFORCE_ISOLATION_ENABLE)
>>>                mes_set_hw_res_pkt.limit_single_process = 1;
>>>
>>>        return mes_v11_0_submit_pkt_and_poll_completion(mes,
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
>>> index be43e19b7b7fa..b0e042a4cea19 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
>>> @@ -762,7 +762,7 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
>>>                                pipe * (AMDGPU_MES_LOG_BUFFER_SIZE + AMDGPU_MES_MSCRATCH_SIZE);
>>>        }
>>>
>>> -     if (adev->enforce_isolation[0])
>>> +     if (adev->enforce_isolation[0] == AMDGPU_ENFORCE_ISOLATION_ENABLE)
>>>                mes_set_hw_res_pkt.limit_single_process = 1;
>>>
>>>        return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
>>> index 2893fd5e5d003..fa28c57692b86 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
>>> @@ -43,7 +43,7 @@ static int pm_map_process_v9(struct packet_manager *pm,
>>>        memset(buffer, 0, sizeof(struct pm4_mes_map_process));
>>>        packet->header.u32All = pm_build_pm4_header(IT_MAP_PROCESS,
>>>                                        sizeof(struct pm4_mes_map_process));
>>> -     if (adev->enforce_isolation[kfd->node_id])
>>> +     if (adev->enforce_isolation[kfd->node_id] == AMDGPU_ENFORCE_ISOLATION_ENABLE)
>>>                packet->bitfields2.exec_cleaner_shader = 1;
>>>        packet->bitfields2.diq_enable = (qpd->is_debug) ? 1 : 0;
>>>        packet->bitfields2.process_quantum = 10;
>>> @@ -102,7 +102,8 @@ static int pm_map_process_aldebaran(struct packet_manager *pm,
>>>        memset(buffer, 0, sizeof(struct pm4_mes_map_process_aldebaran));
>>>        packet->header.u32All = pm_build_pm4_header(IT_MAP_PROCESS,
>>>                        sizeof(struct pm4_mes_map_process_aldebaran));
>>> -     if (adev->enforce_isolation[knode->node_id])
>>> +     if (adev->enforce_isolation[knode->node_id] ==
>>> +         AMDGPU_ENFORCE_ISOLATION_ENABLE)
>>>                packet->bitfields2.exec_cleaner_shader = 1;
>>>        packet->bitfields2.diq_enable = (qpd->is_debug) ? 1 : 0;
>>>        packet->bitfields2.process_quantum = 10;
>>> @@ -165,9 +166,9 @@ static int pm_runlist_v9(struct packet_manager *pm, uint32_t *buffer,
>>>         * hws_max_conc_proc has been done in
>>>         * kgd2kfd_device_init().
>>>         */
>>> -     concurrent_proc_cnt = adev->enforce_isolation[kfd->node_id] ?
>>> -                     1 : min(pm->dqm->processes_count,
>>> -                     kfd->max_proc_per_quantum);
>>> +     concurrent_proc_cnt = (adev->enforce_isolation[kfd->node_id] ==
>>> +                            AMDGPU_ENFORCE_ISOLATION_ENABLE) ?
>>> +             1 : min(pm->dqm->processes_count, kfd->max_proc_per_quantum);
>>>
>>>        packet = (struct pm4_mes_runlist *)buffer;
>>>
