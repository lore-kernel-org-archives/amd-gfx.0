Return-Path: <SRS0=qfa3=LF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF00C48BD1
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 18:06:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF7E161002
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 18:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7E161002
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AE306E7E5;
	Fri, 11 Jun 2021 18:06:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A34656E7E5
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 18:06:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XF3gUUFoRJcDDs0hcGkeYiTOeDDsNdJYyHKunTl6Wq/tYgNxwaO4zAD0czJa2dGl6KvDPd2Pk2Z8iFwQd3ztGYJ8M8NhSyBuVcoNQKc7hzRVkSDf3kkhY4yun4Na8yaiPeYrOWs6BI6yohCAVuH35iZ7lriQiRL9o2n4RY8WcGuIPeMaSJZTTl31Ba4jhtgcjxoiU31lcSOURKXJjoaqaoHG82xsMgBdUShIhQens24+9r5FSfr3j5+22z/QJsQTzXgOlE3qWgRz/F3Qmuxcln89yzmC9MafapAEnEmNyyuILMl0NBHYZDHvKXKBZJJhG4vELf8/7Co9u/u4kmY8Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlcC/uSSRCMvmXe/fKzoXNQvHqhtiFA3oi/XB8f2p1U=;
 b=laUSukyeIIlx1FgP3sm2se8ugIZlq4awojb02kgv1GhBhqGP5g0twd3PF/5Ad/tYfowCRnUwkuuQS/zNjOQmCguwKwVYdQA89o5zLfK6XCl1RwHhdkHEtx47hzbgltvyRU/oP0PMJPT2jt1SE4jsUUIei7KqQnk3+Pz/sEXIxzErYA3qivt8NtxJIlUKraJ6EgepcyrvUBHF75fvcfTn/wQ2Q3rvCe/c+xNS+Bvb5oC+89JZMMBNboZ4hmwyYPNqnXhYrrMtHWgYBkBV5zmO7YfVB8EncOR/vVoyemxUIdR0P+tfekmtPEI37lIh72GfbrV2z8FQn5Y/ZmhPl5lC2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlcC/uSSRCMvmXe/fKzoXNQvHqhtiFA3oi/XB8f2p1U=;
 b=pQ9ul453DAzcRUFwL85k1diVlXsJXFr+xmZFfoIovFKjZwZ2Ebacc9rBFbNdOxNtSgzQU77TX9RvlicJbyPKKNk5Yt+DTDa1sS3lftnTsZTWTzLScXjKACbun9iNQgbS952p5FfexkiZBag4jYlY3n0tpFk5bcembYOL3laQoFA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.29; Fri, 11 Jun
 2021 18:06:32 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.024; Fri, 11 Jun 2021
 18:06:31 +0000
Subject: Re: [PATCH 38/40] drm/amdgpu: RAS EEPROM table is now in debugfs
To: Alex Deucher <alexdeucher@gmail.com>
References: <20210608213954.5517-1-luben.tuikov@amd.com>
 <20210608213954.5517-39-luben.tuikov@amd.com>
 <CADnq5_NsmgQL6A6Q6mD4DHsKmA9dFhKLrnpHN6QQ7sLCDzQ+sQ@mail.gmail.com>
 <a04000e4-4d5f-560a-2193-0545ee3af8a5@amd.com>
 <CADnq5_Nt+4P0+6iVEd6JaNSu6rGjRpv7QCcoJedHmoiww8X4OQ@mail.gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <e6964ad9-a7ec-992b-6557-689c4c361d8e@amd.com>
Date: Fri, 11 Jun 2021 14:06:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <CADnq5_Nt+4P0+6iVEd6JaNSu6rGjRpv7QCcoJedHmoiww8X4OQ@mail.gmail.com>
Content-Language: en-CA
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YT1PR01CA0003.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::16)
 To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0003.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.20 via Frontend Transport; Fri, 11 Jun 2021 18:06:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6388d4ee-b18d-426d-d4db-08d92d03a45a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1770:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB177010420FC8F2225795158899349@DM5PR12MB1770.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ok5Ny0OTvTiMEf3oduo3QMgY1ZQsPpsrJOs3nsJiKDj9+RDjwy8jZigeoExBzxAF7Tgtl3mB8J2uDr7rfkP4jJYGnEwKN827BR6TgTK/sRhlOUpM4DodBl+Yp9pdg5Zb30N02s3ROXbdMD51gQw4UuF+xPFAyhdpSN5yqP5+ETpKN/QQLX3uZQGPLmLmNzyNY0HNiQ9bUflmzu9CRT91MVJQq5O6lYUdaUveRimaTn6EK1jQXNfB/wOSuNOZU9/bbhr+cpv79+95OkaTsfXEgp26gx1x0liOiJjMTCHpmtZUMzhIsPBHbV9/qRdAa0R69f46UXmKCYam6n1nyN3KHaXpGHT41XDQGF9gtCOa784W2PANjUl1K68iWM6OAq197MNDlXTAVhYsvWM1rg71EAp+Kn0XR4K3rSkN+oI4vvZF7PxfFmK1yb+7YUxt2Crvjo6VXk5/p0OSmSD27c4xkEemgcYwIDL6XFgEp7gr0vWQSfbEUkq4V/ZCqkP6SaGnSjF5LEZA1/LGXK3J4rghdyexqLEox+OFhRyjeMnOc0K0V98IM0IwGrVhYcAC5mJHMbqfPXdVT/8T+9/TFU3lREy2+u9oTAGahvSNkc726vCjJlakMivDKOlLq/JFh+/o7H0WYCWCyHQRUlXYoLrn5ecMB2JPMD8iOcOd4VOPP5ZCKBJrHvJQxx9+mtZhbRIWhpDyNCpKxLw1C06Ue+QLGD3eazhv+mN8ouFLXPAeMzg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(6916009)(2906002)(36756003)(2616005)(45080400002)(4326008)(186003)(6506007)(6486002)(53546011)(316002)(55236004)(31696002)(956004)(66946007)(44832011)(66476007)(66556008)(38100700002)(83380400001)(30864003)(8676002)(26005)(5660300002)(8936002)(31686004)(966005)(86362001)(478600001)(16526019)(54906003)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnpFZkVodUd5Q3JiRVc4c3BybHdaOWVMOGUyaGpxZ0pLaGRGZnBvMkdsK0Vx?=
 =?utf-8?B?ZVlwN1Z3WncrMWdTdWt0dFQrUTVQYkNka0E2eEtJTDdDRFdCMEJxQlN4TnJl?=
 =?utf-8?B?ek9pcWcxd2JnMDYvcStmT0hvZUNxV3FIMks1TUMzMnlCb3lzVTkvQTErUlM4?=
 =?utf-8?B?Zy8vZldkaUVwL2tJRXEybC9FOWlQcXBtTFFvTU9mZG9KaVNhMnFIdHZ5NGRn?=
 =?utf-8?B?aFErMVFzQjFkdEZES2JBWXdQR2lFU1JwM1Q4Q3lkWDZqZUNmY0NGSGJrRmZz?=
 =?utf-8?B?QmZhWWZxRS9JQ1FwdE1JUithNFFybERXcStFTFR4WUQ1dTY5ekVtTXlXK2di?=
 =?utf-8?B?Y1g4Z20vOWFCRFo3RjMxWU8ySHFsenpVNjdhTXByNCtua1FCNGR2c3ZneWVF?=
 =?utf-8?B?eGlMb2h0WFZ5OEdVNFlyakpEY3R1UlFEU0poWi81QTRaRnZiTERiTUFoWHNm?=
 =?utf-8?B?ckpKZGJNUTQxellIR2JISW1CNEhrUkR5MnI0dWU1Uit0dXFkZnhFSVBmY0dP?=
 =?utf-8?B?T1hBaGNtTG5OUGJaVUxTRys2QWd5Nm4xMFZGSE1DRVNhMFpkby9XSkVZNDg0?=
 =?utf-8?B?L3lQSHZtY1FOUTdXcElaaWJtOUVlSUNEVW5TaEtTOWxhN0NmWHBuaUM5RjFC?=
 =?utf-8?B?dXRYSFMxUkpQT1A0S0czSlBkTHhiVzd2SkZSRUtKaVlKTWlPeHgyMXRDMk1w?=
 =?utf-8?B?dzQ3QW81Q1JtMXN0dFZiQ2JFVVNtRlo2TWdEUTNjYjZEcDltVHJ6QlM3RlpY?=
 =?utf-8?B?UzFqYlNSQWFUV2R5a1ZvYUF3TmZtNzZsS2Jmc002U3o5ZHl6SU9wNmN0akJ3?=
 =?utf-8?B?R2hKNnpIUFZRMXlHQVpKcEVJejZPbmxBRkdGWVNaN01HNDRRc3NVVWd0bktm?=
 =?utf-8?B?NGJVN3Fab0lvSm9KaW1yYVJXa1FteDhVVTBDemZVNGh0QUpjRXAxbzYwWG5a?=
 =?utf-8?B?cGtKUVpyRTJIU1JvRWpHekdTRWRCOXV2bFhlSXlUbHBIVDZnT21iM0c5anhW?=
 =?utf-8?B?TEtEQThBb1RCZEhIRlI4Uk1JUWxXV3lyOWxCV01YbDZDMVF4Mm9ScFBPQlpI?=
 =?utf-8?B?SXdCUWU1QmlXQXBTVE5FSU1PTStwaXROZmFOdG10NXZGdVlGZ2ZFZlVpZlJz?=
 =?utf-8?B?ODVuc1RrNU5SMWZJUG9WTlhud0xabWpZQkowUGVOc01UaURscExraE1zM1Vs?=
 =?utf-8?B?ampBUkZFNjIxNmRFMjllc0p2M3VLRVVCR09RUjFHM0NsdFJ4UlZvZ29OVDVC?=
 =?utf-8?B?WmpXVmhUVTNqNWpUb3pYREhOTW1rL0p0ajEzWUpGR0xnNnhnbXRTODN2M01h?=
 =?utf-8?B?dlUwT3p2S0JTTlZXWHNoemVWVlNkc3FoVWxQQUJ1bThlQk1GRG5XMzltS0Fh?=
 =?utf-8?B?Y204cCtEMGZEZmJwVm1ua3dZQjBxODZuZE1vWTBqandpSDlucVpWZE5wTFZj?=
 =?utf-8?B?bTBsR2NNSjYrYS9LNnNkRzNpak0vaUJEYjVyaHlTd1lTK3p5WHN5TldUZnRm?=
 =?utf-8?B?cVZqaUQvWXVuazB2aHozRUtlQzZDcnZVU2NHSjFDSEsyY2ltNDJMTGdMbkox?=
 =?utf-8?B?RldlTVJvYnAvZnFqd0RtRHpSeUR4bGdCY3VrN0xZcmxYOU1qSGdka3pleURJ?=
 =?utf-8?B?Z1lSeW02OVB2eEVqSkFEVUgrdlg4OFZXb0p0c3pjcDB6QWlhOTNmTitBbG80?=
 =?utf-8?B?MWMvNjJQWEZDMGp1WVBRMEtVZklFcXR0OVI1c1oxQ1ZPUmZhWUhVRE5Ucmlu?=
 =?utf-8?Q?NPBZUBQlADRRQsyt4yaNHPgfz5y4MgpPs8IAqlQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6388d4ee-b18d-426d-d4db-08d92d03a45a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 18:06:31.6682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tANXw15f3U5XkW3WIlFFxvImBigJmERVHNIZQhhSf7xsDD/t+I7M5tZ5A+4woZU1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1770
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Xinhui Pan <xinhui.pan@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alexander Deucher <Alexander.Deucher@amd.com>,
 John Clements <john.clements@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-06-11 1:51 p.m., Alex Deucher wrote:
> On Fri, Jun 11, 2021 at 1:30 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>> On 2021-06-11 1:16 p.m., Alex Deucher wrote:
>>> On Tue, Jun 8, 2021 at 5:41 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>>>> Add "ras_eeprom_size" file in debugfs, which
>>>> reports the maximum size allocated to the RAS
>>>> table in EEROM, as the number of bytes and the
>>>> number of records it could store. For instance,
>>>>
>>>> $cat /sys/kernel/debug/dri/0/ras/ras_eeprom_size
>>>> 262144 bytes or 10921 records
>>>> $_
>>>>
>>>> Add "ras_eeprom_table" file in debugfs, which
>>>> dumps the RAS table stored EEPROM, in a formatted
>>>> way. For instance,
>>>>
>>>> $cat ras_eeprom_table
>>>>  Signature    Version  FirstOffs       Size   Checksum
>>>> 0x414D4452 0x00010000 0x00000014 0x000000EC 0x000000DA
>>>> Index  Offset ErrType Bank/CU          TimeStamp      Offs/Addr MemChl MCUMCID    RetiredPage
>>>>     0 0x00014      ue    0x00 0x00000000607608DC 0x000000000000   0x00    0x00 0x000000000000
>>>>     1 0x0002C      ue    0x00 0x00000000607608DC 0x000000001000   0x00    0x00 0x000000000001
>>>>     2 0x00044      ue    0x00 0x00000000607608DC 0x000000002000   0x00    0x00 0x000000000002
>>>>     3 0x0005C      ue    0x00 0x00000000607608DC 0x000000003000   0x00    0x00 0x000000000003
>>>>     4 0x00074      ue    0x00 0x00000000607608DC 0x000000004000   0x00    0x00 0x000000000004
>>>>     5 0x0008C      ue    0x00 0x00000000607608DC 0x000000005000   0x00    0x00 0x000000000005
>>>>     6 0x000A4      ue    0x00 0x00000000607608DC 0x000000006000   0x00    0x00 0x000000000006
>>>>     7 0x000BC      ue    0x00 0x00000000607608DC 0x000000007000   0x00    0x00 0x000000000007
>>>>     8 0x000D4      ue    0x00 0x00000000607608DD 0x000000008000   0x00    0x00 0x000000000008
>>>> $_
>>>>
>>>> Cc: Alexander Deucher <Alexander.Deucher@amd.com>
>>>> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
>>>> Cc: John Clements <john.clements@amd.com>
>>>> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
>>>> Cc: Xinhui Pan <xinhui.pan@amd.com>
>>>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>>> Seems like a useful feature.  Just a few comments below.
>>>
>>> Alex
>>>
>>>
>>>> ---
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  12 +-
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |   1 +
>>>>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 241 +++++++++++++++++-
>>>>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  10 +-
>>>>  4 files changed, 252 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>>> index 1424f2cc2076c1..d791a360a92366 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>>> @@ -404,9 +404,9 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f,
>>>>                 /* umc ce/ue error injection for a bad page is not allowed */
>>>>                 if ((data.head.block == AMDGPU_RAS_BLOCK__UMC) &&
>>>>                     amdgpu_ras_check_bad_page(adev, data.inject.address)) {
>>>> -                       dev_warn(adev->dev, "RAS WARN: 0x%llx has been marked "
>>>> -                                       "as bad before error injection!\n",
>>>> -                                       data.inject.address);
>>>> +                       dev_warn(adev->dev, "RAS WARN: inject: 0x%llx has "
>>>> +                                "already been marked as bad!\n",
>>>> +                                data.inject.address);
>>> This seems unrelated to this patch.
>> It's just cosmetic fix, to correctly align, as it seems that the previous alignment was arbitrary.
>> Just pressing TAB in Emacs does wonders. :-)
>>
>> I was in this file and decided to fix this. It's just cosmetic. No functional change.
>>
>>>>                         break;
>>>>                 }
>>>>
>>>> @@ -1301,6 +1301,12 @@ static struct dentry *amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *
>>>>                            &con->bad_page_cnt_threshold);
>>>>         debugfs_create_x32("ras_hw_enabled", 0444, dir, &adev->ras_hw_enabled);
>>>>         debugfs_create_x32("ras_enabled", 0444, dir, &adev->ras_enabled);
>>>> +       debugfs_create_file("ras_eeprom_size", S_IRUGO, dir, adev,
>>>> +                           &amdgpu_ras_debugfs_eeprom_size_ops);
>>>> +       con->de_ras_eeprom_table = debugfs_create_file("ras_eeprom_table",
>>>> +                                                      S_IRUGO, dir, adev,
>>>> +                                                      &amdgpu_ras_debugfs_eeprom_table_ops);
>>>> +       amdgpu_ras_debugfs_set_ret_size(&con->eeprom_control);
>>>>
>>>>         /*
>>>>          * After one uncorrectable error happens, usually GPU recovery will
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
>>>> index 256cea5d34f2b6..283afd791db107 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
>>>> @@ -318,6 +318,7 @@ struct amdgpu_ras {
>>>>         /* sysfs */
>>>>         struct device_attribute features_attr;
>>>>         struct bin_attribute badpages_attr;
>>>> +       struct dentry *de_ras_eeprom_table;
>>>>         /* block array */
>>>>         struct ras_manager *objs;
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>>>> index dc4a845a32404c..677e379f5fb5e9 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>>>> @@ -27,6 +27,8 @@
>>>>  #include <linux/bits.h>
>>>>  #include "atom.h"
>>>>  #include "amdgpu_eeprom.h"
>>>> +#include <linux/debugfs.h>
>>>> +#include <linux/uaccess.h>
>>>>
>>>>  #define EEPROM_I2C_MADDR_VEGA20         0x0
>>>>  #define EEPROM_I2C_MADDR_ARCTURUS       0x40000
>>>> @@ -70,6 +72,13 @@
>>>>  #define RAS_OFFSET_TO_INDEX(_C, _O) (((_O) - \
>>>>                                       (_C)->ras_record_offset) / RAS_TABLE_RECORD_SIZE)
>>>>
>>>> +/* Given a 0-based relative record index, 0, 1, 2, ..., etc., off
>>>> + * of "fri", return the absolute record index off of the end of
>>>> + * the table header.
>>>> + */
>>>> +#define RAS_RI_TO_AI(_C, _I) (((_I) + (_C)->ras_fri) % \
>>>> +                             (_C)->ras_max_record_count)
>>>> +
>>>>  #define RAS_NUM_RECS(_tbl_hdr)  (((_tbl_hdr)->tbl_size - \
>>>>                                   RAS_TABLE_HEADER_SIZE) / RAS_TABLE_RECORD_SIZE)
>>>>
>>>> @@ -77,13 +86,10 @@
>>>>
>>>>  static bool __is_ras_eeprom_supported(struct amdgpu_device *adev)
>>>>  {
>>>> -       if ((adev->asic_type == CHIP_VEGA20) ||
>>>> -           (adev->asic_type == CHIP_ARCTURUS) ||
>>>> -           (adev->asic_type == CHIP_SIENNA_CICHLID) ||
>>>> -           (adev->asic_type == CHIP_ALDEBARAN))
>>>> -               return true;
>>>> -
>>>> -       return false;
>>>> +       return  adev->asic_type == CHIP_VEGA20 ||
>>>> +               adev->asic_type == CHIP_ARCTURUS ||
>>>> +               adev->asic_type == CHIP_SIENNA_CICHLID ||
>>>> +               adev->asic_type == CHIP_ALDEBARAN;
>>> Unrelated whitespace change.
>> It's more readable and succinct like this, no?
>>
>> Do you want me to revert these? I mean, they're pleasing to have and change no functionality, and since I was in this file...
>>
> Don't worry about respinning to break these out in this patch, but in
> general it's better to keep formatting cleanups separate from
> functional changes; makes it easier to review the functional changes.
>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

Okay, great--thanks!

I'll repost the whole set with the squashed patch and the new abort-fixing one for long transfers as soon as the dust settles. (FWIW, it's now available on Gitlab. :-) )

Regards,
Luben

>
> Alex
>
>
>> Regards,
>> Luben
>>
>>>>  }
>>>>
>>>>  static bool __get_eeprom_i2c_addr_arct(struct amdgpu_device *adev,
>>>> @@ -258,6 +264,8 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
>>>>         control->ras_num_recs = 0;
>>>>         control->ras_fri = 0;
>>>>
>>>> +       amdgpu_ras_debugfs_set_ret_size(control);
>>>> +
>>>>         mutex_unlock(&control->ras_tbl_mutex);
>>>>
>>>>         return res;
>>>> @@ -591,6 +599,8 @@ int amdgpu_ras_eeprom_append(struct amdgpu_ras_eeprom_control *control,
>>>>         res = amdgpu_ras_eeprom_append_table(control, record, num);
>>>>         if (!res)
>>>>                 res = amdgpu_ras_eeprom_update_header(control);
>>>> +       if (!res)
>>>> +               amdgpu_ras_debugfs_set_ret_size(control);
>>>>
>>>>         mutex_unlock(&control->ras_tbl_mutex);
>>>>         return res;
>>>> @@ -734,6 +744,223 @@ inline uint32_t amdgpu_ras_eeprom_max_record_count(void)
>>>>         return RAS_MAX_RECORD_COUNT;
>>>>  }
>>>>
>>>> +static ssize_t
>>>> +amdgpu_ras_debugfs_eeprom_size_read(struct file *f, char __user *buf,
>>>> +                                   size_t size, loff_t *pos)
>>>> +{
>>>> +       struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
>>>> +       struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
>>>> +       struct amdgpu_ras_eeprom_control *control = ras ? &ras->eeprom_control : NULL;
>>>> +       u8 data[50];
>>>> +       int res;
>>>> +
>>>> +       if (!size)
>>>> +               return size;
>>>> +
>>>> +       if (!ras || !control) {
>>>> +               res = snprintf(data, sizeof(data), "Not supported\n");
>>>> +       } else {
>>>> +               res = snprintf(data, sizeof(data), "%d bytes or %d records\n",
>>>> +                              RAS_TBL_SIZE_BYTES, control->ras_max_record_count);
>>>> +       }
>>>> +
>>>> +       if (*pos >= res)
>>>> +               return 0;
>>>> +
>>>> +       res -= *pos;
>>>> +       res = min_t(size_t, res, size);
>>>> +
>>>> +       if (copy_to_user(buf, &data[*pos], res))
>>>> +               return -EINVAL;
>>>> +
>>>> +       *pos += res;
>>>> +
>>>> +       return res;
>>>> +}
>>>> +
>>>> +const struct file_operations amdgpu_ras_debugfs_eeprom_size_ops = {
>>>> +       .owner = THIS_MODULE,
>>>> +       .read = amdgpu_ras_debugfs_eeprom_size_read,
>>>> +       .write = NULL,
>>>> +       .llseek = default_llseek,
>>>> +};
>>>> +
>>>> +static const char *tbl_hdr_str = " Signature    Version  FirstOffs       Size   Checksum\n";
>>>> +static const char *tbl_hdr_fmt = "0x%08X 0x%08X 0x%08X 0x%08X 0x%08X\n";
>>>> +#define tbl_hdr_fmt_size (5 * (2+8) + 4 + 1)
>>>> +static const char *rec_hdr_str = "Index  Offset ErrType Bank/CU          TimeStamp      Offs/Addr MemChl MCUMCID    RetiredPage\n";
>>>> +static const char *rec_hdr_fmt = "%5d 0x%05X %7s    0x%02X 0x%016llX 0x%012llX   0x%02X    0x%02X 0x%012llX\n";
>>>> +#define rec_hdr_fmt_size (5 + 1 + 7 + 1 + 7 + 1 + 7 + 1 + 18 + 1 + 14 + 1 + 6 + 1 + 7 + 1 + 14 + 1)
>>>> +
>>>> +static const char *record_err_type_str[AMDGPU_RAS_EEPROM_ERR_COUNT] = {
>>>> +       "ignore",
>>>> +       "re",
>>>> +       "ue",
>>>> +};
>>>> +
>>>> +static loff_t amdgpu_ras_debugfs_table_size(struct amdgpu_ras_eeprom_control *control)
>>>> +{
>>>> +       return strlen(tbl_hdr_str) + tbl_hdr_fmt_size +
>>>> +               strlen(rec_hdr_str) + rec_hdr_fmt_size * control->ras_num_recs;
>>>> +}
>>>> +
>>>> +void amdgpu_ras_debugfs_set_ret_size(struct amdgpu_ras_eeprom_control *control)
>>>> +{
>>>> +       struct amdgpu_ras *ras = container_of(control, struct amdgpu_ras,
>>>> +                                             eeprom_control);
>>>> +       struct dentry *de = ras->de_ras_eeprom_table;
>>>> +
>>>> +       if (de)
>>>> +               d_inode(de)->i_size = amdgpu_ras_debugfs_table_size(control);
>>>> +}
>>>> +
>>>> +static ssize_t amdgpu_ras_debugfs_table_read(struct file *f, char __user *buf,
>>>> +                                            size_t size, loff_t *pos)
>>>> +{
>>>> +       struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
>>>> +       struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
>>>> +       struct amdgpu_ras_eeprom_control *control = &ras->eeprom_control;
>>>> +       const size_t orig_size = size;
>>>> +       int res = -EINVAL;
>>>> +       size_t data_len;
>>>> +
>>>> +       mutex_lock(&control->ras_tbl_mutex);
>>>> +
>>>> +       /* We want *pos - data_len > 0, which means there's
>>>> +        * bytes to be printed from data.
>>>> +        */
>>>> +       data_len = strlen(tbl_hdr_str);
>>>> +       if (*pos < data_len) {
>>>> +               data_len -= *pos;
>>>> +               data_len = min_t(size_t, data_len, size);
>>>> +               if (copy_to_user(buf, &tbl_hdr_str[*pos], data_len))
>>>> +                       goto Out;
>>>> +               buf += data_len;
>>>> +               size -= data_len;
>>>> +               *pos += data_len;
>>>> +       }
>>>> +
>>>> +       data_len = strlen(tbl_hdr_str) + tbl_hdr_fmt_size;
>>>> +       if (*pos < data_len && size > 0) {
>>>> +               u8 data[tbl_hdr_fmt_size + 1];
>>>> +               loff_t lpos;
>>>> +
>>>> +               snprintf(data, sizeof(data), tbl_hdr_fmt,
>>>> +                        control->tbl_hdr.header,
>>>> +                        control->tbl_hdr.version,
>>>> +                        control->tbl_hdr.first_rec_offset,
>>>> +                        control->tbl_hdr.tbl_size,
>>>> +                        control->tbl_hdr.checksum);
>>>> +
>>>> +               data_len -= *pos;
>>>> +               data_len = min_t(size_t, data_len, size);
>>>> +               lpos = *pos - strlen(tbl_hdr_str);
>>>> +               if (copy_to_user(buf, &data[lpos], data_len))
>>>> +                       goto Out;
>>>> +               buf += data_len;
>>>> +               size -= data_len;
>>>> +               *pos += data_len;
>>>> +       }
>>>> +
>>>> +       data_len = strlen(tbl_hdr_str) + tbl_hdr_fmt_size + strlen(rec_hdr_str);
>>>> +       if (*pos < data_len && size > 0) {
>>>> +               loff_t lpos;
>>>> +
>>>> +               data_len -= *pos;
>>>> +               data_len = min_t(size_t, data_len, size);
>>>> +               lpos = *pos - strlen(tbl_hdr_str) - tbl_hdr_fmt_size;
>>>> +               if (copy_to_user(buf, &rec_hdr_str[lpos], data_len))
>>>> +                       goto Out;
>>>> +               buf += data_len;
>>>> +               size -= data_len;
>>>> +               *pos += data_len;
>>>> +       }
>>>> +
>>>> +       data_len = amdgpu_ras_debugfs_table_size(control);
>>>> +       if (*pos < data_len && size > 0) {
>>>> +               u8 dare[RAS_TABLE_RECORD_SIZE];
>>>> +               u8 data[rec_hdr_fmt_size + 1];
>>>> +               /* Find the starting record index
>>>> +                */
>>>> +               int s = (*pos - strlen(tbl_hdr_str) - tbl_hdr_fmt_size -
>>>> +                        strlen(rec_hdr_str)) / rec_hdr_fmt_size;
>>>> +               int r = (*pos - strlen(tbl_hdr_str) - tbl_hdr_fmt_size -
>>>> +                        strlen(rec_hdr_str)) % rec_hdr_fmt_size;
>>>> +               struct eeprom_table_record record;
>>>> +
>>>> +               for ( ; size > 0 && s < control->ras_num_recs; s++) {
>>>> +                       u32 ai = RAS_RI_TO_AI(control, s);
>>>> +                       /* Read a single record
>>>> +                        */
>>>> +                       res = __amdgpu_ras_eeprom_read(control, dare, ai, 1);
>>>> +                       if (res)
>>>> +                               goto Out;
>>>> +                       __decode_table_record_from_buf(control, &record, dare);
>>>> +                       snprintf(data, sizeof(data), rec_hdr_fmt,
>>>> +                                s,
>>>> +                                RAS_INDEX_TO_OFFSET(control, ai),
>>>> +                                record_err_type_str[record.err_type],
>>>> +                                record.bank,
>>>> +                                record.ts,
>>>> +                                record.offset,
>>>> +                                record.mem_channel,
>>>> +                                record.mcumc_id,
>>>> +                                record.retired_page);
>>>> +
>>>> +                       data_len = min_t(size_t, rec_hdr_fmt_size - r, size);
>>>> +                       if (copy_to_user(buf, &data[r], data_len))
>>>> +                               return -EINVAL;
>>>> +                       buf += data_len;
>>>> +                       size -= data_len;
>>>> +                       *pos += data_len;
>>>> +                       r = 0;
>>>> +               }
>>>> +       }
>>>> +       res = 0;
>>>> +Out:
>>>> +       mutex_unlock(&control->ras_tbl_mutex);
>>>> +       return res < 0 ? res : orig_size - size;
>>>> +}
>>>> +
>>>> +static ssize_t
>>>> +amdgpu_ras_debugfs_eeprom_table_read(struct file *f, char __user *buf,
>>>> +                                    size_t size, loff_t *pos)
>>>> +{
>>>> +       struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
>>>> +       struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
>>>> +       struct amdgpu_ras_eeprom_control *control = ras ? &ras->eeprom_control : NULL;
>>>> +       u8 data[81];
>>>> +       int res;
>>>> +
>>>> +       if (!size)
>>>> +               return size;
>>>> +
>>>> +       if (!ras || !control) {
>>>> +               res = snprintf(data, sizeof(data), "Not supported\n");
>>>> +               if (*pos >= res)
>>>> +                       return 0;
>>>> +
>>>> +               res -= *pos;
>>>> +               res = min_t(size_t, res, size);
>>>> +
>>>> +               if (copy_to_user(buf, &data[*pos], res))
>>>> +                       return -EINVAL;
>>>> +
>>>> +               *pos += res;
>>>> +
>>>> +               return res;
>>>> +       } else {
>>>> +               return amdgpu_ras_debugfs_table_read(f, buf, size, pos);
>>>> +       }
>>>> +}
>>>> +
>>>> +const struct file_operations amdgpu_ras_debugfs_eeprom_table_ops = {
>>>> +       .owner = THIS_MODULE,
>>>> +       .read = amdgpu_ras_debugfs_eeprom_table_read,
>>>> +       .write = NULL,
>>>> +       .llseek = default_llseek,
>>>> +};
>>>> +
>>>>  /**
>>>>   * __verify_ras_table_checksum -- verify the RAS EEPROM table checksum
>>>>   * @control: pointer to control structure
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
>>>> index edb0195ea2eb8c..430e08ab3313a2 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
>>>> @@ -29,9 +29,10 @@
>>>>  struct amdgpu_device;
>>>>
>>>>  enum amdgpu_ras_eeprom_err_type {
>>>> -       AMDGPU_RAS_EEPROM_ERR_PLACE_HOLDER,
>>>> +       AMDGPU_RAS_EEPROM_ERR_NA,
>>>>         AMDGPU_RAS_EEPROM_ERR_RECOVERABLE,
>>>> -       AMDGPU_RAS_EEPROM_ERR_NON_RECOVERABLE
>>>> +       AMDGPU_RAS_EEPROM_ERR_NON_RECOVERABLE,
>>>> +       AMDGPU_RAS_EEPROM_ERR_COUNT,
>>>>  };
>>>>
>>>>  struct amdgpu_ras_eeprom_table_header {
>>>> @@ -121,4 +122,9 @@ int amdgpu_ras_eeprom_append(struct amdgpu_ras_eeprom_control *control,
>>>>
>>>>  inline uint32_t amdgpu_ras_eeprom_max_record_count(void);
>>>>
>>>> +void amdgpu_ras_debugfs_set_ret_size(struct amdgpu_ras_eeprom_control *control);
>>>> +
>>>> +extern const struct file_operations amdgpu_ras_debugfs_eeprom_size_ops;
>>>> +extern const struct file_operations amdgpu_ras_debugfs_eeprom_table_ops;
>>>> +
>>>>  #endif // _AMDGPU_RAS_EEPROM_H
>>>> --
>>>> 2.32.0
>>>>
>>>> _______________________________________________
>>>> amd-gfx mailing list
>>>> amd-gfx@lists.freedesktop.org
>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cluben.tuikov%40amd.com%7C522f2150d3a94b6f713308d92d018213%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637590306808868534%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=1FpDKAaXISnv0NjyVvit4%2FIHxSU7bev%2FpLEYuImOin4%3D&amp;reserved=0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
