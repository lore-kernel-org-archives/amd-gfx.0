Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B626C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 11:39:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E74F510E241;
	Tue, 22 Feb 2022 11:39:10 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0759F10E241
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 11:39:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8UMvuo5ySwxiJaXfDKZY71Umd0DdaymhZP1GPj64gwvOJRFdFDoTjM4VgLLbGkint7xs8QTrM99/TCkr7Sf9SBH9oVzFKp80MTXlnZQHc3bcc8bgqH4RxgVNHrfSodDZqC7BXN2+WNwXEUGPluROC9x5Yagp1CdxTHpcINw5wg6vnPsNQTOPN+7H75NwRAKZIgwt4Wr3jLHlEd8BOaoyW2QGj0zNg/wvcMIA0cUWBU2chxUO0qUUOwffzPAYW9NL3tZxGESk+NEPw5FEbBPGWHpiys+iTb3hyWhuxN8i5mY/sDc+C8dRdGglpAAgmNEU3ljPYS2fokSFmzZqis6Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrAAeprj0kQJuy+QPe1kSrypQ5btvJW1cW4FCBpirAg=;
 b=Q16J/08J4yCEMJOlFgPQ0KJeMOgHmlB//AMy6PyaxrhBab7JFGoVy5bs+zw1pUq6vXEnVLImrA2n4rdSM+fTOixTWvFLWoG3XsiyWAfLYYcgJsL9GULnkgGzGath40hdLLnTIYZBz9/1p/LIssxH/41D/5LXr3x//IMee9rN+oq5TJSTg+q6za/pMHyr9gm6DLiRiNANmPchXfoW0FFTKVljqH0UmtFd9RhDtmStbOY8//qwuuykPDmRcKPvNPCj2mCt6AXOiswh5zivklaD3fDAVzvEYQQioZKnePT1j53KiFcPtLBIJ0aSvXwB4ZrNapb6VXbg908rk4OKaKNGPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrAAeprj0kQJuy+QPe1kSrypQ5btvJW1cW4FCBpirAg=;
 b=bx89iqxyZ+Ys10oTEiSiUARYvbB6VM6CWvoOfNHlzhMdIqkAiBF9+Ub80kcbLCSHFp2JI83JHmXE6CycLp4HUSFTlSEvCIeZfdl2tS5+WiaLe1Eni9MMUBA05F+k6MCuddmo6cHmByfMn9X84hgOPwPAyy2l9I3MoBhbtxqfpSM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM6PR12MB3033.namprd12.prod.outlook.com (2603:10b6:5:11e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Tue, 22 Feb
 2022 11:39:08 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581%6]) with mapi id 15.20.5017.022; Tue, 22 Feb 2022
 11:39:08 +0000
Message-ID: <b7dd81f1-9a0c-4773-62f5-84012571e9fc@amd.com>
Date: Tue, 22 Feb 2022 12:39:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 7/7] drm/amdgpu: drop testing module parameter
Content-Language: en-US
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20220218222603.25470-1-alexander.deucher@amd.com>
 <20220218222603.25470-7-alexander.deucher@amd.com>
 <4009de28-8add-97b9-0dd3-8d44704af322@mailbox.org>
 <CADnq5_P2ffjt7L27vUo+iwRUJNu2+Wmo9ORNwv42XYdgHwhPkA@mail.gmail.com>
 <aab017e3-6229-690c-32ac-e9acbf640132@mailbox.org>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <aab017e3-6229-690c-32ac-e9acbf640132@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR10CA0014.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:89::27) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9987284-9d7b-4969-96db-08d9f5f7ef95
X-MS-TrafficTypeDiagnostic: DM6PR12MB3033:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB30331890F62AD1688EEF6EF0833B9@DM6PR12MB3033.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6M7rLn4CCW+V0dnD7iY37EsAJ/49wsvHHs+0ZQzuwLdBZQS5KU1Ue8gGa0NBuqDl7Ww+cZSwKdkA881Frl0EP5b7DI4qy+Q5i2V3ss6pvzZ2/xgtx9VcUR5oKWX5QX9MavHGZfiSYuIZYSoLCbw5LcYP1df0WdiaLFn88v5AtxBmssiLd9QavjLPZRYn7NVL+SP1PB0w9OMlkK4G/59jWVvxNFvE3aMZxGzGNMvvuulsdRd73KJ1CKQczV5i2cOLyAbaxVXoLqy7hDKMMWw9bt21490D1ZZiReLzm7cEBt9SBPy6KOUej7m3uBVBH3KIx6lmcLfVaCaAqaF0LHNARFDsKh0eq7ZDZU4Z7PY1XS6eKz+IJD9FksvoD9B1am/hSZYtdxHzjNLUIUGZLvPJzoXRO6qyFZ+qrhTVgz2gYGMdA7VVS43RbFDwyosAHchaxoQC18Lw0Hoyu1t32Ijiwglyq/DdiEtMZCA7EIr8M2oPXZF4UWyvrB6FOjZhEiWo4iYo0wA2g4fLq7wzj3TaEMRuLI0oVXQvpqFQWh1JTIeCn+9NWRv+YHw9TVOlvrMjd92UoLQC/PN6eh9HkrIY9jJpkRUDAm0vR8xthlFGArfr0+4r1vrjev7yCiDosfpdpUnWMwwalx0KdIRMYagaaTA15b0BJyzGGdcTUePRQsSuRTi9ATzZiGwv180eVnhktg+38iMVYsvNsWKM6Ujxh+mXsteuJe+F30194hoYFZmNJvZ936dmxUcuFUbDonML
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(66946007)(6512007)(66556008)(6506007)(2616005)(53546011)(6486002)(31696002)(6666004)(86362001)(54906003)(66476007)(508600001)(316002)(110136005)(8676002)(83380400001)(4326008)(38100700002)(5660300002)(31686004)(2906002)(8936002)(36756003)(4744005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE5HcmoySCtTZEt0WHpKWjgxLzAvc2R4NGNwQ05UK2pzV25ubEtlMTFFTTMw?=
 =?utf-8?B?OHpQdC9LOWsxdW5HNjVEcUV6TVB5dmZaTHlsbmVxRWduRGVKc2VMYTM3VUxn?=
 =?utf-8?B?bDJjcjZMNWludCt0Mlc4OU0wdlpDaVRMR2JEeTcvTk9SbW41VDFsaUVmbktm?=
 =?utf-8?B?VmZ1WFgwVUpyUnVpSjI3UXZVWVFYQ0NQRDFoSC9DWFNRVE1KVEI1bFY1QVZ6?=
 =?utf-8?B?KzN2RlpvNXdhdzhMM0x1Um5hNHVWcVZndC85eUFPYi9jY3pJMHlLeWx4eEtK?=
 =?utf-8?B?cExqQ1FkaUNZVHFwcDczcVR4a0poNk5Sc2lWQnMyM0lzTGdBMEZONys2VGZn?=
 =?utf-8?B?N0ZYeDd2Q3V3dHdobW10ZjNobkJVd0NnSms5Si8xdSsvalVFVTBhT2lxNmoy?=
 =?utf-8?B?TXgxNnd6SHdEQWxLZmJoVi9LMEV0bUpvTDNlZFRhRm5EcDVKL3VWdGM1MVFl?=
 =?utf-8?B?eUlneUlxYmM4Skx0cGZqTktwOWlNeVNFNmh3d3J3Wm56Zmd5aEFjdGwzTy9U?=
 =?utf-8?B?V2Zodkp6QTJxbm42VitOWDRyRENubHMrWktlZlhVZmlveGtqK1cyOUg5VHR6?=
 =?utf-8?B?OWxlMWxyQmZYU0QwRFR6TE5BZ2l1T09rVDVYelB2YnM4MENxWHRsUDFVbmZo?=
 =?utf-8?B?ZFVyUDBMNnBQU29Qdzl0LzBCV1JKdGFyZ0dDZDJwdW9ucC9WcFZuK0hkMnJw?=
 =?utf-8?B?ZWNMT3VUNmlRRmtYaHRTaGJFc0NKN0x0MU5YZDAzSldwVityQUxYdEw3VU0x?=
 =?utf-8?B?TXJROGlyd0daZks2MDU2TVdlRnhPOERPTGRTOG5pOGhDQ1ZOTFF1VjNtR2tj?=
 =?utf-8?B?NWpWODBUd3dWL0FiaXlObGJPYW40UWI3V1VnbVZYWWdaUDV5M2hQWnMrRTFN?=
 =?utf-8?B?WkROS2tVbEVTS1R6bWdtaHNxM2RvdTFkS0g4NXZtdm84bEVKWlg2d0lQMXFB?=
 =?utf-8?B?eXRlME1kd2F1N2VlVk1sWGZrYnFqaFNyZ2hvMzBRQjBUekVQVHJOTlpGMWZs?=
 =?utf-8?B?YmFhOXVBcU5mU3VrY1BoNkxHbUhEdkllNDlMMHRzNjZEelZSUkwrQnIxNnZn?=
 =?utf-8?B?aHpRVTc2aG5jOXZKRFJyQzF0ZG1NWDVodlYvUm5PeEd4b2MvUTUzR1hCWGI1?=
 =?utf-8?B?dDJlSFZMYWprRnQzV1NNY2xaSm1Eem81OHhTb09SRTF4NHJ2VHhaa2duazhU?=
 =?utf-8?B?em9sWmo4MDhBMkpYYmh5THVKazBjSnNURkx1blNqRlgvWTdmTkpManpVM05T?=
 =?utf-8?B?WEdvWk9aQ2Jwd3FOWEljWFFVdW1KNmUrRmptNHJUOHgrTHRlVk9pOE0wbGVW?=
 =?utf-8?B?NEFrcXNObnZaU2VMY0VjQ1lIcVBwZnhGL2pMQ1FiTnBEeS94M2NXaDQ3azdo?=
 =?utf-8?B?RWtqci9hbEFUdmU1STFOekRYS2R6VXFGbFVsVXNtVzdHeEtiaXZlbkE2Nzgy?=
 =?utf-8?B?Q3VoRm93Y2FNWG10SE1rei9BOW5SSy9sWkwzZERlQWY5a1kwcUh0V0l5bWFq?=
 =?utf-8?B?cytjUTl4TDNPaXFrRWp2dGxITDZLNVV2NHNnTGtNY2V6cEpRenVwbC93MXZ5?=
 =?utf-8?B?UmVOTTB4UGxJUmU5R1dqVzlDcS9EWFdXMXI1NG96RWczSys3NitQUVhpZW40?=
 =?utf-8?B?MU5FNXd5TTlSQldWQnZWZmlhMEtSOWllbFRaSFdDaGl2THJVWmUxbjZHVkhu?=
 =?utf-8?B?V3FMdTRnb3M4emhpb0FnekhwZUFhQWhBaWNnVllYVEVYMkRtSVd1eEdCakQy?=
 =?utf-8?B?VHI5cE0zZlg5RWVqeGlMVDlaQ1ltb2dNUFdIZ3NjVXhLSnRyNVdXNUkyRjVF?=
 =?utf-8?B?R0hmcHdZQzFiRlk0dTJuUUlEUTZiQW94RHc2dk5KeXpubjJYQ21EakhSRFRE?=
 =?utf-8?B?NHBVMjNHamFlSEtqTkRRaXM5K2dtd0dZRjJhcGlpazFNbUdNUlNYNnFKNWI0?=
 =?utf-8?B?WmgrY2s3Qy9Hd3V3QnFibEdrMy9iaVNVWHZXUzh0MFFkUFozTDJWd1pDK0pL?=
 =?utf-8?B?QjJUWjhNQnZaNWJROU04Q2hMV1F5ZXdoUGhWOCt0TFBST0FPRVJqU201Z3FD?=
 =?utf-8?B?cUh6WkJBRUNOT1pWdEZTMlE5Qi9HVnBlWUViUGk0RWpMVC9KbHJ6UDFPWXdq?=
 =?utf-8?B?cXp5Z0NRdHNjU05aYkwxS0NPMXRML2h3Y3hQU085eFZCYlU5TXdkQ3R5T3Zx?=
 =?utf-8?Q?hQRro9B3Q3A7oCh/b6SnrQQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9987284-9d7b-4969-96db-08d9f5f7ef95
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 11:39:07.8670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 82C9RxyeE7kTXZyCHdfayE8zcuYwrUca0XFl5wHZqyExk21esEWrQTrUR0ecrTK1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3033
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 22.02.22 um 10:07 schrieb Michel Dänzer:
> On 2022-02-21 22:35, Alex Deucher wrote:
>> On Mon, Feb 21, 2022 at 12:44 PM Michel Dänzer
>> <michel.daenzer@mailbox.org> wrote:
>>> On 2022-02-18 23:26, Alex Deucher wrote:
>>>> This was always duplicate functionality with the benchmark tests.
>>> Not really. The purpose of amdgpu_do_test_moves is testing that copies between GTT & VRAM work across the whole GTT aperture (when I originally wrote radeon_do_test_moves, they didn't on the PowerBook I was using at the time).
>>>
>> Fair enough.  I'll drop it for now.  Might be useful to convert to
>> debugfs at some point as well.
> To be clear, I'm not saying this needs to stay — maybe it's not useful anymore. I'm just pointing out that it's not redundant with the benchmarks.

Yeah, the test doesn't necessary work that well any more since we now 
have the GART table much smaller than the GTT size.

I think it's still the best to just remove that.

Regards,
Christian.
