Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199A6CAC5B5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 21:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2EC810E16E;
	Thu, 25 Sep 2025 21:47:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZowPwOrC";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013021.outbound.protection.outlook.com
 [40.107.201.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19E6810E16E
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 21:47:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ep5Rw28lJzWEpuxSVD44+YXKNKxHBRywMBV5Iav8hjo/cQX5CailVVBW7P2+tTIxN+Efl2A7GCoKHdFtDrkzRUNPRJnrnwOZM8rcbmyK4VP0pQrI1K1tDjEV4QQTaKwHyCunDF3GT96CmyR8FeyRAthhdL8/XZQ2w9Q88BCScuf/SPEm++2xdXCFDFI79A5clgBp3YnUXGTUcgY0+W+N7Fp/V3+vEAlxil+ZUWaZnLRFoYcytqlR/soPJKsUrODoRTAQdwa9ZSfFDNC5dax9gtbqRtmccbuJecQa8VqqbVIEIGTi9GR3vMKIa7HwEimZHpM1NXQzVkcw2yTUCb+DCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QscesJG+2ZCFiGFIeqw5b+s3bvISn5yahyDX9U+VUr0=;
 b=v5eIHC9oRs8HMb2P4nT1pG5IITIe8rChwEVkttzRxo9OpyPekxsZH2ZOftuJPYgz1UqyCA68KRhbaIkUzIbb24foLuGD7GxLWZ8TmHqebJLTP2z3EAc2nCy+WGv2M2EuRsNcLmPxoILf5i5CB0thkQQDSSxwAq9kyPD+6GkA2b/ZPdeiG8bLmzbqTZO+vXMU6YnSCeaUmfpQaAQ5ozYh7S44MWFyE953rB4wbtaUfLt9y/nBdiUZvbQfSISTt8QdijkRI5bvgP6v+dUz4l87kUdLTp8wPbIK5bfU1aqwX32k3fNfEmHz/v6PvRFOz2VjAC/ArT5JeMjxJU8ene1BBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QscesJG+2ZCFiGFIeqw5b+s3bvISn5yahyDX9U+VUr0=;
 b=ZowPwOrC+2mAKauRCvBihkhb0eIPYqC9Kn8utLt2GbYqvzUWhRJJL8opq2PNBwiPdXH2u5s3Fy5No7V5l1S+E3b01TYBZ2Heh0aZ59+20WTo3P8TKBRpNWFEYH/b312RH8nOR+ZZL56ofOIgaDDJEHnQu8NkqOSgeGE5X3ueNPY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7SPRMB0010.namprd12.prod.outlook.com (2603:10b6:8:87::8) by
 LV8PR12MB9668.namprd12.prod.outlook.com (2603:10b6:408:295::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.23; Thu, 25 Sep
 2025 21:47:12 +0000
Received: from DS7SPRMB0010.namprd12.prod.outlook.com
 ([fe80::b021:a6a0:9c65:221e]) by DS7SPRMB0010.namprd12.prod.outlook.com
 ([fe80::b021:a6a0:9c65:221e%7]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 21:47:11 +0000
Message-ID: <594dacee-2475-4b79-8b41-897b47169df2@amd.com>
Date: Thu, 25 Sep 2025 16:47:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Check whether secure display TA loaded
 successfully
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250925191402.2518978-1-mario.limonciello@amd.com>
 <CADnq5_M7_LTPz7KjtCWHH3XP5OZsFZoO=odqNPtkOLdgxXU-LA@mail.gmail.com>
 <b9863279-9303-4acf-961d-bbcd624c1cc5@amd.com>
 <CADnq5_Punstwk7HgX7R_gQ7+3pp5o81uirPY+VAkwF70N8JJcQ@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_Punstwk7HgX7R_gQ7+3pp5o81uirPY+VAkwF70N8JJcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:805:de::39) To DS7SPRMB0010.namprd12.prod.outlook.com
 (2603:10b6:8:87::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7SPRMB0010:EE_|LV8PR12MB9668:EE_
X-MS-Office365-Filtering-Correlation-Id: b2f7b6e2-567d-43dc-40cf-08ddfc7d156a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SCtZY3ZBZnFSdm5QdHhReERLdHRMclA5SXZKeVpSckJtcFVpRjFxcjdXSnRz?=
 =?utf-8?B?emY4RXVNTlZ3RXU3aVBmOXFraFRhYmxoWlZkeHBGL0VmMmh2dFdzMk80Zld5?=
 =?utf-8?B?Wm15cmRqTjRzVnJYSWFDcHVRN3VzaXE5VkdIR0cveVh3SDhSQ0tUbCt5cCs5?=
 =?utf-8?B?eGxUZ2RJR05MNEJlaDJrek1yYkxWb0EyK1FKeHpNUTNXMUV2ekFYYkJUOE9w?=
 =?utf-8?B?SnJPVVF6Qm5FdFR0OEkybjFmKzdkTEIwNnVrSTk2ZDZSbjhSR09waWRZTSsz?=
 =?utf-8?B?MUhwYzQ2UDNUV1V1SjlLU3NCQTF6RG9Rd3dEK0NCYUNYVFpUSFYzY3hVNjZJ?=
 =?utf-8?B?Vjl4K1dPMWp3Zi9FelZHb0pDUVdsWnBEQ2xkbnFMcHk3M0lYdi9JWXp5SmZK?=
 =?utf-8?B?bXhnVlhXMVJWc1ZGYXIveWd0U1RaSkFNWWg2Y0pKeFRHTjhKZ3NFbFgvMXJn?=
 =?utf-8?B?TWFkZVcwK2d0Qko4ZXo4ZGZCSkxuYnBPeXM4Tkloa2VkeFFna0l0UjIyOGt2?=
 =?utf-8?B?dnpubDVCcngxZ2IvZFEyZGJmekJJYjBqbkRPb2phQXk0NUJRN2prMlRtdmxy?=
 =?utf-8?B?dnNIR2RaZDA5S3VLaWFlU2ZRSnUxWjc0bWYyZ211SmFkSE5aTTVCS1NtOVNq?=
 =?utf-8?B?YTlVYngxNVBPMTJIMWNXSmxhWDNTYmM3cGNFblJIaVN2TzRFL3ZocEw5c3d5?=
 =?utf-8?B?ajNxYTQ5QkVPTjVDRUh0c041azhqME1PdFkyWUd1ak94cWVMeHZoNEtiWHlt?=
 =?utf-8?B?cThkeDJlTGJURGlmZCtta2k2WnZuZ3RKMHU1YVIxKzJMcENLbUc0TWtXbEox?=
 =?utf-8?B?QzJpSGJ5MG9vb3J1WFErMXhQeUhtTTI4aFZ3QWkzQmRIak52cWtvdjR4Y3pv?=
 =?utf-8?B?QXN6N3luQ3lLdFptUy9aTVFKNUd2YnpWQlRmVkoveDZrTGFCYVl3aHArVk5H?=
 =?utf-8?B?Vkw5MFF1VFRtRUFOMUFBTUZXdW8vTVd2LzJmdUFnOFY4ODExdFRZYTAySjlW?=
 =?utf-8?B?N1BET0xMRkdwMFJsWTRBejB4UFVCa3JBM2hrL1ZCQ0trM09IVkMzYnFxL250?=
 =?utf-8?B?LzNHaFlyRXFQY0NlV21vNURSeFFKWk05b0E3ZUJWV05nZFpvN2h4NmRQMytE?=
 =?utf-8?B?ZTJoU244ZU4vcVY5VnFQV2Fzc2NMOXZ6UFRRZFcveDA5aFlkSlZONkZaS2hj?=
 =?utf-8?B?VDhySXR2S1BqWFNCWnUwSzBXVUxjbVlaNHVLS3VCNVIrY1VRZHdVTlpLMStU?=
 =?utf-8?B?NGgxRHREd01WVDB4bG9ucS9tWEdMdnhiV1RrYW45dVZEdUJuWEFJQi9jRlho?=
 =?utf-8?B?MFZXSUpyRjBrS0hkQlZFRTk5Ykx1OFBhekZ3amxHOC80SW1udWMwK24rU0Jk?=
 =?utf-8?B?Y2UzSHJZZlo0eXk3akpNNEY2OEhtOHhxdi9QZzdKMWhINHJkM1hGZkg1RmRV?=
 =?utf-8?B?QnNNVGJXN3IzUTdXOFNIdkE1c2wzZkVIcEFySzA0d1J2b2dIekZXQ0ZrNFZr?=
 =?utf-8?B?M2ZDZFQwYnBuQ3J4SXJYUFZKdXVjWDFuNlpTR1NvZGhlRFYyNTdoWEVjOUJK?=
 =?utf-8?B?eGZjSFNCdUQ1dUduR1VITUJ2R2F6czlkb3Z0aGFXOHpFekpkMFEzMEUzRklZ?=
 =?utf-8?B?Z2VFUWpaWS9QNmR0VzFKSUg2UG51YmtrRGdSUFVMNExDckRreU1VN3ljUGRp?=
 =?utf-8?B?SUJNUXlhNDRWbFN5K01zTEVWeVVpUU41K1kweFlPVHJ5VlJjMzlDL0RNSndv?=
 =?utf-8?B?Mk1CazF2dUd0UUtrRlpoV0xkOUZwdFVKTCsxS2FML0hPNm9LL1R3SGRLYTk2?=
 =?utf-8?B?cVVPTzJQaGFvUm5nTW8rZkFOaGJycWljQVV5RTFkcUZZVUhSWVZJMTh5NUVP?=
 =?utf-8?B?S3c3SVZxcEM2ZnRhT1M5QTBEeUhrNDZoNGRsdEx2U3VRUUE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7SPRMB0010.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVZ2ZU0ySFoyZUM3Qk1jejRWUEt3WXh2SDU5Zi9teFNRWmVpcEhuOEtFdkZY?=
 =?utf-8?B?UHR5NG01SlNHVDc0cG9QUlF2em5CMzg4bWxhU3N2Z2owZFZrcVhIZHh3Nm81?=
 =?utf-8?B?UnN1SmE2RmNZWTJaaFhUMWptcktSUVZjV2QvZ3phZW9KWlVSclROdUNnNHZH?=
 =?utf-8?B?aFhBMW53ZnZQNFNZb1NxdU1JU0YveWpoek1NcEV0S1dxNTNqUDZyWC9KWmZ2?=
 =?utf-8?B?N090STFxVUVwZHBMUG14QzllODEyZGgxTmZiUllkajVkNnR4ekYzZUNvZ1Az?=
 =?utf-8?B?ZjA3bU5pekhsaU9udG9SOUNFYksxaW5BRUJPekFCVGIzT2dDR1VxcmpaSzlO?=
 =?utf-8?B?ZVhvanZvUXMxcXZ1WmlHYktvcXBNVnMxRXh6SDMwRzcwemo2TVl6c1FORDRY?=
 =?utf-8?B?eEc1SkRmTVlMRGczNkZHcWhWNUs4cjY1bEhPSjVLcnJ0MW5NTGxUazhCWExp?=
 =?utf-8?B?aW4ybEREVmNXVTZWRlg3V1FoZU9KN3oxd3dDcFkvc1BHOUhsTE1UbXduUjJs?=
 =?utf-8?B?ZUZ4WGdheFRuUW5yejFma25aOWxBd2pjczlUbkJ3Ti8zcEhLcm5nNlh5MkUz?=
 =?utf-8?B?UVNKWXlZeEdvYVJXRldDNkVCd2l2MHFLYjFHbGpscEhzWXMvTmV2enFoTEFK?=
 =?utf-8?B?VlZnVWpGaGlTSVRWa0RUSlQ3N3UxWGc0eDlSa1Nrd09ud3p0VmE2YTk5QmJi?=
 =?utf-8?B?ZXkrYXM4ei9ybU1KdDdRaHgyNWovZ1RKZDRGa0tRODg0UW4rVVlWMmNJSExV?=
 =?utf-8?B?M2ZNOW5ETXlOd1Jpa3lOQjRkdHp6Y0RVM3IzdWxzQXNRR25QM2NyKzFvOVJz?=
 =?utf-8?B?Vk1YZ2wzU0FDUnZDd1VOR015a3lWckQ2cTN6NzlFS2MvTldpSzJ5N2U0KzNk?=
 =?utf-8?B?V3pndUpoYWpQeWhBandYTStxMGNJMG9jZnBOT3QrR0M5bUgrYkRIYU5HOWJ5?=
 =?utf-8?B?OEt2akpmdE00Y3NFV2p6VHd0UDV1aklvakFsNHp1WmJEL1p4bFlsY0VuUHZZ?=
 =?utf-8?B?b0ZkNHFBcjdDbDhxNHVwNlYzclh2TzBidlR4Q3dtUldBSWswanRvdHl2RUFq?=
 =?utf-8?B?aGhsQVc0LzNKNFRKZGlVbzNEVVRORloySjV6TjdadEowR1BtUjVoNnh5dXZB?=
 =?utf-8?B?RXQ4NDA5eXQxQmtIU3cxbmI0bERqR2NMeU56QzY5WDlKd1k1TVordU4rT0Yz?=
 =?utf-8?B?R29WOHlwbjNaVFZRaHlCTnVMLzU3cmtuVXJhNXZGVGJ0UVBjQjRMOGYzOXFh?=
 =?utf-8?B?cmk4Y2J3YVMxclcwdjlQK3JGZXpCUUUrUW41TTVFYXkxTFNtbEVwMHBDK1Vq?=
 =?utf-8?B?OUxYZ0NydHB0OWdwdUFGZVI2TWIzMERFNzlPZEFROWZmVGg1SUxzZ1REMk0r?=
 =?utf-8?B?a29EclJ4eFBmSW5CZlNQSzROVXBtV3FuUTVQWnhmVmh2LzJrZTF3ZmY3TFB5?=
 =?utf-8?B?eXJOVHF6MSs2WVFQTk1JSmpmUEpYQzAxd21LbVdKUVRydFVDQzN5V0w2cVlq?=
 =?utf-8?B?bXJDcnV1RTVaZTZkS2xZODlMQ3JBN25wQkl1QVQ2UlZ5cUJZZTZLQUtSMVV1?=
 =?utf-8?B?S2k0WXNnWmh1N09mUHZBTGE3Ui93REJZUTducyt6dUFYaVNYS3lzdEVLMTg4?=
 =?utf-8?B?ZytLYko3R3h2TzBodU15RDNJSHlZd0c1TzlCbjZvYkRNTVhXR2lNQ1VlZ0Np?=
 =?utf-8?B?RGtDZlR4U1ZPV083d2RKNXNyM0xrZTNwWi83dXkwS0tIUjNWV1p6c3JBTitl?=
 =?utf-8?B?ZVFwRkFJZ05aQytEMkpSeHJhaFcwc0xxREZvYzNOV2tWbHRHeDJiV1pmV3dZ?=
 =?utf-8?B?ZUZ0QTdWOUhsbWhhOHBEMDVoWkRmcUFwb3hhZVRIblhkcFgwVW85M2VYcUZx?=
 =?utf-8?B?SEgzZlJIVHJGL1hFcHRueUFrWGU3Vm5wOXRDV2J1WFVuTTBGZUlPL3gvV3cz?=
 =?utf-8?B?UHlvNDhMZDBQcGY4OHozZnFWbCtRRVl0UERsLy8wL1RoMjZUcjZvVEhaZ3pV?=
 =?utf-8?B?WE9NS2FDR1N3U0liOVNYNWViRXUwM3BkSWNxSmJsMjB2V2s0dm1DS0xLS1hJ?=
 =?utf-8?B?ZUs5dkM3b2FKOVluWEU3QlVkYVZyNzYwZnp4ZUN4M1JrU013ejU4TzZCbnlK?=
 =?utf-8?Q?RBGWDg79xyY0wKFkYn9vbPq7K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f7b6e2-567d-43dc-40cf-08ddfc7d156a
X-MS-Exchange-CrossTenant-AuthSource: DS7SPRMB0010.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 21:47:11.8134 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxt3EXpKhi42yufvmN8dvlVQk+eun6EA9XoxJu5sMY4Q/YTdeRw7Ltej1JqM/IUAXsiF9B5aorcntAvsWAbOMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9668
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



On 9/25/2025 4:16 PM, Alex Deucher wrote:
> On Thu, Sep 25, 2025 at 3:50 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>>
>>
>> On 9/25/2025 2:46 PM, Alex Deucher wrote:
>>> On Thu, Sep 25, 2025 at 3:39 PM Mario Limonciello
>>> <mario.limonciello@amd.com> wrote:
>>>>
>>>> [Why]
>>>> Not all renoir hardware supports secure display.  If the TA is present
>>>> but the feature isn't supported it will fail to load or send commands.
>>>> This shows ERR messages to the user that make it seems like there is
>>>> a problem.
>>>>
>>>> [How]
>>>> Check the resp_status of the context to see if there was an error
>>>> before trying to send any secure display commands.
>>>>
>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1415
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>
>>> I think the tricky part is that we want it to throw an error on a
>>> system where it is supported so the user knows something is wrong.
>>
>> But a system that it's supported would have loaded the TA correctly, right?
> 
> Yes, it should.
> 
>>
>> This is specifically checking if the TA load failed which is being used
>> as a proxy to show you shouldn't bother with the other commands.
> 
> That makes sense, but I don't think it fixes the bug report.  The
> driver will still report the error on TA load.  I'm not sure how we
> can avoid that.

AFAICT there should be 4 messages showing up.
  * 2 warning
  * 2 error

It will at least help the two error messages.  For the warning ones I 
guess we could plumb an arugment into psp_ta_load() and 
psp_cmd_submit_buf() whether it's an optional TA.

> 
> Alex
> 
>>
>> We still show WARN messages from
>> psp_ta_load()
>> ->psp_cmd_submit_buf()
>>
>> I guess arguably this change really should be:
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> index 693357caa9a8..1c790dfccc9f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> @@ -2350,7 +2350,7 @@ static int psp_securedisplay_initialize(struct
>> psp_context *psp)
>>           }
>>
>>           ret = psp_ta_load(psp, &psp->securedisplay_context.context);
>> -       if (!ret) {
>> +       if (!ret && !psp->securedisplay_context.context.resp_status) {
>>                   psp->securedisplay_context.context.initialized = true;
>>                   mutex_init(&psp->securedisplay_context.mutex);
>>           } else
>>>
>>> Alex
>>>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>>>> index 693357caa9a8..70d4bfb13f46 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>>>> @@ -2356,6 +2356,9 @@ static int psp_securedisplay_initialize(struct psp_context *psp)
>>>>           } else
>>>>                   return ret;
>>>>
>>>> +       if (psp->securedisplay_context.context.resp_status)
>>>> +               return 0;
>>>> +
>>>>           mutex_lock(&psp->securedisplay_context.mutex);
>>>>
>>>>           psp_prep_securedisplay_cmd_buf(psp, &securedisplay_cmd,
>>>> --
>>>> 2.51.0
>>>>
>>

