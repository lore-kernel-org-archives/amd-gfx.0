Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7212AC27C5E
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jun 2024 15:44:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF99910E389;
	Mon, 10 Jun 2024 15:44:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G0faxgsg";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1587810E389
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jun 2024 15:44:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LncIPLSg6Jk1ig/cAyHEsu3ZirTZ+xJbLFNlTWb6mmfzXo+E991+3kJ+TP2DO5UdXrQrkr6GZDNgdm0W+C8P2h49seLJo+ZBzk1BOvpZZvVeHcH5tMf9bo2dZuSldoYqy/aNhSNPnPEq31FVRxOTdWK0HfiBVu7T8fJiH/xVa4lH4IGJQ97dU3zI/UBFfMbI7Q5qGaJ1HvJAEQ0+N/37oEXoZeHH8nKd74YI2gSnWUWPzEQUwKjjm92bAs4yRcNy2UFXiGfwomESfMbotrGxYPzJBQPS5ye3mZkTURwt1uLMdZjz45UDN+NO9W92mP9LoMtezT/ZBL5at7iLJiqgJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0haRWsApZ9lFLxj1Ke3KHoeYmzV0zBAbZ2EhHLd+g7Q=;
 b=SUvyb/Nqf8xjXldHvPCfkOOau1hlTbxpsQ0cpU43i3Pg7JhhXmmyO4lEHdbcc4f+eK1vn/Ygg62SNMVZt5yqtqwcsGbhqH9Ih7+kEK3AzG8Tsw8LZeq3n/TmTpAHBxbAEGZIUpxxNARmykvOWX+4OX0vEaueUPRXbjxtSwmaBooCFiQqNK4bq3SgJTwscnFsXYrqMmKMNoNggzUB9ZWPbgtYoV9AkcrpAfn7w5MObL3ySij1b9BID1FEAejkO6fyhIBCNkbLdYLd9UMp+mswEdjOEsf288uOo6TqTD423J/bjg4NlzoFp/4KOarrOXQ9M7b8l0U630ACRVvkywr0/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0haRWsApZ9lFLxj1Ke3KHoeYmzV0zBAbZ2EhHLd+g7Q=;
 b=G0faxgsgsQSEeiAG0N8ZxS+zvxP2bHhbr4HrS/EOYQfPjuUjF6AUHRVHoFz9yolzfoPaX1x/qcyLhPhj06GGzXhtRKfZ2GTJUcPDpzixsGoECq9WnWlBm0hFrYGU7egzwbAK9HJs3HNw9SPY5czj2gbhxBYM4WYsI9WERyQanlo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) by
 CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.36; Mon, 10 Jun 2024 15:44:16 +0000
Received: from DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::a846:49eb:e660:1b5b]) by DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::a846:49eb:e660:1b5b%6]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 15:44:15 +0000
Message-ID: <9c3791b6-3e81-4cba-8420-9e5f216c331b@amd.com>
Date: Mon, 10 Jun 2024 11:44:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Guard ACPI calls with CONFIG_ACPI
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Harry.Wentland@amd.com,
 alexdeucher@gmail.com
References: <20240610145559.66546-1-sunpeng.li@amd.com>
 <5268367a-3e90-4ad4-a3f0-079eb9634226@amd.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <5268367a-3e90-4ad4-a3f0-079eb9634226@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0230.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::10) To DM4PR12MB5311.namprd12.prod.outlook.com
 (2603:10b6:5:39f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5311:EE_|CH2PR12MB4181:EE_
X-MS-Office365-Filtering-Correlation-Id: c621cb81-cb87-4940-9941-08dc89642eab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmQvVlJpOFVzTE16aFRmM3BVTVJlOENhdjJaT05kS0xwTUpCQnF0Tkttbmgr?=
 =?utf-8?B?dXZWZ1VjMkQ0eWJUdkRFS3Z0MUVDSVNHNU54YmR2SUwyVzJncERQY0dQWUlS?=
 =?utf-8?B?bDhDRG9hVkFYVWU2NkFGakw2ait5dVZ1NmtVQzZna0ZlM1pLZk5lemJJUHB3?=
 =?utf-8?B?RWtLemc3a0FXN2drdk9mbzI4ekNkUW9LMW5SL2FrZEgwdDBoaWxtT1NOVjZp?=
 =?utf-8?B?RlRHUFp6SzlUVlJHbkhDZU5tWE0wTWI2UkFZNU0xVk5MMHZFekR1eERSTko5?=
 =?utf-8?B?L01qcGQzd1gxUVdtZjlEbEhJMFdrK0dkMU4xRTVpVE13ZnpTM0NnMEtnWG44?=
 =?utf-8?B?OEV6VGNEYVdpUTVPUUh4WlNYalRtK3d6dzlkNjNqRDVaS1NQRE90dXJYYlhx?=
 =?utf-8?B?VVpZSUl3dFo0Rm5jRFZCRHU1d0ZoQWdvNS9DMENhQ3ZRcGVjN2ljRXBvMHJh?=
 =?utf-8?B?ZkdvbHcvV3hYZ0ErQ1BPR1VxMEhJSWVQdUZLRmtHQzRSdFd3MHlFbk9aZjZ2?=
 =?utf-8?B?ZjBzeHRWOFRKMnBpVUNTUnZ1VWVzd0xzdzhrNzFsRmpvQ0djNktBMU0vM3JF?=
 =?utf-8?B?TmJPSGVqTHlTQkgybkV0cnd4ejBESUZ2UThhZ21XQ09haXd1bUQ5VXlnUGlk?=
 =?utf-8?B?VWNWNGtubUttcS9xQlBRbVRCemtsUDQwV3NmYjJZRU93SncxYTZJNUR6TW9p?=
 =?utf-8?B?aFBTOWZvQnNoL2QyNGo3MGRnQW0xSTg4Y2hKREpQMEUzUFFGcllqSVA1R3Y1?=
 =?utf-8?B?Ky9VMW1POXZabG9sMGgwV2dQNlRLb3BNNGVZOWZMQzhNRjZFSlhvbWpXSDZ6?=
 =?utf-8?B?c3E3VFFjcC9HWEgrdGpsTmplVmpyVWZEMzFqakNrL3VuZE13MWdsK2hSL1J6?=
 =?utf-8?B?cXUrUTBlY0lUSjhEY0syZ0UyU01mY05YZGZCMHlraFlibGtyN3E3KzNVQjZZ?=
 =?utf-8?B?S0VpUWxYZVNsaTRLaXlxWFBGdWU3S0RVQUFuRFJvME1KSmF1dUNpVFVyWjc2?=
 =?utf-8?B?ZTFPNXdGTUJTVDJFNUJDcTBnVTVYcmNxSDhrdFArWE96V3lXRDg2LzVXeFpX?=
 =?utf-8?B?TWpRZ20yT1ppYzhEYWUxYTlGdUVlZURUbFhIL2Q1bnpZMkdnUHNHTXVmbVRl?=
 =?utf-8?B?OGVLSWxvM05nSnJVakNMSzcxa2cyOG5hRFYwcTk1ZExXU2xhSUpoQ3A5ZWIx?=
 =?utf-8?B?UjdFWDF3WGlyT0FxWVQydEZEdmFUcXZyYTJnY3V1WldoL1ZpaFBWWXZOb01m?=
 =?utf-8?B?dXFMTFZpdmJxYld1Zm9NQWk1bWl1cVY2REREbjE0NDBBblM3YjU2WURnck5r?=
 =?utf-8?B?SmxKQ0N6U3pOd3BXVjd1NnM2SzBEYU0zZEdZMWJ5RUNWa0J5Rzg2cDZTRTJN?=
 =?utf-8?B?dGxQc2RPLzJYKzFuOHA3SXhRY1lKeWNMOFR0MUJ5aFpRUlluT3Vqc3NFY2Jp?=
 =?utf-8?B?bmVOenZHS2R6OW5kM3U1azdhNWJlNHUwUW9QR0VhN1RkUWRJeE8vQ1p6amFE?=
 =?utf-8?B?UU5qQUhUUHF4T3doUmx6aUh6M1hjWHhSQTVXdDlVclJOV2JJYzdsdlhaN3hQ?=
 =?utf-8?B?TERDakZvZmNQM1d6dm1NTEJYZi8vRmJjQ1huT2FZdjFLSUllSC9NYVZwdTE4?=
 =?utf-8?B?bG1EUThMeVl3OXBJaDJiSGh3Y0huMFBaNkhQTUF0eWFXY25KRjFWcVV0ZUdn?=
 =?utf-8?B?SXVXa3F4U3RjeGZsckdpWms1VmgwbmtyN1FOUjkwbUkvSXo5aTNGSzZCb0Zq?=
 =?utf-8?Q?8hDJN/NIyt4TcUuQjj32AKtFb0vZBaLYXoCKct9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5311.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDFmR29hYWl0NFdKTmFnOGVNZFFGeXF2NUlFK2lOeHdQVDgvZXZjK1VtUlQy?=
 =?utf-8?B?eXgrREtwNnVTdEQ3eUtrQkNoZFVacUc5OCs1bXBrRUdzdm5nZmZJSCtrVlc3?=
 =?utf-8?B?UDNZR0hJY1NITWlEWkRsVytGd1NibzV0b0pMNXdlYUNXUFlZMFhuMWVFRnZ1?=
 =?utf-8?B?UTVRRkEyZjcvekFuZnE2MW04VGRoRnNKOU5vTUZ6S1VHb1JKZlVOTGcrbHJL?=
 =?utf-8?B?TVZsbkhrSFdiaFl3cGlwUUxrdzhFd0Y4dEJjUTRYNmVxeU1xZjAzSGQ4N3Ri?=
 =?utf-8?B?eGZReDd1TE1xNVpkUDl0Q0dDZHRHN0k1NVU4R1pVTTlXaUo3V3JBalBURFJN?=
 =?utf-8?B?SDZ2dEtSbHJHYTFrdmRJRzkxWGd6WncrbmFjalptTlJKamZFUE9hc2diMXJh?=
 =?utf-8?B?WVNjbVY5c0NaV21GZWd5OFE1UURMajRITVFtQ2NaYmZ0Wkl0R2dBSGRkWnNk?=
 =?utf-8?B?UlBhWUI5MGg0OGdNSTI4Zi8vaXZKVmlEUm1Rc1BDNDZRaUR5dGJKNE1MaVFj?=
 =?utf-8?B?am0vY1J4QWQvQTBSVUV4WlQySSt5a2FjOHpzS0RiNnVrakI0bHFEL0Z3MkJx?=
 =?utf-8?B?eUpVbXdFRnQxanFjMEpBYmx5aGJncXdBZTZSSUEwZjNVM3U5b095UDV1MWFx?=
 =?utf-8?B?M3JSUzdQbDVxa1F3RUJaWDNHRGxhaEorRC9NaXVIMmJzQUhaR2tXZktOdmps?=
 =?utf-8?B?MEtlK1BFdk1QMzZPOXV5dEh0d1UraFZLNWdCTjlkZlU4R0R0Y0p5QThaQzdo?=
 =?utf-8?B?TDAwOGZxNnRBQnF3bVU3OEhyaS9ZOHNBb3lkRU1EVzQ2dGdHanNYR1pwQTdk?=
 =?utf-8?B?YkF6TnFKa1BtbFpsb0h1MzNwWXRvUDAvNm1nVVdsWTdDeUw2UzlES3JuWXRQ?=
 =?utf-8?B?NWNwVVMyZUpIZGoyQm16T3RvQWpDM3dReGh4UENDQk5iYmxwTG1NTWpyblBG?=
 =?utf-8?B?dG9DTmFjWmh5LzFHbi83WlZPQTlWdDJaYzlYVWlSUlBPbkxXOUFNeWNDSU1X?=
 =?utf-8?B?bE1xb2pDRzdncDBMUDV4SXdBcjJPUDNnU0x2ODlpMmprbGpDM2FWeDV2MEZt?=
 =?utf-8?B?SjgvUmZqNFNXSTBKWFl2L2RIRGp3NXMvUE14RFBlZDVUellieFVEc2o4c05P?=
 =?utf-8?B?L2g1QWRKRE4waUkzQm9FZUdURVVsUmd5U3h2TXU1Wkd6eVhZS1UrRDJ5SndZ?=
 =?utf-8?B?TmtuanFoQTRoSno4YVNpck5NQ3cxTVltOHFzUmc3WmRxK0daL3oxWjU2M1VS?=
 =?utf-8?B?V2NmeHVMRzhNblJpcmVIRkNSdzJQN2oycG9FZHdZZmdua0ptdzlxVmsvSzc4?=
 =?utf-8?B?VW0yZUtkK3VnbHVCZEtBQ0NDL0x3WXlCQzZnZEdFZjJVbWRoYVdNYkFOa05G?=
 =?utf-8?B?TXBRWDBvaHVtTmNudCtONGw2eG02N3R4OXJIRnZhOGtOSEludy8zWlYwTTV0?=
 =?utf-8?B?OFlsZU5KTzRPR3RrSTN4V3plNHV6Sm5YTkZkcjg1VGlvTjA0S2ZZTjJFY3U0?=
 =?utf-8?B?cGoydXFmT21QV2dkd0VuSnpNWmM5SVMweVY1YkpaajdudzM3QTM1c3JqWjEw?=
 =?utf-8?B?TmpISWpZdmJJZ2MzMW9zMjNZeCtFVjZXbmxac3RlRU9KTTBuRlZRZDEyOEl4?=
 =?utf-8?B?bHlhRElVYTJVRDk1WUVaOG5hZUpXSnFVbzNjYTY4eS9LS3RudnBha1c3UXVn?=
 =?utf-8?B?T2laL01rUkV4TUR5Yk9RZ0dVUGRzSzR4aVhGc0ZydjlVdVd5SkltVlN5UTND?=
 =?utf-8?B?bkZKSE14bGo2bUVCSHFvWGdzYTlQTXNHM3pQa0RjODRkQ3NMV2JWbmlaTkR2?=
 =?utf-8?B?bFBldGJDOEpodW91RU5rN1RmN3lZSFJySmkyZDVyZTJxV090K0VhVkd3Uk5a?=
 =?utf-8?B?cVVOZUt5RTBNQ0VqTzJxTXF5L2xpVzlzMDVPeTdHOGc3ZTMxNlRXSjg4ajY3?=
 =?utf-8?B?aHpqQWhYenppdCs1R05RMkVaU1EveWNHL3F5ZXczdFQ0akNSMkhnNjdtNCtv?=
 =?utf-8?B?UjUrbEJXelRBWWZjUy9LWThOVkw2UVVSbFZ3WlZQOEJ3Y2FzWldQcjdFY3NJ?=
 =?utf-8?B?TkVOVFRHcEdmQnU4Y0ZUTEw3SW1raU13eTJIdTg2T0ZVaE5LQWhjTkhnVEpl?=
 =?utf-8?Q?8lf0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c621cb81-cb87-4940-9941-08dc89642eab
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5311.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 15:44:15.3766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hAUQa0IaMCDcImL8roJGCgz0YTVOmhRqO+Ln0PL3XmxIkfO8GJz1L22ByRafP8SD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4181
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



On 2024-06-10 11:32, Mario Limonciello wrote:
> On 6/10/2024 09:55, sunpeng.li@amd.com wrote:
>> From: Leo Li <sunpeng.li@amd.com>
>>
>> To fix CONFIG_ACPI disabled build error.
>>
>> Fixes: ec6f30c776ad ("drm/amd/display: Set default brightness according to ACPI")
>> Signed-off-by: Leo Li <sunpeng.li@amd.com>
>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index a2c098f1b07c..6b3634db4c15 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -4572,7 +4572,9 @@ amdgpu_dm_register_backlight_device(struct 
>> amdgpu_dm_connector *aconnector)
>>       struct drm_device *drm = aconnector->base.dev;
>>       struct amdgpu_display_manager *dm = &drm_to_adev(drm)->dm;
>>       struct backlight_properties props = { 0 };
>> +#if defined(CONFIG_ACPI)
>>       struct amdgpu_dm_backlight_caps caps = { 0 };
>> +#endif
>>       char bl_name[16];
>>       if (aconnector->bl_idx == -1)
>> @@ -4585,6 +4587,7 @@ amdgpu_dm_register_backlight_device(struct 
>> amdgpu_dm_connector *aconnector)
>>           return;
>>       }
>> +#if defined(CONFIG_ACPI)
>>       amdgpu_acpi_get_backlight_caps(&caps);
>>       if (caps.caps_valid) {
>>           if (power_supply_is_system_supplied() > 0)
>> @@ -4593,6 +4596,9 @@ amdgpu_dm_register_backlight_device(struct 
>> amdgpu_dm_connector *aconnector)
>>               props.brightness = caps.dc_level;
>>       } else
>>           props.brightness = AMDGPU_MAX_BL_LEVEL;
>> +#else
>> +    props.brightness = AMDGPU_MAX_BL_LEVEL;
>> +#endif
> 
> Hey Leo,
> 
> Thanks for the patch!
> 
> As caps is initialized to {0} caps.caps_valid will be invalid.  So I see two 
> other ways to solve this that are a little cleaner (IMO):
> 
> 1)  Just block the one call:
> 
> #if defined(CONFIG_ACPI)
>      amdgpu_acpi_get_backlight_caps(&caps);
> #endif
> 
> 2) Add a stub inline no-op function for amdgpu_acpi_get_backlight_caps() to the 
> header.
> 
> I personally think #2 is cleaner (less ifdef makes a lot more readable code).

Agreed, we're using #2 for other ACPI stuff, actually.
Sending v2 soon.

- Leo
> 
>>       props.max_brightness = AMDGPU_MAX_BL_LEVEL;
>>       props.type = BACKLIGHT_RAW;
