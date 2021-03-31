Return-Path: <SRS0=lEWV=I5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A97C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 07:49:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAF8461959
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 07:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF8461959
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6108C6E9FB;
	Wed, 31 Mar 2021 07:49:00 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EAFA6E9FB
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Mar 2021 07:48:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CiFf2PFUs+o0UgRWHEmnGJbnC2+ZUX116JAqjLoM9refY0W0VH8Uxl8SlFXD5puX2MUrViH0URnzbGUivBeoGUf8sMzwDfVHbaLR/4mdSTPz53Ql84NoyrGXZIZNx9dEsQSPL/2H3SzGpbC4wb31az1Ji5pAvRv7KkElUOy/8BC3x8znRFmwLEnFNod6Ov3nRP4r97PJzR14scax3b7G3u4qyLA2MScRJTPXe9CFmkfz6Nclv5yb7dm2mHszBUVa9e9jY8P2EtoOJF/LIJUcPacXH6Nt6eQQncbiTA4dA4YHmTjux1eg60pAa3fwxFRjbBHpxoF6bkWtCKNxQZTFZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5G1foh/a3pjFkWBaXkMFjdrPTPKydL+t0MT7GEIBWys=;
 b=DlxFz/eXuxk7jp/SAHntRtJCHZCMRepCAc4QqA7ZPs+q97RGpTb/3vNItjsYPuPIzcTPx0zbCYp/IEIW+l0qeU6X88m55Ko3s+lpeadMmIYQg/F0K5ntS3ri+3sXZRQnZ/xN19s3BNqmoff5vFoq8GOFyGxT+4kBzRVHHB294LwbSNz7gZvO4701rywA3MUNc2FKWZ8UiafOvMhwVBC/8c3u/OkcAuYGvIA35wmDew9tFFfdTRvsCnuXsSHDuT7hnIu8YcYiMX8zYgQpjomn5typUCyQgMhfvWhEVE95dL3EX5XdK3YnAvJcR6GLBWNI/XRlvkSGbnVJXUmCMgFoIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5G1foh/a3pjFkWBaXkMFjdrPTPKydL+t0MT7GEIBWys=;
 b=b1sxl5XybwTEO0VIwB8vjOX2dGAvhVg7FhmZZUOCSEEUUXMfAv46+So9HvxTz4RSK6CGbgH1knqeYikrRCnORPfuPZInYObU37tPIl3RC0JXY8s3zFbZ1ZSkvP2rfnEBepzttb4VTPGPpk2SWrywl6b3QHEWYmAATFUWzT+0Jq8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4304.namprd12.prod.outlook.com (2603:10b6:208:1d0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Wed, 31 Mar
 2021 07:48:56 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 07:48:56 +0000
Subject: Re: Interlaced resolutions hang the desktop
To: Alberto Salvia Novella <es20490446e@gmail.com>
References: <CAHJvkbsexf7kM-11ZdrM+pHUUyvttB8fyJMfcsQAC1233jp8LA@mail.gmail.com>
 <388b2a9d-0e63-b70f-28ed-6297a524fb76@amd.com>
 <CAHJvkbuu5WB=QTu0EUgSGcoK6KMbP2j8NA0o+XTdtkwadNpsxg@mail.gmail.com>
 <909002f5-691c-1cbb-1e44-a99217be8791@gmail.com>
 <CAHJvkbsMY689cK3uq_O+i6jiqgLmSAUcrD43oHxpSsVwyhJ1Mg@mail.gmail.com>
 <b1137716-d6dd-6572-3d45-d0063caef26e@amd.com>
 <CAHJvkbvkwAw2-pRo=rvnB98XxgtNCE-QAzv4HZ-KceH-vZkKoA@mail.gmail.com>
 <3d3563f3-f093-f293-e237-b87306a4cede@amd.com>
 <CAHJvkbvQ-JJ4vhc3MHNiQ2Jb7dpHUTQBcZ4L1KDnSV=WXDPsOA@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <7914f67b-e011-36ec-3f6d-1614ce96e3c4@amd.com>
Date: Wed, 31 Mar 2021 09:48:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <CAHJvkbvQ-JJ4vhc3MHNiQ2Jb7dpHUTQBcZ4L1KDnSV=WXDPsOA@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:46d6:1b43:479c:c70b]
X-ClientProxiedBy: AM0PR10CA0103.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::20) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:46d6:1b43:479c:c70b]
 (2a02:908:1252:fb60:46d6:1b43:479c:c70b) by
 AM0PR10CA0103.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.27 via Frontend Transport; Wed, 31 Mar 2021 07:48:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f3298878-fcad-4b87-d455-08d8f4197005
X-MS-TrafficTypeDiagnostic: MN2PR12MB4304:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB430479667A497C30EBB620E4837C9@MN2PR12MB4304.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1H1ZK5xrkIjSAcIt89mXqzSNhImNY4TUxuKkUuPpJY+iCW691yslTOV4ZE2QKQtdx/B8OVkmeEmLBs2+nRs7U3wqNIjfYdmxoHlAGMziX/HWyG6T2kpJbSfhgM2DWaeQFCuTIgdlr3ch6qWCRmozl2SS0cdm9BO2Mc8MtzorAcsf9AifeylDGmS0nbib9nBHm0irS+TAaqhgCNK3Nt+3mQ5CX2rJMCIOwjbIw59xXo9sR9muf2SIlz+LiAHDVHzma3zeOiJsK9MPir7ifI22wAu4lJrB3T9y/BpKhjwHZcGnTnhbjTrQWvDg7WvJn658qALZbl7KqpLIKqsDO55hWV/v7F9CSOd2kBOi2S1afNQ1sijHkMYRipidwaUrxFReTIGCcWwUcOvr6NrluOL0YYu9GKVesk/Bkwsws3L2pOGcxGu5TOUT86Sur27d7GYB1Q8uR6XXm/+Ah3bPcvjpFIXjKl+ccne1iu1lMeKLhcwSKVUtmSe6xuvrgj/8LaZNU/vpYzv00eKuT9OAL317udK4QXw2Qze/ZvkFSbl6H3UvpRpWF7aVoxspBd6Uy+Cs8BxPAzDHJ5VZy05HEOlDkX99Dq0StUged00481GW3y57MYTg41isRKnWm/36Uf9NtBRS3LMLWjdfE0gDx1rTETDJpj4fvk+rQXPf6lN0jy4K4acGSDa8rRH5+FbKyo2Jw3rHc1Un/DhwXNwyyfNWDJQD67L4ft/6qVpZVLr6xogjj/x6lCrgGacyBxUhepJQCsn+CPwu+rL4D5hBCKwMy0xI+OQPkUxFS5AJOcT4asY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(6916009)(8676002)(316002)(8936002)(966005)(33964004)(45080400002)(66574015)(30864003)(2906002)(16526019)(5660300002)(2616005)(83380400001)(31686004)(478600001)(52116002)(166002)(186003)(4326008)(31696002)(6486002)(38100700001)(86362001)(36756003)(66946007)(6666004)(66556008)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TnRsTUxrRzdUSVVKK21aRitxYlY5WSt0UkdCV2lMZkVCL2JNS25WSUx6bEVE?=
 =?utf-8?B?a3ZGcktXcG9UMC8xdXlMT0ZNb0xick9yTSs1QnJ6Z2JtV0dpaVA0SUtrcWMx?=
 =?utf-8?B?V0VQS0haR2pDZjVSM2JmSGJHS2IvVGg3UmVEQk8ySHdFRC9TWHNxUUxVZEw0?=
 =?utf-8?B?Wk51Zk1HWGZ1clB0aURBUUcvS0JpbDlhKzJsSUJlbGFxcSttN1ZCRlByM3h1?=
 =?utf-8?B?TXlyOGtPdTBoVVNTYVZid1NvMnIvUTlPZGcvVzZEd1ZDYWtnVVRSQ24yQk4v?=
 =?utf-8?B?dFhjRUh2UUg1U3lsV0JlbldtbUJ5YmtBL3hTTEp2aXQ4MVUvUnVaMUwxbkts?=
 =?utf-8?B?bDlBS2I0cThYM3hlYUlDQ2xYMFdXOGxYK3NvVzk4bEVwZGpKSXl4L1BqOHlw?=
 =?utf-8?B?UlNOTC9qOWJQelhPN2pPcW9PUUJWdGk4bFNYNWg0b1NseG1pWkxuR2xTaDhi?=
 =?utf-8?B?NFExUVk5SzlGejRSUVRUS0lDODdqbnFmcU1JdGtSK0V3alNQQjRwRnl6WEZ2?=
 =?utf-8?B?ZFlHOGJuZUQzTjlZVkxic2VuVDFVb3RzRjVHSTUrMkluVDVMZ3F6OUx3RGhV?=
 =?utf-8?B?dGFUZVdadFREVmJua3VkNkVNMXpXczlZNld3K01ISVN3UFNPVUlrczRwSU43?=
 =?utf-8?B?VkpnZWFxYk9tdG54SldSR01DeFVBTVlOQXhZNmEwUm9NaFlJU2NuVVI0SVA3?=
 =?utf-8?B?SjEzVEV5eWo1blB3NmQwV3ZudDlwWFE4RnVpVGd0Z0ZFOWRjOGxaS2pVSHhD?=
 =?utf-8?B?REtCa3RwWS9ITUdRWVhvNWM5LzFtNnVQSHROWWExS0creS9mRER0LzNVVjNh?=
 =?utf-8?B?c0RlZDhteGtuYVpPekx4ajc0Rmp0NVZsSjJYU2laMkM5TkZaaWNsVXc2bDJ6?=
 =?utf-8?B?Y0cyd0NXdTNFNmllK3A0VEJVTTgrYmFNWnd4UVZ3MTIzckRSMWJHRmc0K0g4?=
 =?utf-8?B?czk5RmEydU9BOEtoWUUyQUV2bXZkbjdOL0xUUWdldU82QW9RUnc1Uktmb2JU?=
 =?utf-8?B?OWZIZFMyOEJXeGdPWENPL09FT1JvOEs3a291UWNPNjZOYjV1TTlQZndzUXdM?=
 =?utf-8?B?S0lNbXd2OWNVaDF1alZTTXorSzZ3aVNGQnAzTUZJMmxnaCtPT3BmM0o3MHJR?=
 =?utf-8?B?VHhkZmp4VWkya0ZMVW0rV0xHbERFT3RMdEJSd2tuS1VGNDBFQitvWU5RcTVV?=
 =?utf-8?B?WnorTzhtWVV0RCs5NWg4eXJVTlVDTTBLTkpKekh0THBnZytrUUx3WU5yTkhF?=
 =?utf-8?B?eDd5LzlTQ2U4OGZKd1Faek5lUC9wKzlwVWgyL2ZWdHB1U0FUSEJaSFR5dk84?=
 =?utf-8?B?akRkZVQzSDBHQTZnNU1TbXVQWE1KbGRBcGxWQ1JpK25jTzhIMU9hNTZRUTFF?=
 =?utf-8?B?UGowNWkyNVB0RGhVZ1BLdVFrVURNV2I1cnlnSFB1Uzg2NnFOVVBTWlZSRGYx?=
 =?utf-8?B?dnorZjVZaiszV3BVYjZRaUZ0M0RvN215SElkUnpIYndXTjJLcmpJT3hZUjJ4?=
 =?utf-8?B?Sy8xNzg1UGJaQllMQUxsbGI2SmtEQ3Boc2YzZHZ1d3FGNU45d2pxZVFZWUJP?=
 =?utf-8?B?VjNib01QRXE0ZEEwbHlqR1lueU1QM3FPeXZBNmt6OEVVdU8zby9TMU1uNVE2?=
 =?utf-8?B?clJOUVRzSmFPbWhkOVBNUkEyYXgvTHV4WlpYMWFyZzd6ak5UM2I5RTFvcFNI?=
 =?utf-8?B?VWZtYlJoVndxMFZmNnBQcmRYWG1DOUlwWWM1RWdoeTVLS1llc1h5VDVyaFV2?=
 =?utf-8?B?R3dmUE5KME9RNU1iUWEyR200RFJSVEI0KzBPbkFIWmVpNk1qS0ZuOWNIdnZL?=
 =?utf-8?B?V3RmdmpQRSt2eEZWZnp4WGZWZ3p0bTFGS3JleTVDMVgrWGZNTlR4dE5kOWR2?=
 =?utf-8?Q?li2KVT3LspQo9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3298878-fcad-4b87-d455-08d8f4197005
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 07:48:56.5943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jDMI/ccwcHP2sT5/dc+TcsYwXR4NTlC7ToFIX0qw1k44ri8SFadUHGUcATBS2SEc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4304
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
Cc: alexander.deucher@amd.com,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 linux-fbdev@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 benh@kernel.crashing.org
Content-Type: multipart/mixed; boundary="===============0442309693=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0442309693==
Content-Type: multipart/alternative;
 boundary="------------4DB143753EFBDE35C3FD6472"
Content-Language: en-US

--------------4DB143753EFBDE35C3FD6472
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Correct, but a TV is intended for videos only. That's why it implements 
only the lower HDMI standard.

Interlaced transmits only halve the lines with each frame, so a 60Hz 
mode effectively either becomes a 30Hz mode, halving the vertical 
resolution or adaptive motion compensated which the know visual 
artifacts. Depending on what the deinterlacing setting on your TV is.

You could just add a progressive 1920x540@60 or 1920x1080@30 mode 
manually and would have the same effect with probably better quality. 
See https://de.wikipedia.org/wiki/Deinterlacing for reference.

If you can give us some more information what is happening when the 
system freeze we could try to narrow this down, but we can't spend much 
time on a very specific use case in a driver which is in maintenance mode.

Regards,
Christian.

Am 31.03.21 um 09:21 schrieb Alberto Salvia Novella:
> 24fps is intended for video only. Anything interactive at 24fps, as 
> just moving the mouse around, is extremely choppy.
>
> No way anyone would prefer that over an interlaced resolution or a 
> lower resolution. That is, by far, the worst option.
>
> Just try it on your screen, set it to 24Hz or alike, and tell me your 
> experience. You can't even tell where the mouse is going to go.
>
> On Wed, 31 Mar 2021 at 08:44, Christian König 
> <christian.koenig@amd.com <mailto:christian.koenig@amd.com>> wrote:
>
>     Hi Alberto,
>
>     well a frame rate of 24Hz is perfectly reasonable for a TV and
>     desktop usage.
>
>     This is probably caused by the TVs limited HDMI bandwidth and a
>     refresh rate of 30/25 Hz for the interlaced mode isn't much better
>     either.
>
>     Regards,
>     Christian.
>
>     Am 30.03.21 um 22:59 schrieb Alberto Salvia Novella:
>>     The frame-rate at 24Hz is extremely poor for normal desktop usage.
>>
>>     If the highest resolution, aka 1080p, uses that refresh rate then
>>     the desktop will default to that frame-rate.
>>
>>     Other progressive modes don't exhibit any issue.
>>
>>     On Tue, 30 Mar 2021 at 18:26, Christian König
>>     <christian.koenig@amd.com <mailto:christian.koenig@amd.com>> wrote:
>>
>>         Hi Alberto,
>>
>>>         I think the driver should only support resolutions that are
>>>         *progressive*, but also at least of *50Hz*.
>>
>>         Why do you think so?, the 24Hz resolution seems to be the
>>         native one of the display.
>>
>>         Regards,
>>         Christian.
>>
>>         Am 30.03.21 um 17:37 schrieb Alberto Salvia Novella:
>>>         This is why I'm using interlaced:
>>>
>>>         $ *xrandr*
>>>         Screen 0: minimum 320 x 200, current 1920 x 1080, maximum
>>>         8192 x 8192
>>>         DisplayPort-0 disconnected (normal left inverted right x
>>>         axis y axis)
>>>         HDMI-0 connected primary 1920x1080+0+0 (normal left inverted
>>>         right x axis y axis) 16mm x 9mm
>>>            1920x*1080i*    60.00*+  50.00  59.94
>>>            1920x1080 *24.00*    23.98
>>>            1280x*720*      60.00    50.00  59.94
>>>            1024x768      75.03    70.07    60.00
>>>            832x624       74.55
>>>            800x600       72.19    75.00    60.32  56.25
>>>            720x576       50.00
>>>            720x576i      50.00
>>>            720x480       60.00    59.94
>>>            720x480i      60.00    59.94
>>>            640x480       75.00    72.81    66.67  60.00    59.94
>>>            720x400       70.08
>>>         DVI-0 disconnected (normal left inverted right x axis y axis)
>>>
>>>         I think the driver should only support resolutions that are
>>>         *progressive*, but also at least of *50Hz*.
>>>
>>>         On Tue, 30 Mar 2021 at 15:41, Christian König
>>>         <ckoenig.leichtzumerken@gmail.com
>>>         <mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
>>>
>>>             Mhm, no idea why an interlaced resolution would cause a
>>>             crash. Maybe some miscalculation in the display code.
>>>
>>>             But apart from that if you just connected your PC to a
>>>             TV I also wouldn't recommend using an interlaced
>>>             resolution in the first place.
>>>
>>>             See those resolutions only exists for backward
>>>             compatibility with analog hardware.
>>>
>>>             I think we would just disable those modes instead of
>>>             searching for the bug.
>>>
>>>             Regards,
>>>             Christian.
>>>
>>>             Am 30.03.21 um 11:07 schrieb Alberto Salvia Novella:
>>>>             I guessed so.
>>>>
>>>>             The GPU is a Radeon HD5870, and the screen is an old
>>>>             Telefunken TV (TLFK22LEDPVR1).
>>>>
>>>>             Since my real display got into repair I used this TV
>>>>             meanwhile, and to my surprise it froze the system.
>>>>
>>>>             On Tue, 30 Mar 2021 at 10:15, Christian König
>>>>             <christian.koenig@amd.com
>>>>             <mailto:christian.koenig@amd.com>> wrote:
>>>>
>>>>                 Hi Alberto,
>>>>
>>>>                 well what hardware do you have?
>>>>
>>>>                 Interlaced resolutions are not used any more on
>>>>                 modern hardware, so they
>>>>                 are not well tested.
>>>>
>>>>                 Regards,
>>>>                 Christian.
>>>>
>>>>                 Am 30.03.21 um 10:04 schrieb Alberto Salvia Novella:
>>>>                 > The entire desktop hangs after some minutes when
>>>>                 using the module
>>>>                 > "radeon" with an interlaced resolution.
>>>>                 >
>>>>                 > Easier to trigger by playing a video on Firefox,
>>>>                 at least on kwin_x11.
>>>>                 > Wayland didn't exhibit the problem.
>>>>                 >
>>>>                 > Other display drivers, from different computers I
>>>>                 have tried, didn't
>>>>                 > allow those interlaced resolutions all together.
>>>>                 It seems they know
>>>>                 > there will be problems.
>>>>
>>>>
>>>>             _______________________________________________
>>>>             amd-gfx mailing list
>>>>             amd-gfx@lists.freedesktop.org  <mailto:amd-gfx@lists.freedesktop.org>
>>>>             https://lists.freedesktop.org/mailman/listinfo/amd-gfx  <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=04%7C01%7Cchristian.koenig%40amd.com%7C9750c0b0074e4c7f68fd08d8f415aaae%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637527721219552783%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=NAMuDs3cBxh0jEeqMF8z%2BvuR%2BogJdps7vNJvHGHZ%2FR0%3D&reserved=0>
>>>
>>
>


--------------4DB143753EFBDE35C3FD6472
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Correct, but a TV is intended for videos only. That's why it
    implements only the lower HDMI standard.<br>
    <br>
    Interlaced transmits only halve the lines with each frame, so a 60Hz
    mode effectively either becomes a 30Hz mode, halving the vertical
    resolution or adaptive motion compensated which the know visual
    artifacts. Depending on what the deinterlacing setting on your TV
    is.<br>
    <br>
    You could just add a progressive 1920x540@60 or 1920x1080@30 mode
    manually and would have the same effect with probably better
    quality. See <a class="moz-txt-link-freetext" href="https://de.wikipedia.org/wiki/Deinterlacing">https://de.wikipedia.org/wiki/Deinterlacing</a> for
    reference.<br>
    <br>
    If you can give us some more information what is happening when the
    system freeze we could try to narrow this down, but we can't spend
    much time on a very specific use case in a driver which is in
    maintenance mode.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 31.03.21 um 09:21 schrieb Alberto
      Salvia Novella:<br>
    </div>
    <blockquote type="cite" cite="mid:CAHJvkbvQ-JJ4vhc3MHNiQ2Jb7dpHUTQBcZ4L1KDnSV=WXDPsOA@mail.gmail.com">
      
      <div dir="ltr">
        <div>24fps is intended for video only. Anything interactive at
          24fps, as just moving the mouse around, is extremely choppy.</div>
        <div><br>
        </div>
        <div>No way anyone would prefer that over an interlaced
          resolution or a lower resolution. That is, by far, the worst
          option.</div>
        <div><br>
        </div>
        <div>Just try it on your screen, set it to 24Hz or alike, and
          tell me your experience. You can't even tell where the mouse
          is going to go.<br>
        </div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Wed, 31 Mar 2021 at 08:44,
          Christian König &lt;<a href="mailto:christian.koenig@amd.com" moz-do-not-send="true">christian.koenig@amd.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div> Hi Alberto,<br>
            <br>
            well a frame rate of 24Hz is perfectly reasonable for a TV
            and desktop usage.<br>
            <br>
            This is probably caused by the TVs limited HDMI bandwidth
            and a refresh rate of 30/25 Hz for the interlaced mode isn't
            much better either.<br>
            <br>
            Regards,<br>
            Christian.<br>
            <br>
            <div>Am 30.03.21 um 22:59 schrieb Alberto Salvia Novella:<br>
            </div>
            <blockquote type="cite">
              <div dir="ltr">
                <div>The frame-rate at 24Hz is extremely poor for normal
                  desktop usage.<br>
                </div>
                <div><br>
                </div>
                <div>If the highest resolution, aka 1080p, uses that
                  refresh rate then the desktop will default to that
                  frame-rate.</div>
                <div><br>
                </div>
                <div>Other progressive modes don't exhibit any issue.<br>
                </div>
              </div>
              <br>
              <div class="gmail_quote">
                <div dir="ltr" class="gmail_attr">On Tue, 30 Mar 2021 at
                  18:26, Christian König &lt;<a href="mailto:christian.koenig@amd.com" target="_blank" moz-do-not-send="true">christian.koenig@amd.com</a>&gt;
                  wrote:<br>
                </div>
                <blockquote class="gmail_quote" style="margin:0px 0px
                  0px 0.8ex;border-left:1px solid
                  rgb(204,204,204);padding-left:1ex">
                  <div> Hi Alberto,<br>
                    <br>
                    <blockquote type="cite">I think the driver should
                      only support resolutions that are <b>progressive</b>,
                      but also at least of <b>50Hz</b>.</blockquote>
                    <br>
                    Why do you think so?, the 24Hz resolution seems to
                    be the native one of the display.<br>
                    <br>
                    Regards,<br>
                    Christian.<br>
                    <br>
                    <div>Am 30.03.21 um 17:37 schrieb Alberto Salvia
                      Novella:<br>
                    </div>
                    <blockquote type="cite">
                      <div dir="ltr">
                        <div>This is why I'm using interlaced:<br>
                        </div>
                        <div><br>
                        </div>
                        <div>$ <b>xrandr</b><br>
                          Screen 0: minimum 320 x 200, current 1920 x
                          1080, maximum 8192 x 8192<br>
                          DisplayPort-0 disconnected (normal left
                          inverted right x axis y axis)<br>
                          HDMI-0 connected primary 1920x1080+0+0 (normal
                          left inverted right x axis y axis) 16mm x 9mm<br>
                          &nbsp; &nbsp;1920x<b>1080i</b> &nbsp; &nbsp;60.00*+ &nbsp;50.00 &nbsp;
                          &nbsp;59.94 &nbsp;<br>
                          &nbsp; &nbsp;1920x1080 &nbsp; &nbsp; <b>24.00</b> &nbsp; &nbsp;23.98 &nbsp;<br>
                          &nbsp; &nbsp;1280x<b>720</b> &nbsp; &nbsp; &nbsp;60.00 &nbsp; &nbsp;50.00 &nbsp;
                          &nbsp;59.94 &nbsp;<br>
                          &nbsp; &nbsp;1024x768 &nbsp; &nbsp; &nbsp;75.03 &nbsp; &nbsp;70.07 &nbsp; &nbsp;60.00 &nbsp;<br>
                          &nbsp; &nbsp;832x624 &nbsp; &nbsp; &nbsp; 74.55 &nbsp;<br>
                          &nbsp; &nbsp;800x600 &nbsp; &nbsp; &nbsp; 72.19 &nbsp; &nbsp;75.00 &nbsp; &nbsp;60.32 &nbsp;
                          &nbsp;56.25 &nbsp;<br>
                          &nbsp; &nbsp;720x576 &nbsp; &nbsp; &nbsp; 50.00 &nbsp;<br>
                          &nbsp; &nbsp;720x576i &nbsp; &nbsp; &nbsp;50.00 &nbsp;<br>
                          &nbsp; &nbsp;720x480 &nbsp; &nbsp; &nbsp; 60.00 &nbsp; &nbsp;59.94 &nbsp;<br>
                          &nbsp; &nbsp;720x480i &nbsp; &nbsp; &nbsp;60.00 &nbsp; &nbsp;59.94 &nbsp;<br>
                          &nbsp; &nbsp;640x480 &nbsp; &nbsp; &nbsp; 75.00 &nbsp; &nbsp;72.81 &nbsp; &nbsp;66.67 &nbsp;
                          &nbsp;60.00 &nbsp; &nbsp;59.94 &nbsp;<br>
                          &nbsp; &nbsp;720x400 &nbsp; &nbsp; &nbsp; 70.08 &nbsp;<br>
                          DVI-0 disconnected (normal left inverted right
                          x axis y axis)</div>
                        <div><br>
                        </div>
                        <div>I think the driver should only support
                          resolutions that are <b>progressive</b>, but
                          also at least of <b>50Hz</b>.<br>
                        </div>
                      </div>
                      <br>
                      <div class="gmail_quote">
                        <div dir="ltr" class="gmail_attr">On Tue, 30 Mar
                          2021 at 15:41, Christian König &lt;<a href="mailto:ckoenig.leichtzumerken@gmail.com" target="_blank" moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;
                          wrote:<br>
                        </div>
                        <blockquote class="gmail_quote" style="margin:0px 0px 0px
                          0.8ex;border-left:1px solid
                          rgb(204,204,204);padding-left:1ex">
                          <div> Mhm, no idea why an interlaced
                            resolution would cause a crash. Maybe some
                            miscalculation in the display code.<br>
                            <br>
                            But apart from that if you just connected
                            your PC to a TV I also wouldn't recommend
                            using an interlaced resolution in the first
                            place.<br>
                            <br>
                            See those resolutions only exists for
                            backward compatibility with analog hardware.<br>
                            <br>
                            I think we would just disable those modes
                            instead of searching for the bug.<br>
                            <br>
                            Regards,<br>
                            Christian.<br>
                            <br>
                            <div>Am 30.03.21 um 11:07 schrieb Alberto
                              Salvia Novella:<br>
                            </div>
                            <blockquote type="cite">
                              <div dir="ltr">
                                <div>I guessed so.</div>
                                <div><br>
                                </div>
                                <div>The GPU is a Radeon HD5870, and the
                                  screen is an old Telefunken TV
                                  (TLFK22LEDPVR1).</div>
                                <div><br>
                                </div>
                                <div>Since my real display got into
                                  repair I used this TV meanwhile, and
                                  to my surprise it froze the system.<br>
                                </div>
                              </div>
                              <br>
                              <div class="gmail_quote">
                                <div dir="ltr" class="gmail_attr">On
                                  Tue, 30 Mar 2021 at 10:15, Christian
                                  König &lt;<a href="mailto:christian.koenig@amd.com" target="_blank" moz-do-not-send="true">christian.koenig@amd.com</a>&gt;
                                  wrote:<br>
                                </div>
                                <blockquote class="gmail_quote" style="margin:0px 0px 0px
                                  0.8ex;border-left:1px solid
                                  rgb(204,204,204);padding-left:1ex">Hi
                                  Alberto,<br>
                                  <br>
                                  well what hardware do you have?<br>
                                  <br>
                                  Interlaced resolutions are not used
                                  any more on modern hardware, so they <br>
                                  are not well tested.<br>
                                  <br>
                                  Regards,<br>
                                  Christian.<br>
                                  <br>
                                  Am 30.03.21 um 10:04 schrieb Alberto
                                  Salvia Novella:<br>
                                  &gt; The entire desktop hangs after
                                  some minutes when using the module <br>
                                  &gt; &quot;radeon&quot; with an interlaced
                                  resolution.<br>
                                  &gt;<br>
                                  &gt; Easier to trigger by playing a
                                  video on Firefox, at least on
                                  kwin_x11. <br>
                                  &gt; Wayland didn't exhibit the
                                  problem.<br>
                                  &gt;<br>
                                  &gt; Other display drivers, from
                                  different computers I have tried,
                                  didn't <br>
                                  &gt; allow those interlaced
                                  resolutions all together. It seems
                                  they know <br>
                                  &gt; there will be problems.<br>
                                  <br>
                                </blockquote>
                              </div>
                              <br>
                              <fieldset></fieldset>
                              <pre>_______________________________________________
amd-gfx mailing list
<a href="mailto:amd-gfx@lists.freedesktop.org" target="_blank" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
<a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C9750c0b0074e4c7f68fd08d8f415aaae%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637527721219552783%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=NAMuDs3cBxh0jEeqMF8z%2BvuR%2BogJdps7vNJvHGHZ%2FR0%3D&amp;reserved=0" originalsrc="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" shash="rgp9wpjWpiTUkcjUiNzMkWV5LpJVnLV1rag8zDUkFKVJtVEDGyXDDML2FhEv2Sp9xiUryqs/JmEbOZiWoa7otg5H6ASbOe69OS2HhAh8BErcrA3vAoWtiD3qLOUzallTK6X9sopSJ4Z/J2Agtn0vEvjViqDGCkUyAI63wOHelF8=" target="_blank" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
                            </blockquote>
                            <br>
                          </div>
                        </blockquote>
                      </div>
                    </blockquote>
                    <br>
                  </div>
                </blockquote>
              </div>
            </blockquote>
            <br>
          </div>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------4DB143753EFBDE35C3FD6472--

--===============0442309693==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0442309693==--
