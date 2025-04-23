Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B51C369CB
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Apr 2025 14:00:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1B8510E6B4;
	Wed, 23 Apr 2025 14:00:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KkRYB9tG";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C52DB10E1FB
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Apr 2025 14:00:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p7neblUJ4LQtsSzn6cPoy76/3ctsdNcWgRA0YAkft3viYB6eik6IpiCi+/TnZZX4n4DZgxdOAIAdK96wTbmgmsg1zD+Ix3LNxImlkAuAWvxRMlkvqmZiH9iPBwp2Rff085lMjDBaQxXxxBZn0kczLgJfKGNVsmwTa2NoF6POv7Tq+wID9VDCHVK5w+QJobvcEuxwILIRAth0KBuAcRZ3sCjFd7C1OKt5rfx9mQtl/AETqUhWimFH4VLr6SEPrxsvhjBt8116WnprkEmKOjHbBCypc44W6pbkjL0js6CQ9zYOcpA5n0eia0DYovIJ0OjdfqmJY03pDHXpSrk/jNbTIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+cDp5/LrSNmSTZKLqyk6K5qegPSnuv5bwF//8FZZNM=;
 b=RKij/ze5Slp/DirjKkhhIE+iFBUDbPdtIkZLv88QobL6Hp9bbIo5ukFuvZJ9UPwVRT1MsDIaopBj7oaZ6h3M3tH3uZIOUooFILJchkzF1t//TzHyaRUhCODNKTV1QdIIlQShyrLmhXVXjr9gVlyf/w0OcLAqx/BOaVv4TgJ1kD9pd1RUGstkIfs7KTDEC11KBUvI5ynSmrKqC8RE7jGw0fDr7P+yMk68DMqwVs06/MDg65Kw4E8YDz9M0ggeBZdJdtMadNja065exTF+EwhONHJbkZeDMpS6jw9iSYZ6EMYH+YrYasbTpwtHDMtyy2DbCsDzP906YPh0UQfihDIf2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+cDp5/LrSNmSTZKLqyk6K5qegPSnuv5bwF//8FZZNM=;
 b=KkRYB9tGseF2i7pkS5MLic/qwbZChw1uj713CUIEaY/SZhGfW7HGnddWLxBc8JaZFYJiCGNJdXDaFLuv9H1OI4dnygHcuKXCaCYyVRDPN7m6rHcqeGvm1SYutVmve87SNYkAz82RbR5e+yL+ffSDMX0zJN1J4FYQz+CHATSZxTI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV8PR12MB9407.namprd12.prod.outlook.com (2603:10b6:408:1f9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.29; Wed, 23 Apr
 2025 14:00:07 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 14:00:07 +0000
Message-ID: <9b6980bb-8f98-424e-ae1c-7ea620d93a44@amd.com>
Date: Wed, 23 Apr 2025 16:00:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: remove DRM_AMDGPU_NAVI3X_USERQ config for
 UQ
To: Alex Deucher <alexdeucher@gmail.com>, "Khatri, Sunil" <sukhatri@amd.com>
Cc: Arvind Yadav <Arvind.Yadav@amd.com>, alexander.deucher@amd.com,
 sunil.khatri@amd.com, Arunpravin.PaneerSelvam@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20250423093359.4424-1-Arvind.Yadav@amd.com>
 <7bd591c8-8101-431c-980d-edadfe26b047@amd.com>
 <CADnq5_Obbx8Zvm7ViGDHhT-bk7aMsb=03OMZfEcY8r_MLBU2gA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_Obbx8Zvm7ViGDHhT-bk7aMsb=03OMZfEcY8r_MLBU2gA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL6PEPF00013E09.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV8PR12MB9407:EE_
X-MS-Office365-Filtering-Correlation-Id: 4571b4d6-7591-407c-17b4-08dd826f2773
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZTVZcCtacmNMc0VNT1NobEdXVjUzYmlDR3BBN3dCWDBkWmxTaWF4TkhteGp1?=
 =?utf-8?B?T0oyNnMybjNzd1FZNHVQQVhIR0tQR2gvZTlFNzNIUUVrUVFnQ0FCeExpc0ls?=
 =?utf-8?B?NUNRYXlDZEVYaUYvTCtod21kazVMMDVRdElBSXAwVHBwc0I0TTY2K0l5MG8y?=
 =?utf-8?B?aWY1ZEZmV0NlTjA0eXlOSFlab1g0Z1UvR2grV0o1dHAySTk0bmhQNUpTMEdv?=
 =?utf-8?B?cmhoaGlIOGhPRlJCMmlBd1F4Z0x3ajBHOWFHVzBFL2MraFVWLzNvUCtZOVZ6?=
 =?utf-8?B?RzhPdXhxYmUzREcyemhBaFVCdlh6MkM5bk5rK1hHTThHaFp4TGRPbnBVWTFD?=
 =?utf-8?B?eC92YS8vNHBCU205UklNWjRaamNkTzhENFo1WGVSenB2WTlCKzZYd1JFSDRz?=
 =?utf-8?B?MjVTZkdHVDdadlpwSkdWNVNFRDMzcEF5Ulpjc3Eya3ZyUmwvcEhydXNjNDRP?=
 =?utf-8?B?Vjd3aXltcXdaaFVlVFg1TmJzT3F3eUY3a2tuenZXUXJyVVBRT2FveFZCakx6?=
 =?utf-8?B?WDd6cUJ3Qnk1QUxKeE1sb0dML2hPd1cyQ2NWcHN3V05WVElHcnJwNmoxOG5Q?=
 =?utf-8?B?dGFhMUFZRlVRTGNKYlI0aUgyTEp0aWtCM05pcUkyYUY4N09LeVVZUUZqTVFP?=
 =?utf-8?B?TWtjdVRYWUJWSDB3aU04YjNWZnZwKzlzWk5RTkppenJ5akhzV1grSUxGTWdM?=
 =?utf-8?B?Mnp2TUJPci95WlVjZGhETzM4QjhWaWZpSGdJTk1UZUluRzBKU3RQeTNUekh0?=
 =?utf-8?B?Z1FjbnF6ajA2YjZ1NkFNU2ZjVDRCcUdxTnRFRk51bFhFVWk1c3p2RkhGRlcz?=
 =?utf-8?B?aHFzM1d4RTdQb3luUlZZTlFwNG0waW9TVjk1UzYvdktNYjVRTnIzbGlRbVJw?=
 =?utf-8?B?Vk1ZQVJCSjh6UGNjaFM4bDM3ci93Y1ZVSW1HNXVXVWdPT1lMZmhWMVczbFpN?=
 =?utf-8?B?T20rRXlDLzBqcXF6NkE1SjdTVmxyMW15VWVBcy9VeGE1eW1mbWluZnpoUDNO?=
 =?utf-8?B?WlhpUEE1SVp3NmpkVDY5b1RMTXJmSUpySmt1ckhLWGZicERXWjVOS3FRbzFX?=
 =?utf-8?B?L1o4Q3FNQXlzRFpHR3VIVVNYVFNPMVhOb2lkeTg5MHIwRGVIc2tURVMvOWUz?=
 =?utf-8?B?T3FVRkFHVW5NazQ5cmxlcGRML09LVDRIdytodHhXNVJiQThwVVRsakZwSXZm?=
 =?utf-8?B?RTJZLzh0ZktFQ0FTMnBoNHRMa2RDS1JobmhubG1xaGoydUFyS2VEbXhUTk93?=
 =?utf-8?B?cXFBUkJsRW1lMnRVVjZPMFo0VW1TVTVzbjZ5WGpXM3hCbkNTeThRekRUdjhl?=
 =?utf-8?B?Q1ZIT1Q1UjNNNElXMjNkY2NxeDZ0b3VTcFhraHYwR0FjZUtoMFJKMi84emty?=
 =?utf-8?B?ankrWE5JSVhkL3h0MGh0S0ZyUTEvcnBPNTV0enpzVyszbEw2ZTJqempXUXZD?=
 =?utf-8?B?bHYwMlR5S1BRTThyMmtnL3dNT1lGS2ZuZGNVeWFkK1V6TTVINDRYcnI0TVQw?=
 =?utf-8?B?UWpObnNETExKNVpLSzVKZ25mQ0FvNXNEckd0b09ueExsWkwyMTd1RVk2MVl1?=
 =?utf-8?B?Ym9PZExlazZnQjZxOHFwWWdodTYwOGpsN2hTeTM3Y25qZUtBZWVvNzZlSi9t?=
 =?utf-8?B?Q2pWUExsMEwxU1hlRXNlRy9lL0phNjg3R1hkWFRYVk9BQThBYjdvRGpyd2VB?=
 =?utf-8?B?UzgrNEpvUWF0NnB4czgvNWhwcWYzNHlSQTdrMDNwWXZkZjFObVB5V3UzWHY3?=
 =?utf-8?B?SjB5cGJyWmxFREdFb1Z4RUhmbXd0SUdVSDE3SlQ3d0VyVWt6UExXeEVBaDVw?=
 =?utf-8?B?V1JoZXFaa0FiaUZFckJOYlpva0xaSW5iSWY0bXRIS2ZaNEJEdy9ZK1dJU1RX?=
 =?utf-8?B?SWlSVlk4VkpaRzlLLzdzUTdkSzVsdXJDRHFYWDRJdlJNYUh1MUZOZW1LT0Zo?=
 =?utf-8?Q?V+DbUhww1IE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDRoQzZFSFNYMnZIQlJOTFdrUGVpblNJSk9xMHZXRnBTTURyV2dFRzZKU2pt?=
 =?utf-8?B?NEhYY1drN3pncDZ1N0FNVmpvQWc0YzZXYmM5ckNLYmNMKzB0elFHdGp5QWJ6?=
 =?utf-8?B?SFhvbzhwcmR4RUdaK2NqWmd4ektrd0Z0eThWUjFxQk1mNzliUFZ1WHhrK1Na?=
 =?utf-8?B?TFJiQi9kNFU0QU5lKzk1SnlHdHlaWkc5dVptSEtlMndreHp1TGtOemFLN2dY?=
 =?utf-8?B?aHFmL1Rib3R0WFErWE0xK3YwSDB1ZjlqS0M0Ty9NeU8vV0RlclNMc1FZKyti?=
 =?utf-8?B?bTRDYVArSVZCZU4wMktJM3JNcnVsSWFtVTNJTVc3anFjSWFkV2xMamwxWUdK?=
 =?utf-8?B?aHZIaHFJSTFkdTBKRTYwQWN0eDB2R1BZZVQvdTh2SXRtS1ZFdm9hbEJVVWIr?=
 =?utf-8?B?TUxDOHJxbUEzL1QxTXJhMW1UaVJnbHVLdmVaaFpwU1Y1YWFGeC9DOTU5TU5y?=
 =?utf-8?B?RXdhbEhoWGNoNjE5MWI3UXhUWG5zZlI0WTFvbXJDNFF3T3M5NndGOElqRW4z?=
 =?utf-8?B?T3BoTUdwVXNPUE1rN0w5Y05xUVlBUU05Y1lwbTZ0Q0ZFSXpjTUdMem10cGt3?=
 =?utf-8?B?SWw2SEVJSEhWR3VqWDNIcEcxSDJYNkp5SmowSm1UQ080Z20rZHl0TXQ4RFZP?=
 =?utf-8?B?RjE2dGRqaDdlM1BkalkydjJDK3pEYUlzcFdUamNnN29YWFNxNlExNkM5TVJM?=
 =?utf-8?B?c1F5TjlUcXBZYnRnMEMweThrOHVmMUcwN1Avdm5QeVFOdG91SUNYK1dHRDVw?=
 =?utf-8?B?OEM1TXYydXEySUZpWEsrYkRxTVFqZE02NkJtMmptVEpXZ3AySHZJRmdUaUQx?=
 =?utf-8?B?RXRIUTBzZHVsWDY1NTR4VGFiWmtnMkVLeURkb2xXbmZHTFlHaXhOaWpWTkhi?=
 =?utf-8?B?RjdaSlBUeENSeVRhamR0WkpQc2VueTR2QjM3bkgxdEVVU3BWa0hEaUpMdmwx?=
 =?utf-8?B?MzhRWFhWZWFKOWZuRmZyMHduWWMraldPRnBwUHpPcjJ4Z1ZnRjdkRUFTYlIv?=
 =?utf-8?B?bngxeDY4OHVJQjdjOGxHUVlIVVhYbmo5RXZYZVZYV0w0Zi9VbkNzODhYWjJy?=
 =?utf-8?B?NkpSMHhzUzlnUjkwaCtvVHJKUEZucmdTVG5BcDlYUjRBQWx6K0dGQXA0dGds?=
 =?utf-8?B?dmFrcksxTFljMTMvOUkxZk16Y3p6UmxWQXVhbm1nZXB5KytXTEZDdnNZMWRQ?=
 =?utf-8?B?OFRDVkpjeFFMZThLWVVmT0xQUlpUSHRrUy9zZzlweFNMeFZNUzFyRDhnenR5?=
 =?utf-8?B?R0hTdjRpOWhDN25yT3JxVTRZMHJUMlRvbW1NbndSdThwVm4rZFlrSkg1TU5O?=
 =?utf-8?B?Nzd3ZWdtYS9hRHJSOU9FdFFQTjJCalNmbStleWxQb2Y3am1VQ0tIVTZYSEZH?=
 =?utf-8?B?TkJFeGV1WGZRYWNWZTRvRlA1YlJaeHVSTWNUbmV3SHgrM1AzVmorV2NQQUxt?=
 =?utf-8?B?Wm92Z3R0MDYxbTVYclRHUTFoeFo5d2N2MjhPK2VmVi9OMlI1aVdZdy95b05s?=
 =?utf-8?B?R0wrS0ViY0M4MUJTZUMxZllraXN0UUJWa3RwdVdDZVQrSGpMelpPbkdZanVw?=
 =?utf-8?B?VFB1OTFXSE10Y3EwQ2o1ckNlMFk1cnJtRmJqMnptYytOMkFlWXQ4OUcrNDU2?=
 =?utf-8?B?ZTY2OUl5QnZDMUJ4V2FLbjE5V21RdTl0Q1NQMUM2dUFUK2hOSUd0RkJnWWtt?=
 =?utf-8?B?QnJQZTkrUEY1TXpxMUdHemlXdDU0VmswZDdWYlVZUXhnbjN3WFlXUE5aZ0Jp?=
 =?utf-8?B?T3NQVWpyTlA0aGJNNDdiNXpxZzVGWG92YkhTNTkrU2doc0FTVEcvZUVJbzFN?=
 =?utf-8?B?TmRSRFl5ODN2cVJNSlNxV2gwWTdMTVJVMlN3WTdaTnUwVlA3d2srUThyandj?=
 =?utf-8?B?MEltNnBTdmpWdFQ4aU9CazE4NFRWQXg5TmhkblloS0owQllGNHJNT2psODcz?=
 =?utf-8?B?SnhKazJwMzJ4Q2ZCSlRQeitNekVVTU10L1NVV2wwMVhRa29Yd3VTQmRrM3Jn?=
 =?utf-8?B?akd6S3dXVW1NcnEzSjFVRlNZQyt4TTE1UGJRNFNSWThQV2FwMWxROGx3YUZV?=
 =?utf-8?B?SGhDTDROdng3QVF6a3NzQlgrMWIzRSt3M0lUeXVnZHN5ZFkwZGlsUm4rVEZJ?=
 =?utf-8?Q?7ONJh4LlvzijsmRtwE5BFpp6b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4571b4d6-7591-407c-17b4-08dd826f2773
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 14:00:07.3212 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fr/xxoVy5xZGVCvxK7UxyzaH/Q7QX0vvxX8j+xrSL8Ebc2BAVSGEU9hxuCGI6c4D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9407
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

On 4/23/25 15:48, Alex Deucher wrote:
> On Wed, Apr 23, 2025 at 6:03 AM Khatri, Sunil <sukhatri@amd.com> wrote:
>>
>> LGTM, Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
>>
>> I think you should also get an acknowledgement from Alex too before
>> pushing to ASDN.
> 
> Please go ahead.
> 
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Feel free to add Reviewed-by: Christian König <christian.koenig@amd.com> as well.

Christian.

> 
>>
>> Regards
>> Sunil khatri
>>
>> On 4/23/2025 3:03 PM, Arvind Yadav wrote:
>>> DRM_AMDGPU_NAVI3X_USERQ config support is not required for
>>> usermode queue.
>>>
>>> v2: rebase.
>>>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>> Cc: Sunil Khatri <sunil.khatri@amd.com>
>>> Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>>> Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/Kconfig             |  8 --------
>>>   drivers/gpu/drm/amd/amdgpu/Makefile            |  2 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c     |  7 +------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c        |  5 +----
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c      |  8 --------
>>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c    | 18 ------------------
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c         |  4 ----
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c         |  2 --
>>>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c         |  3 +--
>>>   drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c         |  3 ---
>>>   10 files changed, 4 insertions(+), 56 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
>>> index 7b95221d2f3d..1a11cab741ac 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
>>> +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
>>> @@ -96,14 +96,6 @@ config DRM_AMDGPU_WERROR
>>>         Add -Werror to the build flags for amdgpu.ko.
>>>         Only enable this if you are warning code for amdgpu.ko.
>>>
>>> -config DRM_AMDGPU_NAVI3X_USERQ
>>> -     bool "Enable amdgpu usermode queues"
>>> -     depends on DRM_AMDGPU
>>> -     default n
>>> -     help
>>> -       Choose this option to enable GFX usermode queue support for GFX/SDMA/Compute
>>> -          workload submission. This feature is experimental and supported on GFX11+.
>>> -
>>>   source "drivers/gpu/drm/amd/acp/Kconfig"
>>>   source "drivers/gpu/drm/amd/display/Kconfig"
>>>   source "drivers/gpu/drm/amd/amdkfd/Kconfig"
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
>>> index 8595e05c691b..87080c06e5fc 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>>> @@ -177,7 +177,7 @@ amdgpu-y += \
>>>       mes_v12_0.o \
>>>
>>>   # add GFX userqueue support
>>> -amdgpu-$(CONFIG_DRM_AMDGPU_NAVI3X_USERQ) += mes_userqueue.o
>>> +amdgpu-y += mes_userqueue.o
>>>
>>>   # add UVD block
>>>   amdgpu-y += \
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index b96e0613ea7e..fe68ba9997ae 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -3513,9 +3513,7 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
>>>       amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
>>>
>>>       amdgpu_amdkfd_suspend(adev, false);
>>> -#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>>>       amdgpu_userq_suspend(adev);
>>> -#endif
>>>
>>>       /* Workaround for ASICs need to disable SMC first */
>>>       amdgpu_device_smu_fini_early(adev);
>>> @@ -5086,9 +5084,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>>>
>>>       if (!adev->in_s0ix) {
>>>               amdgpu_amdkfd_suspend(adev, adev->in_runpm);
>>> -#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>>>               amdgpu_userq_suspend(adev);
>>> -#endif
>>>       }
>>>
>>>       r = amdgpu_device_evict_resources(adev);
>>> @@ -5156,11 +5152,10 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
>>>               r = amdgpu_amdkfd_resume(adev, adev->in_runpm);
>>>               if (r)
>>>                       goto exit;
>>> -#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>>> +
>>>               r = amdgpu_userq_resume(adev);
>>>               if (r)
>>>                       goto exit;
>>> -#endif
>>>       }
>>>
>>>       r = amdgpu_device_ip_late_init(adev);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> index cb9ffb17ab98..cc5d6250ac69 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> @@ -1980,9 +1980,7 @@ static void amdgpu_gfx_kfd_sch_ctrl(struct amdgpu_device *adev, u32 idx,
>>>               if (adev->gfx.userq_sch_req_count[idx] == 0) {
>>>                       cancel_delayed_work_sync(&adev->gfx.enforce_isolation[idx].work);
>>>                       if (!adev->gfx.userq_sch_inactive[idx]) {
>>> -#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>>>                               amdgpu_userq_stop_sched_for_enforce_isolation(adev, idx);
>>> -#endif
>>>                               if (adev->kfd.init_complete)
>>>                                       amdgpu_amdkfd_stop_sched(adev, idx);
>>>                               adev->gfx.userq_sch_inactive[idx] = true;
>>> @@ -2040,9 +2038,8 @@ void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work)
>>>               /* Tell KFD to resume the runqueue */
>>>               WARN_ON_ONCE(!adev->gfx.userq_sch_inactive[idx]);
>>>               WARN_ON_ONCE(adev->gfx.userq_sch_req_count[idx]);
>>> -#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>>> +
>>>               amdgpu_userq_start_sched_for_enforce_isolation(adev, idx);
>>> -#endif
>>>               if (adev->kfd.init_complete)
>>>                       amdgpu_amdkfd_start_sched(adev, idx);
>>>               adev->gfx.userq_sch_inactive[idx] = false;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index b0e8098a3988..451890ee3fb7 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -129,7 +129,6 @@ amdgpu_userq_active(struct amdgpu_userq_mgr *uq_mgr)
>>>       return ret;
>>>   }
>>>
>>> -#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>>>   static struct amdgpu_usermode_queue *
>>>   amdgpu_userq_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
>>>   {
>>> @@ -520,13 +519,6 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>>>
>>>       return r;
>>>   }
>>> -#else
>>> -int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>>> -                    struct drm_file *filp)
>>> -{
>>> -     return -ENOTSUPP;
>>> -}
>>> -#endif
>>>
>>>   static int
>>>   amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> index be068e8e37d1..3288c2ff692e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> @@ -216,7 +216,6 @@ void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv)
>>>       kref_put(&fence_drv->refcount, amdgpu_userq_fence_driver_destroy);
>>>   }
>>>
>>> -#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>>>   static int amdgpu_userq_fence_alloc(struct amdgpu_userq_fence **userq_fence)
>>>   {
>>>       *userq_fence = kmem_cache_alloc(amdgpu_userq_fence_slab, GFP_ATOMIC);
>>> @@ -288,7 +287,6 @@ static int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
>>>
>>>       return 0;
>>>   }
>>> -#endif
>>>
>>>   static const char *amdgpu_userq_fence_get_driver_name(struct dma_fence *f)
>>>   {
>>> @@ -343,7 +341,6 @@ static const struct dma_fence_ops amdgpu_userq_fence_ops = {
>>>       .release = amdgpu_userq_fence_release,
>>>   };
>>>
>>> -#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>>>   /**
>>>    * amdgpu_userq_fence_read_wptr - Read the userq wptr value
>>>    *
>>> @@ -594,15 +591,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>>
>>>       return r;
>>>   }
>>> -#else
>>> -int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>> -                           struct drm_file *filp)
>>> -{
>>> -     return -ENOTSUPP;
>>> -}
>>> -#endif
>>>
>>> -#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>>>   int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>>                           struct drm_file *filp)
>>>   {
>>> @@ -968,10 +957,3 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>>
>>>       return r;
>>>   }
>>> -#else
>>> -int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>> -                         struct drm_file *filp)
>>> -{
>>> -     return -ENOTSUPP;
>>> -}
>>> -#endif
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> index ac7ac58e25a6..519b82f77cff 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> @@ -1630,7 +1630,6 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>>>       case IP_VERSION(11, 0, 0):
>>>       case IP_VERSION(11, 0, 2):
>>>       case IP_VERSION(11, 0, 3):
>>> -#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>>>               if (!adev->gfx.disable_uq &&
>>>                   adev->gfx.me_fw_version  >= 2390 &&
>>>                   adev->gfx.pfp_fw_version >= 2530 &&
>>> @@ -1639,7 +1638,6 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>>>                       adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
>>>                       adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
>>>               }
>>> -#endif
>>>               break;
>>>       case IP_VERSION(11, 0, 1):
>>>       case IP_VERSION(11, 0, 4):
>>> @@ -1647,13 +1645,11 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>>>       case IP_VERSION(11, 5, 1):
>>>       case IP_VERSION(11, 5, 2):
>>>       case IP_VERSION(11, 5, 3):
>>> -#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>>>               /* add firmware version checks here */
>>>               if (0 && !adev->gfx.disable_uq) {
>>>                       adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
>>>                       adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
>>>               }
>>> -#endif
>>>               break;
>>>       default:
>>>               break;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>> index dfa0830a4eb1..f09d96bfee16 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>> @@ -1416,7 +1416,6 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>>>       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>>>       case IP_VERSION(12, 0, 0):
>>>       case IP_VERSION(12, 0, 1):
>>> -#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>>>               if (!adev->gfx.disable_uq &&
>>>                   adev->gfx.me_fw_version  >= 2780 &&
>>>                   adev->gfx.pfp_fw_version >= 2840 &&
>>> @@ -1425,7 +1424,6 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>>>                       adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
>>>                       adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
>>>               }
>>> -#endif
>>>               break;
>>>       default:
>>>               break;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>>> index 6bb36187a53d..da5b5d64f137 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>>> @@ -1363,11 +1363,10 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
>>>       else
>>>               DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
>>>
>>> -#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>>>       /* add firmware version checks here */
>>>       if (0 && !adev->sdma.disable_uq)
>>>               adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
>>> -#endif
>>> +
>>>       r = amdgpu_sdma_sysfs_reset_mask_init(adev);
>>>       if (r)
>>>               return r;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>>> index 943c6446a0a7..befe013b11a7 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>>> @@ -1338,12 +1338,9 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
>>>       else
>>>               DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
>>>
>>> -#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>>>       /* add firmware version checks here */
>>>       if (0 && !adev->sdma.disable_uq)
>>>               adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
>>> -#endif
>>> -
>>>
>>>       return r;
>>>   }

