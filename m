Return-Path: <SRS0=Den1=MP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994C5C432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 22:46:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63C1460E9C
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 22:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 63C1460E9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5D2E6FAC7;
	Fri, 23 Jul 2021 22:46:36 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9279C6FAC7;
 Fri, 23 Jul 2021 22:46:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDm4v06/gStv+ImM7hP+4LEV3gDIj9qFffPgxkqDzI+UwbKVWAVP9CDd2hU8GDz/c158i3yznYVLhEwtcmcgrSUE8wtEPV7CzVco0OySr0dNzz8uu0JcLh+5wGz93L0NZgFsr0NuhqJUV4ybixJbpDAi2W7qzY9hdxBfoj6lqbCurxbnBrW1rEisVkl8uAo85sDnBjkZUw4QHdA2fd/AfP00aNGF3Bn7aKG0G/TgzNd69Vs09f2al+ubKLhHGxBV20VaVbAnBb5y+SQsVQM8Nc7e+/05M+R9nQpjffeXqOmbmo+RsaC6qgfaYYarbLTHx+Nf5RL5GgugbJnJugKtkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWVERFJ9PqFKSyT4srd82031Du9GNyEn0Y8flW0V8PM=;
 b=PDsfzIjOfCaJNotL5k4xC9MuVK0XL7s5TdeNcDjNP7r+48Aw8RHizmDApIxVHad1aJqdN+v4pVYWekTQPgDhcP5OWGmravnpgPWwpykWebiuV7ux7hPoK/7BIDTnuP+RF5x+nZYso7UZlL8MR+nmGErvZt7VCVWSbcemVQp/hkF0VPdweMcZxV+67gXM0cxqTNoVuBWYrdUdvYyJbVlt5JqVw9Z6Bvjm/VQ8DBqXzmtmTYDgbrXrGisZnZiGW1ZWvkLljS3HIcKPhJ/WoulLdO4+URqEvKzerThj3MUgiAhIqFfBQ1pFiw74V35Hn/XO3J/Pqfikh9mmVEAaLUgaMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWVERFJ9PqFKSyT4srd82031Du9GNyEn0Y8flW0V8PM=;
 b=Ccy0WaqeDLhLwGZi+KciiTEg1xi42O/9RGAm45fPwzFjo3/+/ASSi2qyzwCScRg9FDQzS8BEJIu0n6f1blXjlmU3KyDWt9i01mEMS1WM+NBlUX8vjgXcjWjURbLx06oxrzpkc5+wEOSZLjrsHFBfsTUCmbagg4kYPy5xgPcqh+I=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SA0PR12MB4590.namprd12.prod.outlook.com (2603:10b6:806:93::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Fri, 23 Jul
 2021 22:46:33 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::d0d3:a97e:6b7f:ab39]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::d0d3:a97e:6b7f:ab39%5]) with mapi id 15.20.4352.029; Fri, 23 Jul 2021
 22:46:33 +0000
Subject: Re: [PATCH v3 0/8] Support DEVICE_GENERIC memory in migrate_vma_*
From: "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>
To: Felix Kuehling <felix.kuehling@amd.com>, "Theodore Y. Ts'o" <tytso@mit.edu>
References: <20210617151705.15367-1-alex.sierra@amd.com>
 <YM9NXrGlhdp0qb7S@mit.edu> <905418d1-9099-0ea8-a6e6-84cc8ef3d0b0@amd.com>
 <YPGgvNxfOCx/Sp0g@mit.edu> <e9cc27d6-b0f2-8379-c276-0bbdae3ce4d7@amd.com>
 <601418f5-c526-08e9-b071-4533a32ce25d@amd.com>
Message-ID: <79416c93-2dc7-6097-01e4-d60d6221ee14@amd.com>
Date: Fri, 23 Jul 2021 17:46:30 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <601418f5-c526-08e9-b071-4533a32ce25d@amd.com>
Content-Language: en-US
X-ClientProxiedBy: MN2PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:208:160::15) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.4.141] (165.204.84.11) by
 MN2PR13CA0002.namprd13.prod.outlook.com (2603:10b6:208:160::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.9 via Frontend
 Transport; Fri, 23 Jul 2021 22:46:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6011aa29-e21c-4cdb-fea5-08d94e2bb883
X-MS-TrafficTypeDiagnostic: SA0PR12MB4590:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4590E68E42FAA09C0A019166FDE59@SA0PR12MB4590.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dGnQHW8hmv8nn2qaGblvx4INb/iw1NE6Xbsq9qE4r9CFAYskufIiZOxfkafcszBiuDXiVVnUg5/R8dM78Hs+0UjT0qDYrLxVnVmYmkhPT4PFy2LHOwXS63Js7P0mLNn9gWmfolp0Hzm2WVq6zE9PWUknGlSuzB5jBBmLRXRuns4qu3da8E83ZyRzZ/xPKr1KbSL/n2Z9ToV8gX07L5J03899aHJEkT7UzEBBBS7f0TLPiGMc25lNEVpE+6fez1Bth/JscH7xX3zNpgO6uuVA+Zz8xO4UNROyMgRrgD6ks7tJuocE0BKtWkgVFYwzNglrNQceobI+U9SwR1dlNd7ARa4rXhCvn3CXHFK6TI/Ob9W4Ve6R4CnBbrC0eGWWOsPRAJ3pwl9cLkP9JqgNSZB06yF/F/Kp4JRf3vgHAsRGkwY36LTSBEDzC7A/D1qg8BCUBdMStk82eiDh8ahKhy9r4IH9hvhBdc80hFPtzETZ+o2QA2Nw0pwuiSP7BeBDRomrg9qdNkBzehr8f8j51AzacY2MFIt4OkVlMem4xmAUGNpHhMKrNPCAZrfes6xgPVDDSI/6Ial+a6UpasoKDvdGfmI6E2tfczcSEtkQyXISPnHPQ1TL9n72Q05085VyfoGvAWXdNLy5DwamgPKDJC13yRzFbIP/FbPMBkbpu2hR2NEeF7wHhHaSEd54gpDqwhiWjUg2xpzF/0m+uzdKC1jlfDkSzRovIu1WXfr/fxykGMjQiJWaq7hL7NsAhFpSrAyNOIRuM7ITqfVUbKOHUqpSQ2mEEYJUgQUcwn10oUUpg0iT/qjB5z7Y0l+P5+ty9NW7SxSNfpEdUqkzAIhQkFI2PhmxyCv3LlogcYH0VHfVRzbc+3ojXILuVb0LESQIBsfN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(66946007)(36756003)(8676002)(6486002)(8936002)(53546011)(66476007)(2616005)(2906002)(16576012)(52116002)(31686004)(956004)(66556008)(478600001)(966005)(110136005)(316002)(86362001)(31696002)(83380400001)(26005)(38100700002)(38350700002)(186003)(7416002)(4326008)(5660300002)(41533002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2xmYnNiczB2L2RYMkZaTE9veTY4STNXeTFseEkvUkZKQmcvTDJtajMybFZK?=
 =?utf-8?B?Tm96U3hPVHE2SWFzS1BMVnA4R0hUVzFMNEE5RmpCUGFoREZWMHhWb2NoWUxx?=
 =?utf-8?B?N3V1ajJDdUNMc3VmQ09oOElqRDJqeWdRWCtDa013YmZTUFhNVm9ISXg2THEz?=
 =?utf-8?B?ZFJSYS9FTFdVYjBWMU9Ob3oweHdscnBMRHl0MzE5aFN4UmpTUVluL3p5clNw?=
 =?utf-8?B?N1RFYTZKeUVSRGFZak0xb2R2T2tYM2pTOXRVWUhVNytDNm9pbVRoUlN0bFk0?=
 =?utf-8?B?K1JZWEp5c0xRbEdxUzdEQkJwVkp4MnFsRmEzRGJkOG5RdXRaRmc1elNXS3RH?=
 =?utf-8?B?RjNJZytxd0VjL0JxVGEwcTJFYzZ2a3lGV1ZJcHpCS2c2Q1NIQzNJdDQ3Qmtp?=
 =?utf-8?B?ZDdIOHkvS1BWZVV3eEZvT09OS0Z1UEcxR0w0dGR0VXkrbzFIeHIzOVlRYnlZ?=
 =?utf-8?B?YVhKNkJ4ZGZLVk8rZVVwMTd2QllDRHpCbTFOejFBMHRNNi8rNDM5QnlXM3Fj?=
 =?utf-8?B?RnRGc3plV3ZzempFM2lWWCtnUDdnVG9NbnlPeHVFRjBtNWcreEpPQTliYTZP?=
 =?utf-8?B?V3FIdC90MzJuM3hBazVSaUo2cWhUVXE3LzVPZG5JdkNTSFN5cHhpZFZCUHpn?=
 =?utf-8?B?L3JpT1Y5MEZCdmJLNldtOVFwU2JoZ0UxbFJjZkF6ZElXbUVSQVZ2amRtcFNr?=
 =?utf-8?B?NTVlbDJ6QjRSTmxaTE9EOG1QamZhNFRKbHEwSUR6M1B2d0NiTUlQZlpEbTFx?=
 =?utf-8?B?U0NxSHgwbzRCME1obDlPK0JxTG1sME42cWFrbXNVQ3hxVzVUOWhGQlRrUG1m?=
 =?utf-8?B?UjlYb1QvdnpabU9tL2JFcTk0UEY1cUJzbFFUTFJVYStqc0NPZGdLTTY3dVRp?=
 =?utf-8?B?RndtMlhMeTFkYmtFOW5yQjlOazhmTW1Nd2RUT2djUGhxWXJYN25wZGwvVEo4?=
 =?utf-8?B?aTA2TEdjTzBsVVFuZ3ZoTmg0VkJhcEc3dndFdUxSUmN1ZitHMXViMW03WWxV?=
 =?utf-8?B?bm4wRGwzUTl2WW5FbCtmdFFLTlBSQ0NhWXlKZlliSGhxd05Xd1YrbG01SGRM?=
 =?utf-8?B?clUwSm9OekttYU5SdjNNaTBtMy9nWUU0ZTl3SUNBL25LT2loZm9Wck9nTE84?=
 =?utf-8?B?NGozTjJSMmdJVzEyMzZIVStKSlFieklINWkyZGh2STRITFZnQVd1VmxZM0tU?=
 =?utf-8?B?SUh0bFFOVUdoMGE5RURXWDlyd3F4UHBScHRub3NtYTJKMTMwVDBSaVprWitX?=
 =?utf-8?B?R0x5cTVXY09WYndSWWlpdkRFQkJONWhBS04xL0Y1YlVNSkxiV3VTbURYSTUz?=
 =?utf-8?B?V3VheDlBNGFycVRqNnFreXRTYzFSZ3hhcmJ4Q21ZZWk5TnQrL1dLNnlqNC93?=
 =?utf-8?B?MlM2a2lzQVNlTHVpZEhDblY1bkFSQ2R3Q3JJMjUxL0dKUjN5NTZKb0dVL2wy?=
 =?utf-8?B?K2ZnMHovTnZLTi9xRFhodm1GVGdFZEg2QlViYWZRa3NuZGMrZTBsdmdtTjVC?=
 =?utf-8?B?eDI4QWtlYVpERnQrQmVvZzlYVk5YWmxNOHU0MHUxQ3AxNVoxdDlSV2lqRGJM?=
 =?utf-8?B?KzdGR2N6VXdnSmtvZVFMZkY5QTFBaDZoSkc5K3ZhOHVYcUVTaW5oN3lWRWJq?=
 =?utf-8?B?bFBxbWFQYms2bThJbS9zK1dMUlhTNVpKT29EbnNWZUgzc21ISVdPaHlKMnNR?=
 =?utf-8?B?QnZ3eFB2eituZ2xsUnNmcUttZWtBTkxoeWhTWWxzYjBxdUFjYkdVQVdoTmln?=
 =?utf-8?Q?BpGEI9z4CM3ThC8dTVf++mLWjJYmoC7PJ/yN/O/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6011aa29-e21c-4cdb-fea5-08d94e2bb883
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2021 22:46:33.7591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /wK+abXlkxruwcX9thHD41ve9wzm2Igjjv0EchNiVy6hLf97K3gr/+f82bKqTu9fjc7uMnUsaLnypY8pbkxlZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4590
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
Cc: rcampbell@nvidia.com, amd-gfx@lists.freedesktop.org,
 linux-xfs@vger.kernel.org, linux-mm@kvack.org, jglisse@redhat.com,
 dri-devel@lists.freedesktop.org, jgg@nvidia.com, akpm@linux-foundation.org,
 linux-ext4@vger.kernel.org, hch@lst.de
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDcvMTcvMjAyMSAyOjU0IFBNLCBTaWVycmEgR3VpemEsIEFsZWphbmRybyAoQWxleCkgd3Jv
dGU6Cj4KPiBPbiA3LzE2LzIwMjEgNToxNCBQTSwgRmVsaXggS3VlaGxpbmcgd3JvdGU6Cj4+IEFt
IDIwMjEtMDctMTYgdW0gMTE6MDcgYS5tLiBzY2hyaWViIFRoZW9kb3JlIFkuIFRzJ286Cj4+PiBP
biBXZWQsIEp1biAyMywgMjAyMSBhdCAwNTo0OTo1NVBNIC0wNDAwLCBGZWxpeCBLdWVobGluZyB3
cm90ZToKPj4+PiBJIGNhbiB0aGluayBvZiB0d28gd2F5cyB0byB0ZXN0IHRoZSBjaGFuZ2VzIGZv
ciAKPj4+PiBNRU1PUllfREVWSUNFX0dFTkVSSUMgaW4KPj4+PiB0aGlzIHBhdGNoIHNlcmllcyBp
biBhIHdheSB0aGF0IGlzIHJlcHJvZHVjaWJsZSB3aXRob3V0IHNwZWNpYWwgCj4+Pj4gaGFyZHdh
cmUgYW5kCj4+Pj4gZmlybXdhcmU6Cj4+Pj4KPj4+PiBGb3IgdGhlIHJlZmVyZW5jZSBjb3VudGlu
ZyBjaGFuZ2VzIHdlIGNvdWxkIHVzZSB0aGUgZGF4IGRyaXZlciB3aXRoIAo+Pj4+IGhtZW0gYW5k
Cj4+Pj4gdXNlIGVmaV9mYWtlX21lbSBvbiB0aGUga2VybmVsIGNvbW1hbmQgbGluZSB0byBjcmVh
dGUgc29tZSAKPj4+PiBERVZJQ0VfR0VORVJJQwo+Pj4+IHBhZ2VzLiBJJ20gb3BlbiB0byBzdWdn
ZXN0aW9ucyBmb3IgZ29vZCB1c2VyIG1vZGUgdGVzdHMgdG8gZXhlcmNpc2UgCj4+Pj4gZGF4Cj4+
Pj4gZnVuY3Rpb25hbGl0eSBvbiB0aGlzIHR5cGUgb2YgbWVtb3J5Lgo+Pj4gU29ycnkgZm9yIHRo
ZSB0aHJlYWQgbmVjcm9tYW5jeSwgYnV0IG5vdyB0aGF0IHRoZSBtZXJnZSB3aW5kb3cgaXMKPj4+
IHBhc3QuLi4uCj4+IE5vIHdvcnJpZXMuIEFsZWphbmRybyBzaG91bGQgaGF2ZSBhIG5ldyB2ZXJz
aW9uIG9mIHRoaXMgc2VyaWVzIGluIGEgZmV3Cj4+IGRheXMsIHdpdGggdXBkYXRlcyB0byBobW1f
dGVzdCBhbmQgc29tZSBmaXhlcy4KPgo+IFY0IHBhdGNoIHNlcmllcyBoYXZlIGJlZW4gc2VudCBm
b3IgcmV2aWV3Lgo+IGh0dHBzOi8vbWFyYy5pbmZvLz9sPWRyaS1kZXZlbCZtPTE2MjY1NDk3MTYx
ODkxMSZ3PTIKPgo+IFJlZ2FyZHMsCj4gQWxleCBTaWVycmEKPgo+Pgo+Pgo+Pj4gVG9kYXkgSSB0
ZXN0IGV4dDQncyBkYXggc3VwcG9ydCwgd2l0aG91dCBoYXZpbmcgYW55ICQkJCBEQVggaGFyZHdh
cmUsCj4+PiBieSB1c2luZyB0aGUga2VybmVsIGNvbW1hbmQgbGluZSAibWVtbWFwPTRHITlHOm1l
bW1hcD05RyExNEciIHdoaWNoCj4+PiByZXNlcnZlcyBtZW1vcnkgc28gdGhhdCBjcmVhdGVzIHR3
byBwbWVtIGRldmljZSBhbmQgdGhlbiBJIHJ1bgo+Pj4geGZzdGVzdHMgd2l0aCBEQVggZW5hYmxl
ZCB1c2luZyBxZW11IG9yIHVzaW5nIGEgR29vZ2xlIENvbXB1dGUgRW5naW5lCj4+PiBWTSwgdXNp
bmcgVEVTVF9ERVY9L2Rldi9wbWVtMCBhbmQgU0NSQVRDSF9ERVY9L2Rldi9wbWVtMS4KPj4+Cj4+
PiBJZiB5b3UgY2FuIGdpdmUgbWUgYSByZWNpcGUgZm9yIHdoYXQga2VybmVsIGNvbmZpZ3MgSSBz
aG91bGQgZW5hYmxlLAo+Pj4gYW5kIHdoYXQgbWFnaWMga2VybmVsIGNvbW1hbmQgbGluZSBhcmd1
bWVudHMgdG8gdXNlLCB0aGVuIEknZCBiZSBhYmxlCj4+PiB0byB0ZXN0IHlvdXIgcGF0Y2ggc2V0
IHdpdGggZXh0NC4KPj4gVGhhdCB3b3VsZCBiZSBncmVhdCEKPj4KPj4gUmVnYXJkaW5nIGtlcm5l
bCBjb25maWcgb3B0aW9ucywgaXQgc2hvdWxkIGJlIHRoZSBzYW1lIGFzIHdoYXQgeW91J3JlCj4+
IHVzaW5nIGZvciBEQVggdGVzdGluZyB0b2RheS4gV2UncmUgbm90IGNoYW5naW5nIG9yIGFkZGlu
ZyBhbnkgS2NvbmZpZwo+PiBvcHRpb25zLiBCdXQgbGV0IG1lIHRha2UgYSBzdGFiOgo+Pgo+PiBa
T05FX0RFVklDRQo+PiBITU1fTUlSUk9SCj4+IE1NVV9OT1RJRklFUgo+PiBERVZJQ0VfUFJJVkFU
RSAobWF5YmUgbm90IG5lZWRlZCBmb3IgeW91ciB0ZXN0KQo+PiBGU19EQVgKSGkgVGhlb2RvcmUs
Ckkgd29uZGVyIGlmIHlvdSBoYWQgY2hhbmNlIHRvIHNldCB0aGUga2VybmVsIGNvbmZpZ3MgZnJv
bSBGZWxpeCB0byAKZW5hYmxlIERBWCBpbiB4ZnN0ZXN0cy4KCkkndmUgYmVlbiB0cnlpbmcgdG8g
dGVzdCBGUyBEQVggb24gbXkgc2lkZSB1c2luZyB2aXJ0aW8tZnMgKyBRRU1VLiAKVW5mb3J0dW5h
dGVseSwgSW0gaGF2aW5nIHNvbWUgcHJvYmxlbXMgc2V0dGluZyB1cCB0aGUgZW52aXJvbm1lbnQg
d2l0aCAKdGhlIGd1ZXN0IGtlcm5lbC4gQ291bGQgeW91IHNoYXJlIHlvdXIgVk0gKFFFTVUgb3Ig
R0NFKSBzZXR1cCB0byBydW4gaXQgCndpdGggeGZzdGVzdHM/CgpSZWdhcmRzLApBbGV4IFMuCgo+
Pgo+PiBJJ20gbm90IHN1cmUgd2hhdCB5b3UncmUgbG9va2luZyBmb3IgaW4gdGVybXMgb2Yga2Vy
bmVsIGNvbW1hbmQgbGluZSwKPj4gb3RoZXIgdGhhbiB0aGUgbWVtbWFwIG9wdGlvbnMgeW91IGFs
cmVhZHkgZm91bmQuIFRoZXJlIGFyZSBzb21lIG1vcmUKPj4gb3B0aW9ucyB0byBydW4gaG1tX3Rl
c3Qgd2l0aCBmYWtlIFNQTSAoREVWSUNFX0dFTkVSSUMpIG1lbW9yeSwgYnV0IHdlJ3JlCj4+IGFs
cmVhZHkgcnVubmluZyB0aGF0IG91cnNlbHZlcy4gVGhhdCB3aWxsIGFsc28gYmUgaW4gdGhlIG5l
eHQgcmV2aXNpb24KPj4gb2YgdGhpcyBwYXRjaCBzZXJpZXMuCj4KPiBJbiBvcmRlciB0byBydW4g
aG1tIHRlc3Qgd2l0aCBnZW5lcmljIGRldmljZSB0eXBlIGVuYWJsZWQsIHNldCB0aGUgCj4gZm9s
bG93aW5nOgo+Cj4ga2VybmVsIGNvbmZpZzoKPiBFRklfRkFLRV9NRU1NQVAKPiBSVU5USU1FX1RF
U1RJTkdfTUVOVQo+IFRFU1RfSE1NPW0KPgo+IEtlcm5lbCBwYXJhbWV0ZXJzIHRvIGZha2UgU1Ag
bWVtb3J5LiBUaGUgYWRkcmVzc2VzIHNldCBoZXJlIGFyZSBiYXNlZCAKPiBvbiBteSBzeXN0ZW0n
cyB1c2FibGUgbWVtb3J5IGVudW1lcmF0ZWQgYnkgQklPUy1lODIwIGF0IGJvb3QuIFRoZSB0ZXN0
IAo+IHJlcXVpcmVzIHR3byBTUCBkZXZpY2VzIG9mIGF0IGxlYXN0IDI1Nk1CLgo+IGVmaV9mYWtl
X21lbT0xR0AweDEwMDAwMDAwMDoweDQwMDAwLDFHQDB4MTQwMDAwMDAwOjB4NDAwMDAKPgo+IFRv
IHJ1biB0aGUgaG1tX3Rlc3QgaW4gZ2VuZXJpYyBkZXZpY2UgdHlwZSBwYXNzIHRoZSBTUCBhZGRy
ZXNzZXMgdG8gCj4gdGhlIHNoIHNjcmlwdC4KPiBzdWRvIC4vdGVzdF9obW0uc2ggc21va2UgMHgx
MDAwMDAwMDAgMHgxNDAwMDAwMDAKPgo+Pgo+PiBJZiB5b3UgY2FuIHJ1biB5b3VyIHhmc3Rlc3Rz
IHdpdGggREFYIG9uIHRvcCBvZiB0aGlzIHBhdGNoIHNlcmllcywgdGhhdAo+PiB3b3VsZCBiZSB2
ZXJ5IGhlbHBmdWwuIFRoYXQncyB0byBtYWtlIHN1cmUgdGhlIFpPTkVfREVWSUNFIHBhZ2UgcmVm
Y291bnQKPj4gY2hhbmdlcyBkb24ndCBicmVhayBEQVguCj4+Cj4+IFJlZ2FyZHMsCj4+IMKgwqAg
RmVsaXgKPj4KPj4KPj4+IENoZWVycywKPj4+Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gVGVkCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
