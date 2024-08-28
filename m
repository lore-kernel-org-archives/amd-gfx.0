Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFFDFC636DB
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Aug 2024 22:43:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6463010E5F9;
	Wed, 28 Aug 2024 22:43:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kOIN/1CZ";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 707FF10E5F9
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Aug 2024 22:43:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sgj5CVhtZH+8cteIh/9eOHlhwO/CdZzV20BtEvttM7KT1ezkLUN2YpCxga1UP/na48MPE2M0G8maqVCYJUP6J+1L44u+DnIH5NEbAi7GiAGK2Az2sK3fZLJoqjXAYi7NHEIeZPVgsKAwynfDha9G+ojrXoC0A8HFjETZn3gGO7y1zAT+W+KN4KsW+5V26k2dRlC/4LmTSDYcUltMBGKBoXGxGDdPmTZZrHY/QyJjHA+dKaZCkNASY028u7WIQ1eyJKsluCdWMoSmG6XCCYpQY5skeMvLfZP84xQcY2TQhhb7mNU7Tw+Zy2kPWlKBZ4D793e42Z7ZKySK33oG3wR2oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2DLll2QS6ndlwv2VVnCT+QatuBQBGe6RAu/L0qNv3w=;
 b=pKAZS0lpN5p+j02QDiP++xfbwHdUbPWB243sapvzW/To+FXv3M393Rw9c3mWjSqE0TYGQsjdU4hYdAVxFQP8Bavq95isxKEBpJAcLfGpdmXWEjtHbyqFv2yFPHsKCI8BGzsXBBkJ8heukVWaw6Stc56uzgONy9OhHXo5uSRbyvyM8h9EDa2uMfl5QBQXjA+QrK8GIB6EgB7qdQo2NboIsLLanHH9a9OIYpEpxlfsb9Oca++GNr/TyHL0jd2T/6y54uFPL6LB71sMF6tJ5inqZh7GUVLxqz2f9J6MbIEcjuciXuaTPXTsRQ6mbGmjQ2k5mNkMpPuwZxT+qvOQ1PSABQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2DLll2QS6ndlwv2VVnCT+QatuBQBGe6RAu/L0qNv3w=;
 b=kOIN/1CZr+jndIvMJ+NP5UhOH9smyPeKKKjc2I2n0tZbSkfGvsbpToEFJa6jAPnHiuhYefXmOqS31yCzjJ0jpdP8OBAhuATLX3qLnH58T6nYUGiL7t8reb/9OZ4hf8hPgqqseIWn1ssSHU4AzliSXKurFoyUY1TJIo9m6M+5bzk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB7890.namprd12.prod.outlook.com (2603:10b6:510:268::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Wed, 28 Aug
 2024 22:43:41 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%2]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 22:43:41 +0000
Message-ID: <34b018c3-1f1a-4c11-bd3b-2f50262c258b@amd.com>
Date: Wed, 28 Aug 2024 18:43:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Surface svm_attr_gobm, a RW module
 parameter
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240826193420.126272-1-Ramesh.Errabolu@amd.com>
 <773d3d99-4e97-45cf-a457-51989ba3081c@amd.com>
 <DS7PR12MB8321124485D5DF7E4A0CC67CE3952@DS7PR12MB8321.namprd12.prod.outlook.com>
 <77342503-b366-4d8f-93f1-91e75c0682a8@amd.com>
 <DS7PR12MB832146FE01CC9CF5DF499D39E3952@DS7PR12MB8321.namprd12.prod.outlook.com>
 <3ad48bb9-ec0d-4908-a9d6-af60aead9de2@amd.com>
 <82fe94f3-9f45-4cf4-9e52-664f7624a469@amd.com>
 <d97d55a7-da73-4c08-930b-e85c81477b51@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <d97d55a7-da73-4c08-930b-e85c81477b51@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::20) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB7890:EE_
X-MS-Office365-Filtering-Correlation-Id: 44e2ceb8-2f53-4307-8575-08dcc7b2dd74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YjdKQms0NnZVVFQ2L2VzY2RuR2l0cTVuMFZoeHUwY3BKL3JUTG41WkQxb1NG?=
 =?utf-8?B?Ly9abjA0ck00dXk3dnJhdXlOc1NJd1FlR2tBZEF2NmlmN3VibkRjbVlaaitT?=
 =?utf-8?B?b1VjL05lbG5vN0hzeGRtcUY3eklMbUUyYjFKV1JVQ3J5MkU5Qmh1QStrbzFY?=
 =?utf-8?B?Mzh2TUNIMk9ibHZTL1N5WTF1Y0V0c1ZvcGlYTHRDSjRPeUd5c1JoM3VTSVh6?=
 =?utf-8?B?WXZnWlNiaUJ1cWk0djRyaHh0RkJWVEVtK29EeCtyUjhhLzAvM01PeTBUSFFs?=
 =?utf-8?B?bEh0QjRyaU9wM3RjRUFsK0xJdGFXYmgzMFNCMW1BK051RFlIS0tSYkFGRk1h?=
 =?utf-8?B?R3cyRGQwSWhqbDc5R2Mya213a01mMjJ2d0p6WWhsbXVoekNVNkhuQVN1ajhO?=
 =?utf-8?B?eG15M0VldWVxajNDL2VCLy9qTzZEekYzbElXY1ZONzVmdFFFYXRlc0lmUDBL?=
 =?utf-8?B?SzQ3RzROK29uN2cyalZyTG8zaTBUZnYvbHdGdExxM1h6amZybGVpbG54VXUv?=
 =?utf-8?B?MjB6aDlmd0QxUGswRGsxRUs4anRITTllSXFSbkFDdmtPSmlNbHVPS0V5RFIx?=
 =?utf-8?B?V21MT2xxaUo3WjhPZTJHR2RJdEdnNVFySnJpVzJtZzVIY1FvVjUzbnJHck1V?=
 =?utf-8?B?T1lOdDVwOFVwM2RXckFMVFE4U3RTcmxVa1NoOEpCNnpXVTFKT3hyVGdhSFp4?=
 =?utf-8?B?WnRyYm5nbDVHMElONElMeHpBckk5ZEhiYUZ3eDhqaUovRlg5VENKWkNoT3pq?=
 =?utf-8?B?em5Ucmw2N3ltZHNkeGxzUmQ1aWJQL01LWlBMSzRMQ3VBTlFNUVM1WEhuSUI0?=
 =?utf-8?B?SkNjV0c3RC9UK1daN1JqdTJTWXZLa0VyWHNuOTh6RUcySHcwSHRVa0kyc0wz?=
 =?utf-8?B?UmhuN2VWSnFsNit3bUttazhFMDFFMXA2ZjMzZ2xIUlNUUjg1cHpiU01nb3Y2?=
 =?utf-8?B?MjZwMUxzdjNTRE8rVWhzN0hhTTVyWDFaNnBxTkNTNUNWMldQRXE0UXBMQlky?=
 =?utf-8?B?Zit4dGNvSEd3MDZYNUMySDVGcGoxb2lJV2JFZE9jWXVFeGFwQ1BKRjZIelJm?=
 =?utf-8?B?WlpYdXRrNUhIZnVLaUNvQy8rQ2d0RHg4MHdWSGpRaEorQlQ2SmE5ZFpTV3BN?=
 =?utf-8?B?TXlUMzRaRWVtSVM2WXB2UVBSUkdFSVBodFY4SC82WHRleGM0dm8wRllmSExC?=
 =?utf-8?B?c2lXaTZRcFhvQUNHYWFwYXBaMnNkcnRFQW9qZ0FpVDFldHAzTUZuL2xTVDA5?=
 =?utf-8?B?Nld4UU4xTHhMVjV4TENBU29qVUJtNmpPb1ZoY3FVcy95NGZXblBEbmEvd3Nq?=
 =?utf-8?B?UUdBVW5XWXpJQjNmdi94dDRlRjNFQXp4aGVSWFc0UmFuRFdpVzZKRWFsdGdw?=
 =?utf-8?B?Sml6QmpEU0hQM1lrNHZ0MUJnOUlyZ3FsckxtLzVmMldWUitiQkNKSnd1Y1Zx?=
 =?utf-8?B?cVpRNTBhRGxGajNoNVJ3dTFaL3hmckl3bThLZVRhaG1BaWp5ekxJeTBrVjEx?=
 =?utf-8?B?dnhxMnEwS3c0aWJ6M2tJck1CMDhoNlZTbGVLZ2tFN2RLcXpJRWhwTnd4MG42?=
 =?utf-8?B?TGl0WUk1czlXMzVvQkxYK0hySjdDR0Via0hNM2Z3UGYxR2xtay9uUjJnREND?=
 =?utf-8?B?R0lvcDJWb2VaNXhWV3JCckd5QURsZTl1cW90aDIwMU9Oc3FFNEp4YUF3WnRW?=
 =?utf-8?B?ZlRaUXBPRHJGNnErZWZ5SHNnallvd05nd1lPTDhkVWZheXYzcWlBUWJ1c1lR?=
 =?utf-8?B?d0JPWWh6Rlo5ZzVkdTNzWVdjQ1JHK3Rtbm9wNUdQdjZFcmdSaGhRcDVRMEhE?=
 =?utf-8?B?OXJuMkg5OUkvYlNyNk42QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TC9QSGtrd25OTVcyU3oxblh5Tnl0L0c5VWREeFd0UVJ6MVpPcE12QXpjN2hn?=
 =?utf-8?B?aE15dGFNUDVuQ1NLSkdaRktpY09OL2F3aGZYaDBYcUdpMUFDZmdpMmR3cDVj?=
 =?utf-8?B?TXVKaHpVWXNkalpZQ2NkSGV6Zi9RK01aSnoxZXRiZ0NOeE52NEZaeDlGZXpV?=
 =?utf-8?B?a3ZUeE1zTkZESzdRNmZuSTVCUjV1UEdhcEFkQXQ4SmNpdWVEV1Rwd2kwd1FC?=
 =?utf-8?B?RXI4dGh6TVZzVHluN3U5ci94cDU1dmdwQlV4RUVtSFFWVm0rOG1vazVINDIv?=
 =?utf-8?B?aDFtYlArL2o2eWdITlFWeHhyNEdWQy9qQzIzbmZEOGU5SmU1dE9wVkNSdXlr?=
 =?utf-8?B?WHVTanpiM3VzVjJXL1o0Rkl1eExpdTBwc2FKOGE4NEZHbEtQdFFqQ2szWUZ2?=
 =?utf-8?B?SWxwUjJWOUZlaDAwVEZLQkRFM01sSEh6Smx1MzEzbmJZWVhZVnVtck9YSUc3?=
 =?utf-8?B?TVJYWHpZeHdDcU1vcmN6d1BCYVBKM1lhOVRjUklobklUQ0xseTRQTWdkY2c0?=
 =?utf-8?B?MTluWXR4aXZ5UU5yS3U2emtBSWMzM0tScXFSbDRFN1Z2UVVSL0JXU0xqeXBk?=
 =?utf-8?B?ZGtrejErTHd2Vkt6V2pFTjhaUHRuek5LSkxvMmFVMDlPTlNLM0VqcGxzZHJ1?=
 =?utf-8?B?bS93cDJSVmpHb1FtczRkUGlIUFZLT2lSNHBVK08vdXJjRnBuaUtTTElwMUts?=
 =?utf-8?B?VzZ4T0JTS1R3NWR3VXk0KzJsL0tKTWdncngvMDJqTzZVU3B2cHRzZ2ZsZCtW?=
 =?utf-8?B?Uzg4ekEwOWFhTEtUbUVyd3NqVTZ2MSs1WVFNeTUybVo2dk9wNmtRbEY2MlFk?=
 =?utf-8?B?blFlVjE0TCtjREs3NGFMQzV2WW9LQWc1Ymxia0syWEpwa0Juc2xpU2JLSXFU?=
 =?utf-8?B?UGxuR3JxZ2VmQldLNHVvMFdFRzVkd3p3Z3VuNFYrbGR5THBnY0dTL2xIeDNM?=
 =?utf-8?B?cGdRc3pYNVdrOU1PUXRrWUx0M1pzMUJTSmFMOU5iYVFiYmNqeTFoaW45M29R?=
 =?utf-8?B?M0NkbXZwM3RRNW5EaSt0NkdlTmtkWW1LUHdXUkNlZDdwZ2FvQjdjbTkxZ1h1?=
 =?utf-8?B?aTljbEsyQ3EveHJYcXpvVmZKWVVURnk4am5Yb3VQSnRjbzZkRU9IQ3RsTWJw?=
 =?utf-8?B?ZWY0VS9PakJHdWNvcjVzcnc5MWFsV1dvdEl4TmE1bFF4Q3VpUWlHZ0FiaTJo?=
 =?utf-8?B?Yllva0hlRkdIcmZzQ3M5V3VTNkNqVDZ6ZzdyWnl2NytHVHB0ZWh2eWo4Rk16?=
 =?utf-8?B?eEkxUGdGTHlXdkRUOWs0Y2g4STJRcUloL0QxRmZjdjU0cTI0TWQ0NzRDM1Vw?=
 =?utf-8?B?LytkTzBQc3Z1TE5SbHRrK0VQQUtRZnEwS2g4YmpiamhTNHQxc0l3TWlkdVBX?=
 =?utf-8?B?RUhtMEIyVXFBcHFFRXJ3ckZCSGJJMnhqNWNyVERvY1l1eWM5Ykszb2hCUUd3?=
 =?utf-8?B?cUV2SGowQ0hTQ3RpaGNZYnYwekVDclg1RXhDZjBiaDczbW8vVFVEMGkyUERl?=
 =?utf-8?B?RDFCTndsS1BWN0JtR2FFaEV2R09sTThNck9rZHJpTUgrY3kxOWx0d2Z2R0hC?=
 =?utf-8?B?NUhqUU1MQ1ZEOU10eEltMGovRXRDTnZWTmtjbGtKbVVaMzVDNkIrWnFQV0No?=
 =?utf-8?B?NUlYRjVWY2pRMjBUYlN3YTJNYWpOVVBEcXZJUmtuSTIxNTUzbXBiK2dEQ2xa?=
 =?utf-8?B?OXBiSFRScFFrZEpGbnlYVGZDQWdVT29HUXBJZ3lFQmtEcFJHeWxlT0JvMmhQ?=
 =?utf-8?B?OEFIcWJsc2RBVnNTZXNPRjFMaWplUE1qRWVmOHlpazlWZi91aGhMeERWSHZV?=
 =?utf-8?B?dFQxdkw0K2dUcHVqL0lwZTc5UGx0clJUMmNNV1ZVd3hSR1NYa1ZoWjc4blMz?=
 =?utf-8?B?SHppWjV1clloaUh2ZXlJaEZyOWFzS2Z2TkVid1RlUEVoa2RaRkVubTRDdVFP?=
 =?utf-8?B?VHpzbmpiQkg3OFFENTZ3VEVaOWdlNDBwTGk2NzN3V0h4T3Y0WDJQMzRoUGw4?=
 =?utf-8?B?NFVVZDVlSHRSUTVGS2VzRDVyeW1IY210VmZiOXoxbnpYZk12d3dGaDh0NnNW?=
 =?utf-8?B?NzFiRENMMEo0TmF0bm55MkdvWGh3ZDUwS1FyZHFmUGQ2Y1lQRVRmR010NFh0?=
 =?utf-8?Q?L5LlvgQJeB7zVcjXThBE0BpVg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e2ceb8-2f53-4307-8575-08dcc7b2dd74
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 22:43:41.4447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LBssS+nNEBFnj/JIno5DsSOxaIjFT/yQTtQlOU5kpTM2AOWx3oibBrpf2FTkPzql/QOdWfjjslwAstO3T+1iFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7890
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


On 2024-08-28 17:38, Chen, Xiaogang wrote:
>
>
> On 8/28/2024 4:05 PM, Felix Kuehling wrote:
>>
>> On 2024-08-28 16:34, Chen, Xiaogang wrote:
>>>
>>>
>>> On 8/28/2024 3:26 PM, Errabolu, Ramesh wrote:
>>>>
>>>> Responses inline
>>>>
>>>> Regards,
>>>>
>>>> Ramesh
>>>>
>>>> *From:*Chen, Xiaogang <Xiaogang.Chen@amd.com>
>>>> *Sent:* Wednesday, August 28, 2024 3:01 PM
>>>> *To:* Errabolu, Ramesh <Ramesh.Errabolu@amd.com>; 
>>>> amd-gfx@lists.freedesktop.org
>>>> *Subject:* Re: [PATCH v2] drm/amdgpu: Surface svm_attr_gobm, a RW 
>>>> module parameter
>>>>
>>>> On 8/28/2024 2:52 PM, Errabolu, Ramesh wrote:
>>>>
>>>>     Response inline
>>>>
>>>>     Regards,
>>>>
>>>>     Ramesh
>>>>
>>>>
>>>>     -----Original Message-----
>>>>
>>>>     From: Chen, Xiaogang<Xiaogang.Chen@amd.com> 
>>>> <mailto:Xiaogang.Chen@amd.com>
>>>>     Sent: Wednesday, August 28, 2024 2:43 PM
>>>>
>>>>     To: Errabolu, Ramesh<Ramesh.Errabolu@amd.com> 
>>>> <mailto:Ramesh.Errabolu@amd.com>;amd-gfx@lists.freedesktop.org
>>>>
>>>>     Subject: Re: [PATCH v2] drm/amdgpu: Surface svm_attr_gobm, a RW 
>>>> module parameter
>>>>
>>>>     Why need this driver parameter? kfd has 
>>>> KFD_IOCTL_SVM_ATTR_GRANULARITY api that allows user space to set 
>>>> migration granularity per prange. If both got set which will take 
>>>> precedence?
>>>>
>>>>     Ramesh: Use of Kfd Ioctl is available to users of registered 
>>>> memory. It allows users to control GOBM per buffer level, including 
>>>> overwriting default value. For ranges that do not specify GOBM, the 
>>>> default value will be found.
>>>>
>>>> If user space use KFD_IOCTL_SVM_ATTR_GRANULARITY it will overwrite 
>>>> this parameter value for a prange, then how to know which 
>>>> granularity take effect? That is decided when user set this 
>>>> parameter and when the api got used.
>>>>
>>>> Ramesh: The value bound by Kfd ioctl will take effect. In the life 
>>>> cycle of a prange it can go from the default value to one that is 
>>>> set by user via set_attr() call. However, it is generally 
>>>> understood that that users of set_attr() will not call it directly 
>>>> i.e. the rely on higher level apis from ROCr or HIP.
>>>>
>>> driver parameter can be set at run time, not only at boot time. It 
>>> is not predictable  when user set this driver parameter and when the 
>>> api got called.
>>>
>> I don't think this is a problem. The module parameter determines the 
>> granularity if the application doesn't set the virtual address range 
>> attribute. The default is captured in the per-process svms structure. 
>> So all mappings of the same process will use the same default, even 
>> if the module parameter is changed after the process is started. The 
>> get_attr ioctl will always return the actual granularity, no matter 
>> whether it comes from the default or was overridden by user mode for 
>> the virtual address range.
>
> My concern is there are two ways to set pragne's granularity, both can 
> be used at run time. It can make confusion to know which one take 
> effect as user can use driver parameter and api to change granularity 
> with any timing.
>
But it's not "any timing". For the module parameter to take effect, it 
has to be set _before_ the process starts. Any changes to the module 
parameter after the process starts will not take effect.

Regards,
   Felix


> Regards
>
> Xiaogang
>
>>
>> Regards,
>>   Felix
>>
>>
>>> Regards
>>>
>>> Xiaogang
>>>
>>>> Regards
>>>>
>>>> Xiaogang
>>>>
>>>>     Regards
>>>>
>>>>     Xiaogang
>>>>
>>>>     On 8/26/2024 2:34 PM, Ramesh Errabolu wrote:
>>>>
>>>>         Caution: This message originated from an External Source. 
>>>> Use proper caution when opening attachments, clicking links, or 
>>>> responding.
>>>>
>>>>         Enables users to update the default size of buffer used in 
>>>> migration
>>>>
>>>>         either from Sysmem to VRAM or vice versa.
>>>>
>>>>         The param GOBM refers to granularity of buffer migration, 
>>>> and is
>>>>
>>>>         specified in terms of log(numPages(buffer)). It facilitates 
>>>> users of
>>>>
>>>>         unregistered memory to control GOBM, albeit at a coarse level
>>>>
>>>>         Signed-off-by: Ramesh Errabolu<Ramesh.Errabolu@amd.com> 
>>>> <mailto:Ramesh.Errabolu@amd.com>
>>>>
>>>>         ---
>>>>
>>>>            drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  4 ++++
>>>>
>>>>            drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 18 
>>>> +++++++++++++++++
>>>>
>>>>            drivers/gpu/drm/amd/amdkfd/kfd_priv.h   | 12 ++++++++++++
>>>>
>>>>            drivers/gpu/drm/amd/amdkfd/kfd_svm.c    | 26 
>>>> ++++++++++++++++---------
>>>>
>>>>            4 files changed, 51 insertions(+), 9 deletions(-)
>>>>
>>>>         diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>
>>>>         b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>
>>>>         index e8c284aea1f2..73dd816b01f2 100644
>>>>
>>>>         --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>
>>>>         +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>
>>>>         @@ -237,6 +237,7 @@ extern int sched_policy;
>>>>
>>>>            extern bool debug_evictions;
>>>>
>>>>            extern bool no_system_mem_limit;
>>>>
>>>>            extern int halt_if_hws_hang;
>>>>
>>>>         +extern uint amdgpu_svm_attr_gobm;
>>>>
>>>>            #else
>>>>
>>>>            static const int __maybe_unused sched_policy = 
>>>> KFD_SCHED_POLICY_HWS;
>>>>
>>>>            static const bool __maybe_unused debug_evictions; /* = 
>>>> false */ @@
>>>>
>>>>         -313,6 +314,9 @@ extern int amdgpu_wbrf;
>>>>
>>>>            /* Extra time delay(in ms) to eliminate the influence of 
>>>> temperature momentary fluctuation */
>>>>
>>>>            #define AMDGPU_SWCTF_EXTRA_DELAY               50
>>>>
>>>>         +/* Default size of buffer to use in migrating buffer */
>>>>
>>>>         +#define AMDGPU_SVM_ATTR_GOBM       9
>>>>
>>>>         +
>>>>
>>>>            struct amdgpu_xcp_mgr;
>>>>
>>>>            struct amdgpu_device;
>>>>
>>>>            struct amdgpu_irq_src;
>>>>
>>>>         diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>
>>>>         b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>
>>>>         index b9529948f2b2..09c501753a3b 100644
>>>>
>>>>         --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>
>>>>         +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>
>>>>         @@ -169,6 +169,17 @@ uint amdgpu_sdma_phase_quantum = 32;
>>>>
>>>>            char *amdgpu_disable_cu;
>>>>
>>>>            char *amdgpu_virtual_display;
>>>>
>>>>            bool enforce_isolation;
>>>>
>>>>         +
>>>>
>>>>         +/* Specifies the default size of buffer to use in
>>>>
>>>>         + * migrating buffer from Sysmem to VRAM and vice
>>>>
>>>>         + * versa
>>>>
>>>>         + *
>>>>
>>>>         + * GOBM - Granularity of Buffer Migration
>>>>
>>>>         + *
>>>>
>>>>         + * Defined as log2(sizeof(buffer)/PAGE_SIZE)  */ uint
>>>>
>>>>         +amdgpu_svm_attr_gobm = AMDGPU_SVM_ATTR_GOBM;
>>>>
>>>>         +
>>>>
>>>>            /*
>>>>
>>>>             * OverDrive(bit 14) disabled by default
>>>>
>>>>             * GFX DCS(bit 19) disabled by default @@ -320,6 +331,13 @@
>>>>
>>>>         module_param_named(pcie_gen2, amdgpu_pcie_gen2, int, 0444);
>>>>
>>>>            MODULE_PARM_DESC(msi, "MSI support (1 = enable, 0 = 
>>>> disable, -1 = auto)");
>>>>
>>>>            module_param_named(msi, amdgpu_msi, int, 0444);
>>>>
>>>>         +/**
>>>>
>>>>         + * DOC: svm_attr_gobm (uint)
>>>>
>>>>         + * Size of buffer to use in migrating buffer from Sysmem 
>>>> to VRAM and
>>>>
>>>>         +vice versa  */ MODULE_PARM_DESC(svm_attr_gobm, "Defined as
>>>>
>>>>         +log2(sizeof(buffer)/PAGE_SIZE), e.g. 9 for 2 MiB");
>>>>
>>>>         +module_param_named(svm_attr_gobm, amdgpu_svm_attr_gobm, 
>>>> uint, 0644);
>>>>
>>>>         +
>>>>
>>>>            /**
>>>>
>>>>             * DOC: lockup_timeout (string)
>>>>
>>>>             * Set GPU scheduler timeout value in ms.
>>>>
>>>>         diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>
>>>>         b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>
>>>>         index 9ae9abc6eb43..c2e54b18c167 100644
>>>>
>>>>         --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>
>>>>         +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>
>>>>         @@ -868,6 +868,18 @@ struct svm_range_list {
>>>>
>>>>                   struct task_struct *faulting_task;
>>>>
>>>>                   /* check point ts decides if page fault recovery 
>>>> need be dropped */
>>>>
>>>>                   uint64_t checkpoint_ts[MAX_GPU_INSTANCE];
>>>>
>>>>         +
>>>>
>>>>         +       /* Indicates the default size to use in migrating
>>>>
>>>>         +        * buffers of a process from Sysmem to VRAM and vice
>>>>
>>>>         +        * versa. The max legal value cannot be greater than
>>>>
>>>>         +        * 0x3F
>>>>
>>>>         +        *
>>>>
>>>>         +        * @note: A side effect of this symbol being part of
>>>>
>>>>         +        * struct svm_range_list is that it forces all buffers
>>>>
>>>>         +        * of the process of unregistered kind to use the same
>>>>
>>>>         +        * size in buffer migration
>>>>
>>>>         +        */
>>>>
>>>>         +       uint8_t attr_gobm;
>>>>
>>>>            };
>>>>
>>>>            /* Process data */
>>>>
>>>>         diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>
>>>>         b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>
>>>>         index b44dec90969f..78c78baddb1f 100644
>>>>
>>>>         --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>
>>>>         +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>
>>>>         @@ -309,12 +309,11 @@ static void svm_range_free(struct 
>>>> svm_range *prange, bool do_unmap)
>>>>
>>>>            }
>>>>
>>>>            static void
>>>>
>>>>         -svm_range_set_default_attributes(int32_t *location, 
>>>> int32_t *prefetch_loc,
>>>>
>>>>         -                                uint8_t *granularity, 
>>>> uint32_t *flags)
>>>>
>>>>         +svm_range_set_default_attributes(int32_t *location,
>>>>
>>>>         +                       int32_t *prefetch_loc, uint32_t 
>>>> *flags)
>>>>
>>>>            {
>>>>
>>>>                   *location = KFD_IOCTL_SVM_LOCATION_UNDEFINED;
>>>>
>>>>                   *prefetch_loc = KFD_IOCTL_SVM_LOCATION_UNDEFINED;
>>>>
>>>>         -       *granularity = 9;
>>>>
>>>>                   *flags =
>>>>
>>>>                           KFD_IOCTL_SVM_FLAG_HOST_ACCESS | 
>>>> KFD_IOCTL_SVM_FLAG_COHERENT;
>>>>
>>>>            }
>>>>
>>>>         @@ -358,9 +357,9 @@ svm_range *svm_range_new(struct 
>>>> svm_range_list *svms, uint64_t start,
>>>>
>>>> bitmap_copy(prange->bitmap_access, svms->bitmap_supported,
>>>>
>>>>                                       MAX_GPU_INSTANCE);
>>>>
>>>>         +       prange->granularity = svms->attr_gobm;
>>>>
>>>> svm_range_set_default_attributes(&prange->preferred_loc,
>>>>
>>>>         - &prange->prefetch_loc,
>>>>
>>>>         - &prange->granularity, &prange->flags);
>>>>
>>>>         + &prange->prefetch_loc,
>>>>
>>>>         + &prange->flags);
>>>>
>>>>                   pr_debug("svms 0x%p [0x%llx 0x%llx]\n", svms, 
>>>> start, last);
>>>>
>>>>         @@ -2693,10 +2692,12 @@ svm_range_get_range_boundaries(struct
>>>>
>>>>         kfd_process *p, int64_t addr,
>>>>
>>>>                   *is_heap_stack = vma_is_initial_heap(vma) ||
>>>>
>>>>         vma_is_initial_stack(vma);
>>>>
>>>>         +       /* Determine the starting and ending page of prange */
>>>>
>>>>                   start_limit = max(vma->vm_start >> PAGE_SHIFT,
>>>>
>>>>         -                     (unsigned long)ALIGN_DOWN(addr, 2UL 
>>>> << 8));
>>>>
>>>>         +                     (unsigned long)ALIGN_DOWN(addr, 1 <<
>>>>
>>>>         + p->svms.attr_gobm));
>>>>
>>>>                   end_limit = min(vma->vm_end >> PAGE_SHIFT,
>>>>
>>>>         -                   (unsigned long)ALIGN(addr + 1, 2UL << 8));
>>>>
>>>>         +                   (unsigned long)ALIGN(addr + 1, 1 <<
>>>>
>>>>         + p->svms.attr_gobm));
>>>>
>>>>         +
>>>>
>>>>                   /* First range that starts after the fault 
>>>> address */
>>>>
>>>>                   node = interval_tree_iter_first(&p->svms.objects, 
>>>> addr + 1, ULONG_MAX);
>>>>
>>>>                   if (node) {
>>>>
>>>>         @@ -3240,6 +3241,12 @@ int svm_range_list_init(struct 
>>>> kfd_process *p)
>>>>
>>>>                           if 
>>>> (KFD_IS_SVM_API_SUPPORTED(p->pdds[i]->dev->adev))
>>>>
>>>> bitmap_set(svms->bitmap_supported, i, 1);
>>>>
>>>>         +       /* Bind granularity of buffer migration, either
>>>>
>>>>         +        * the default size or one specified by the user
>>>>
>>>>         +        */
>>>>
>>>>         +       svms->attr_gobm = min_t(u8, amdgpu_svm_attr_gobm, 
>>>> 0x3F);
>>>>
>>>>         +       pr_debug("Granularity Of Buffer Migration: %d\n",
>>>>
>>>>         + svms->attr_gobm);
>>>>
>>>>         +
>>>>
>>>>                   return 0;
>>>>
>>>>            }
>>>>
>>>>         @@ -3767,8 +3774,9 @@ svm_range_get_attr(struct kfd_process 
>>>> *p, struct mm_struct *mm,
>>>>
>>>>                   node = interval_tree_iter_first(&svms->objects, 
>>>> start, last);
>>>>
>>>>                   if (!node) {
>>>>
>>>>                           pr_debug("range attrs not found return 
>>>> default values\n");
>>>>
>>>>         - svm_range_set_default_attributes(&location, &prefetch_loc,
>>>>
>>>>         - &granularity, &flags_and);
>>>>
>>>>         +               granularity = svms->attr_gobm;
>>>>
>>>>         + svm_range_set_default_attributes(&location,
>>>>
>>>>         +     &prefetch_loc, &flags_and);
>>>>
>>>>                           flags_or = flags_and;
>>>>
>>>>                           if (p->xnack_enabled)
>>>>
>>>>                                   bitmap_copy(bitmap_access,
>>>>
>>>>         svms->bitmap_supported,
>>>>
>>>>         --
>>>>
>>>>         2.34.1
>>>>
