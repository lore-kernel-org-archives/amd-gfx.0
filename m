Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72517C28D13
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 07:11:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E266E10E1B2;
	Thu, 25 Aug 2022 07:11:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86DBC10E1B2
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 07:11:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/bwY+01Nps6r84HZf7e8PN4W/lKpKFFaWKu6GN8DctJupY/p2pwqy87GeNSUD2/6kisgliLr8mEkD2keqweHpfJJPngOVeY4Y8d5CKN/7b3V0Y/pYQ8dCCaMO1FVzAetuz/N8OU5PYajT7qsSCoMwjRXptj+sBJcBVyHvcAT/pwyaAqZVbWJdBBSwor+mOHE22nLc/V2Crr1Cpm1ID91Kss4k+X6KWj9ukxDre1rarp/PnS8sssoNfggcsGROvkvVFBDLLp1pWphtzSzTSYeo7lD1MsgNclk7vx92/7fUH0CYQdXJ+eiPJJgN3/I6Q9KW220WoRViYsjyRlIy0gHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8ViVzPEE7P0DGIG4JCafVETVphM/xXH0knvQvfMmiw=;
 b=kn4Su0Sifvm5/lqp8oRiu1HIna7UXCzJ4F7ijWpuSBqPwgWlxdLJZ0xbxUuFb4RpaNH8SkRDaRi21L4AsHmW7o0pvY6Y4vKxQtpzhPGbJfkZJENzrYlimFaaoVo3uQScUoti/AYNfap+lamNjFv9qZYzLczXvatny3KoJWc1Pfc5BnytR4cxWYERqb8BuaTwOLELeI0tFbEOHhEX/wixydOEJryUEf0IAhEXbVkiqQw3wd8o77eXHnelxXj8XHnjG975x0z7bXiFoWg78Ec5JUg2sblKPq42mzK914lL1uzqRTFDBS8PoKfI3cOXZBaYOILGdTro6V4fahRsfT3z3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8ViVzPEE7P0DGIG4JCafVETVphM/xXH0knvQvfMmiw=;
 b=p7XcPac2GsmQNEB4KIJlBmmfEuJ1DagdnP6BOnPRwm9UZT6Nl70IIbQakJiwZFD49N8JEtDQ2EgPBLdnPZk1MwImKcsBIOB0JVrtsd6IbAk8ZsLY2LwWvH+0E9WMZuUbo8c0IoTThKTrMrF1VDDanAJ7WYWSAkvP/M6irUWiptU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB6302.namprd12.prod.outlook.com (2603:10b6:8:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 20:38:16 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%6]) with mapi id 15.20.5546.022; Wed, 24 Aug 2022
 20:38:16 +0000
Message-ID: <796c3005-5c7f-05af-3803-1bf8bb3a5a81@amd.com>
Date: Wed, 24 Aug 2022 16:38:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/2] Use kfd_lock/unlock_pdd helpers
Content-Language: en-US
To: Daniel Phillips <daniel.phillips@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220824200132.116030-1-daniel.phillips@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20220824200132.116030-1-daniel.phillips@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::15) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00f2433f-064e-4709-addd-08da8610926a
X-MS-TrafficTypeDiagnostic: DM4PR12MB6302:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZsyopHHmbblvjz/UjznJAvf9akCMICldE5QYOLrj8MmgmhsSTImZzAaBwDOwl48dk+tiLSlBlOjZpqEH5XhM6hGEOMSEuRDk8UzAvGemEUaK6FgscgnWkVcSYIMDtEsWZo17Tkm1qb+cG837n7cWz0KPeEi19Se/eC72nxCdGoXlQmz3Ou9tdfjXqOw0o2uyQEcio6OpKTeVdLiH2UYZMq4HxpZpDcX5nfh6ex7YeoJnZJPhE2u9bMJsPY7NzOWuXdYFFzGp9/Th/Lu7im4yb9GxnyUDVSEVdxp18JjJgnVSIU6Nfu7S71exx4LzOrxziNp69i176+HVy37xk/0Tv+2f8T2l+nk32j87xLnkz1aQJWnwdrd9OhgVdkgp+k6Jo74UjH1gJHx963voRV8DUoj/jxeCvBlfWgETjban4CW27lEdgTPoF28CtIaF69zoDLV+tiCBdzUSAdViIzTmb4K+SWofuX7E1Je4K7rV0XZpC4l7gkQidd/DKQySeIlCle29mRPmUUz5SwC5XoSkrv0uEvUDgiedFpEvN5CyaEJv2yRxWHQppSAoJ0oHUe9jj5JZgecybZeF9ij8GSaNRdHB2tgs7r5haeZM0NfLl9tbB7Ho2fPbIlQQWNLvSPimrEWnmcMH5se3f0KOgalDtDg6sXbHk6q4xEB0ZLSLJE1cGhpOs2fHld+kpFhJwmLUMuOB/xLYxMRVzWARZyDglyqme7VRkBSe6mrB//vZnd3ncnFMJdEPfpxGlrb/tsKPcwuOBJzKVofvYA9lPg2g5gR0vGcmRFwnfazkw+ysWu8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(36916002)(44832011)(83380400001)(4744005)(478600001)(41300700001)(53546011)(6512007)(26005)(6506007)(2906002)(6486002)(186003)(2616005)(8936002)(86362001)(31696002)(5660300002)(38100700002)(66556008)(316002)(36756003)(8676002)(66476007)(31686004)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjUrREVIa0FkcVNDcUtlUzl1MnFmQStoa25RYVQvR2ozR2VhVHdSYmVCYUlx?=
 =?utf-8?B?WTE0QmFmSEpQbkRoeVFhKzBNbUNLSlhmc3ZWN2pmQ0dPc05aUzluU1M3RmM1?=
 =?utf-8?B?VDl0MzJINmRGMUFGY0NOTnpxZnZnWjdveWVvZGpJeStGNGRBSWU3VzdvWWZK?=
 =?utf-8?B?QmZWbE45b3YxeUJZU1libkNoQXJSRHliSjZCREI3QU13cWh1bFhndHVtbXo0?=
 =?utf-8?B?alJQTmZDTmJFL3ZwVnpmUzRXc1A3N1o5dGpYL3MxTjAyQ1Flb08weDFITXNk?=
 =?utf-8?B?bXJGQTJSMzBFUDBScmo4RjN1WXNRR2ZieHVtb21JSWVaelFVaWI4WkY0bmdP?=
 =?utf-8?B?OUtueXZKWG5uK2tKNTR2REtpUFY4ZmJNQXJuU0ovNFcxNm1MRUNWcVRJdUwr?=
 =?utf-8?B?clIwS0pIY1l2aUhrM0g3TUNjMFRvdUhvTElwTDlhanNIS2liNitRTGN2aGdL?=
 =?utf-8?B?VUQrRFkwNzN1OVdoOGd3aWxEVGIxWHd3R1RIbDJsMHJBSXhhdElTb3dCdnk2?=
 =?utf-8?B?SlVUZ09KaXd1Yktsam9Tc0VhTlRWZ3dZNGRQOHNnN0k5RU15cFBNbTVkd2xT?=
 =?utf-8?B?ck9oeWJNK1ZudHBJMWw1VmxtdzRMUWcrNnIvc3daYURBcFhrS1lBZmFacmI0?=
 =?utf-8?B?dWNRa1J6UHhEbFUvTk9LTWhZTUdrRnBwSEFiaHhTTnpXa1YxbGNGcUxBZkIv?=
 =?utf-8?B?VFZEWXBicEVKSFNGUWN4UW9icE0ySlNtaGltZDZDMnVWS0sxV3NVdU5jTmpr?=
 =?utf-8?B?M3JndzBSVzc2OVdtTzdhdW1Ob0hoRDJJZjQwMlNxSXpzb1F6WCt0WVdubm5u?=
 =?utf-8?B?ZlBxYkxoc2I5WTZycmRyZzFmc2FnUFBLdHpnempDaFJXWm5MVzYyNXZGcGh4?=
 =?utf-8?B?Vlp3TkVhMktVY1MzbnhPV05tV01wL3dneG0vY2NaSjlTR2JOMmgrM1E0UFNr?=
 =?utf-8?B?VjhkMDBrejN3V25ORm9YM28wbmNjemtKU1k4YXVmWFdlY2xTOHFxOHBOOHla?=
 =?utf-8?B?a1AvS0ZoM2ZWWmZJK0dkKzA0allyQnlRVmJpZFl3VXo5cDAvWHQ1M1ZNMGVJ?=
 =?utf-8?B?bmFCdmJRRjZjY3RyMDRKUkxWOU1kYXlqTkxhdGMyM0hoZERSVS91enJuaWNI?=
 =?utf-8?B?Ukx6cnZBV0NPRkMxWEQrc3MzZzkvMkRhQ010dWJoY3ZPZ0tEMEx1SEF0VGxs?=
 =?utf-8?B?Q2kxaWM5K0NBdURsdy9rRzRFOE9wUEswZUExTEIxOHV3MGEzRURTclVmU2pU?=
 =?utf-8?B?V2EvOWFiUFRlSElyckpQMDZSaHJEM1JQMVRLL2VCNzBaZDRYVVNJQ0JveHRv?=
 =?utf-8?B?YXdhSmdja1hqOXdCbGk2QW9Xcm4zYytPcWhzc3dKZkpwK0VRZkNqcnJ0bUtq?=
 =?utf-8?B?N3hzakhubjdrdU1hVEtLdkR0a2hwS2gvMzRoVlBvSzhCM3N4MUp0ZzZDOEEx?=
 =?utf-8?B?c1poemxyMzY3Z0VyWGJxWUJ0WElQc2RsQ01CU2M4Rzlnd2VuVXhheVl2UWlm?=
 =?utf-8?B?aHl1L1JmSERhNVVPM09UblNwMjNBckFiUUdDa3RKam5xWERqQ3hrRXBTQmpO?=
 =?utf-8?B?aWFWM3J0YkVBYWRaYXJJVGszQTRXTkxsK3c4ZUErdmhRejFMQU1iVzR3TGRm?=
 =?utf-8?B?QjRiTzJocC9OL2hyWGNhUXRRQlpaamRQdjFTeXpuNVF2Um9OeHpvdzZBSnpv?=
 =?utf-8?B?OWE2YkVVd1YvTlJGUk1DZU1EK3BSQUFXSlZNMG9UR29HbGk4UE1sbmdGVHov?=
 =?utf-8?B?Tzhyb2dqREYvb2lZVW9EK2MzUXBxQkxjS3R5TXdHSmFGd0MyVUlzZ21zbE5E?=
 =?utf-8?B?YmZHbTJ0OFJYL2dOMCs3N3MzbEdpaVN6ZU9zSjUrenRHaGpDWXltV21XVW93?=
 =?utf-8?B?VUhCMmJjSC84QzhCTFRTMGNQclF6QzFpY2o3bGhtenRSUm1kVUNZekVlamFY?=
 =?utf-8?B?R3VVV29wcFZmeS9uZTZzOXZWYW5MMFB1bGpwMjlZc2dvR29ONVg4Tk01Sng1?=
 =?utf-8?B?MDRtTmcvK2h4NkdmMEcwSm56eitpak9RdjU3OXZmbkFySHlJcmlsT2dGZlRa?=
 =?utf-8?B?b3ZubUw4VjNONUlXQTh1S2JCazNLZWdaYzc3QWY0L1JSblJNeEhjVk42enFv?=
 =?utf-8?Q?ChyTJJZZjArOk8tYWI0I0MEuh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f2433f-064e-4709-addd-08da8610926a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 20:38:16.2220 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NbxaYUUD9BkiddaCCfwELYCpxzcJwlsHBW0ThJUiQFsVBFyrEOh/dYSaQs1mXVyIT9lbHQaXoqwF2KvRCKg9Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6302
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

Do you mind squashing the two patches. It would make them easier to 
review because it makes it easier to see that the same functions are 
using both.

Thanks,
   Felix


On 2022-08-24 16:01, Daniel Phillips wrote:
> Patch 1 adds kfd_lock_pdd_by_id and patch 2 adds kfd_unlock_pdd helpers,
> broken out this way to reduce noise in the first patch, which is a bit
> tricky because of modifying a lot of error paths. Patch 2 is trivial.
>
> Daniel Phillips (2):
>    drm/amdgpu: Use kfd_lock_pdd_by_id helper in more places
>    drm/amdgpu: Use kfd_unlock_pdd helper
>
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 130 +++++++++--------------
>   1 file changed, 48 insertions(+), 82 deletions(-)
>
