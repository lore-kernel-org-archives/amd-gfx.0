Return-Path: <SRS0=4Sal=K5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA94C47082
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 14:22:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C625613D6
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 14:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C625613D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C069A6EA74;
	Thu,  3 Jun 2021 14:22:43 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55B4B6EA74;
 Thu,  3 Jun 2021 14:22:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNvj0f2jZ0Fzw3jzr2KqIUhEVF22V8yv4DJyMazpM5hZHraiwPL5pIA/6Z4xfpZqizKl1+Pxg8jmlt60Xst8UEMGxWkJghbgIgANJsZMul74P9iSQXoh7T+mPRCpsA8Pf3/GZgR/v9XgFt1Tv+Bmwl0lkDvoi+EIU82LOjgJU2NBa5SKsjL0bhZNxNSkSZEkuz9KyZZQlJiu4Prq2c2aYm4z1i1xw1SeRRPnOAYhkN8HqWBcpSSkdsH7gXzFRVDX5bJZnr1iH0LJY7tWXUmqAKkCQ1K9gWSZei8C7Rc5IMGBeJNPi0MtzAtC3W3xCRmLdwg+CruOR4qUKpt+lWammw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWlhN6zWhIVxk5wyReKXIsnUbbpPHbJP2OheAsla9hQ=;
 b=KWOIZkDjnEQu6riDdGQ8Jv6Obu30zr7ig99o5byPeYwZmHxhbt02HniFgU8zeiA+9L5Q/VL4D/H3KMN10+dHhUzspr5QZiXxX4hgFSz1CqBACmNV+UOxJkvJXb+kk7l4JFh0vACVWw1+NJhcY6zMFaRpgYDaNyw/Gq02CafOs1wpdrY1jeANXMgbFqgRpCxkn0g0unkVjrhoV0Y+HcSJfiwNHxG5w10BWsVsEFh0SNlboXOJDjSQSAsV1z/PeUZLqUjO77z846ZbLRn2gyjMcuvgCVlY0oI4gXtd+w69Y5g5FmZWvrzZ7bZ61GIOUVlpFiI9kULKZvvTHp20NwGBdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWlhN6zWhIVxk5wyReKXIsnUbbpPHbJP2OheAsla9hQ=;
 b=FOJYKGOadxNSRD6+F+QM970oAMiZrvbwDDYUGODctPylaSWB/ibIlrG2HUc/DzLKbhDhNkZW1vCQ1hj6h2GgT8So8u6BsqAKE17CDjPk03Gv65vfg4Ju50X+buOGOpnr98TMFpvmZFwIftcIHxEacR21MKfjD0KEFSE6/i4JcVA=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB4624.namprd12.prod.outlook.com (2603:10b6:805:e7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Thu, 3 Jun
 2021 14:22:40 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c%7]) with mapi id 15.20.4173.030; Thu, 3 Jun 2021
 14:22:40 +0000
Subject: Re: [PATCH 0/7] libdrm tests for hot-unplug feature
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: Daniel Vetter <daniel@ffwll.ch>
References: <20210601201702.23316-1-andrey.grodzovsky@amd.com>
 <CAKMK7uFoLmOFCTkPMm4mMSScF0xa+MnHvY2FVmfBUM8b8S0_PQ@mail.gmail.com>
 <de4b3521-42f7-7fc2-7271-e4fa3cd91708@amd.com>
Message-ID: <baf1d1f8-48c7-ed83-8e42-a4a317bfa74d@amd.com>
Date: Thu, 3 Jun 2021 10:22:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <de4b3521-42f7-7fc2-7271-e4fa3cd91708@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:ad5a:bddc:f41b:7421]
X-ClientProxiedBy: YT1PR01CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::20) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:ad5a:bddc:f41b:7421]
 (2607:fea8:3edf:49b0:ad5a:bddc:f41b:7421) by
 YT1PR01CA0051.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.27 via Frontend Transport; Thu, 3 Jun 2021 14:22:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b56faaa9-4ccc-4329-7501-08d9269b0b25
X-MS-TrafficTypeDiagnostic: SN6PR12MB4624:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB4624077FFA078E3F29E4542EEA3C9@SN6PR12MB4624.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uWStY2rfDrfJjoHHiSKdW5a8GWGqlz7RBvg6Xt2p2UzAO8xUsxUKgs+IbXGACjI1ufOZvsK/7ujIXPRzqY5hOmIUmleWHlLEr891H4BOpEVXVIdoB5OeLbnWTOlqNgXgCOLLq7ynHY01ibPcdOQRbQcb3gHdKhgILwYd5B7Gz0R/blvq43RzQk0BK5Ei3tk946ptIkEeQYhRnZmiTpILTPcNlHbjiA0KL0zYO5sKd4Ya6XkjuX+3xJcg6fVAP3mZJBjixZGjHUypaA5hMr4H7gdSCWf4/R2qnM9k16dy6Kf/H23PSXiEsQ24cybkWpytg9TdjTYIQlT64ib1YMdaji1wiuHgHeuiuDvpcLYNSTgfvDj00+7QA49h1m/hApE1G+0rgh7GknTP6FvKBwywCeacVFsd8eaw+gpB6h+5tIL8uFKrBZFW1f49YsK6B+29TNYrwZlIWBKDmmdIfdd2ERyD7J25WCy0SJihFbn1qN+B6KxI4NE8ir+qLSbraZQWZNxJlcDL69+CHJ1PiyamtjRQZJpXZYlgwO/2GGZdmkvMUhah4SlRIdwqBo/RXIpNfDqHVez8HPW3iWE5lJmirCkxbJDOlD7iVa1zL5cDr6i+I4zhZPShsfngRbP4cs0GdFSxu5Z22dWamDqxoJyu//aNSD8nwt2tViOdTiqCwEGDg9TLUefzvbWptomOvVnf8yR4rQxyYgqfq9Q70u+N5HDPIep/TMYs9xj7zrjWKa8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(478600001)(8676002)(31696002)(66946007)(86362001)(66476007)(66556008)(16526019)(5660300002)(44832011)(6916009)(8936002)(31686004)(2616005)(6486002)(54906003)(316002)(36756003)(53546011)(38100700002)(4326008)(966005)(83380400001)(52116002)(2906002)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SEt5RGF1Y0oyRTJNUVVNVFJMTmVGR1VwdWNRQjJXK2NPcWZUd0hGK283Q3ZZ?=
 =?utf-8?B?WmZVQ3MralJUSGpRaUx5VWtwT3FLN1BhMUpOR3E3ZU82V3VCTW9wdi9FM0ZO?=
 =?utf-8?B?VHJoem9XekFTS3B1dWlmdWtZbmRYaVVxaVRWcDVnaFBNUGxQVGVLOWtwaGFD?=
 =?utf-8?B?OE44Rzl0TDZiUzBodFIyTVhRR291MXdDS2tMTm5Bcm9yTUxwUVF4ajQ1VkNo?=
 =?utf-8?B?NEtyS3A1ZGtrbzFNL1VuSm5TbXlaSzVsbGpnb2F1WTliR3pySzlaMW1wQzVU?=
 =?utf-8?B?cU5PTWVYZkRrVEFaK3BvaEZET3hEN3FCOWRUMVZpMGYxT3d6M00xcm9saXlm?=
 =?utf-8?B?OFMxNS9vZVV3MkVRbytZK3dCZ0poZmlzZXA4RDA0dzlXWGtQRnI0WThXVGkv?=
 =?utf-8?B?ZE9lTUNuSmU1VmhrV1VZYWxRZFpNSEhOYUF5NElEODRwRzI2RWdmelFtcXpX?=
 =?utf-8?B?TFNXMW9qYU96Z1RnZXI4YUFESUY3RFUvSW1SWi8vVG1vT3MzVWVWNTQ4djlx?=
 =?utf-8?B?RU02d1hZMk5WYjJGZnBibXlYdnpKQzVIMi9JUnEvbklFZytZcFRDV0hwQlQr?=
 =?utf-8?B?OGEveGZpaHBPbno4R2Q3Z1pOeDh2UlJrOXhkcE8wZHNNbk10T2ZOcHhZN1dl?=
 =?utf-8?B?WTJKNlRwUGtKL3VKSVFWVTlYMHZ6clFCTjh1S29lTC84TEJwbHI5dFRjQ2dX?=
 =?utf-8?B?TFpXdGRnWXBuNDJNWStUV1N3VlJvWGJQbjZid3V6OTRwd1pEdk95MGlNM2ZL?=
 =?utf-8?B?ZGg3WjZPVEtzZkw3SjdnN1AxaDV3MjdQUS9qbndLbmVQNG9ZNDZRc3FZTGQw?=
 =?utf-8?B?ZkYyTEZ2SmYrc0dFQVkwR2c0U2NRMkFRVDQzcmpIM3FUcXQyVTU4YW9kV0U1?=
 =?utf-8?B?T1lZMVYzTnNFMFhKQ3oySEhEb21IVS9RMU9DMytKYlZERDUzL2NwSk0zQ0tm?=
 =?utf-8?B?YmFEVGd6N1VmandOamduSWlxemFTbjNYb3lMUC9wZWhXeXV6ZUh2YmxDWFZU?=
 =?utf-8?B?T1V2YklSdlZoanZnQkxvb2hkblduT3AxRkxZbDR6NHFyakVjRDhod2hlRitm?=
 =?utf-8?B?OUs0MnRkV1BGUDMyc3BHUlhvTjdJMURkWDJ4VkREcUd5enRaalBTdWZKRGhl?=
 =?utf-8?B?dVNXRWEzQStYY2orTk41YTNlU1RmaW5Qc0hLY3IwOFlwQnoyblQ2b2tFWVp1?=
 =?utf-8?B?a0l5dFMxOHdBMjQwbXBaV2FrRFN0MVFHMENGeGZ2MlZWOGpvVGlWRCtuekZ0?=
 =?utf-8?B?bUhGeE9qQVJPV3JRM1hHRFQrM3hDaHhPWVN1NnA5bHMzT0JqcytRRkJvNzVt?=
 =?utf-8?B?SUpjYURVdUJiNGxKSTdQcFpGV1N2UEJiTm14NUFFMG9mRDJUQXJ2MkhlSHA4?=
 =?utf-8?B?TmE1citKUkdTVkl0d1JrU09TTjMwOC83NlFpeUFKcXh1MzBTY3JVekVGVk1p?=
 =?utf-8?B?REx6SVZIK3dqS2F4dlIwZCtxazh3SSt0cnNrYm1zNjhtZUJQNC9pSHBRVlA5?=
 =?utf-8?B?L21wNitGTXN5a0tvMFJ3SjBBRlFGbCt1YVFKUDhMSFdCUFZCUEMyeDNqa1BS?=
 =?utf-8?B?UXI5TnF2QWxCMjMzM1J1aHVVelBGcFcva053N3JIU1E2ZVNUZXVYMDlvZGdS?=
 =?utf-8?B?OWY2eGlsVWp1OFI1YllpQTQxVHhsdnBlZW5KUGMrdVdqcWIrSWRTWUtUOEtE?=
 =?utf-8?B?WGFkeGlpUWNCemVwUGk4WE5hcnBtWEZSNWRQVU0vbDRKcTB0VW5GMGZadDc4?=
 =?utf-8?B?dVhKZzdvTFpaVlRqVHczNmdZTGtYblFjUmVEeXpraDVMUVZsTkxEUEF1cXVH?=
 =?utf-8?B?THhqU0Z5SUNQRHo3TUF4bVJFTlI3cDN3M3dmWHB2UDBLQ0w5Z21yWFdkUEFM?=
 =?utf-8?Q?SRlTx6qpLet2G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b56faaa9-4ccc-4329-7501-08d9269b0b25
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 14:22:40.1884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6LauAwUkKYdqaYLDet+38vAR3Gr2WAc/w8ze1l2+5q5YfSrhMCutsXnVURxPHOlmvmm4n6IE3/G5rT1vSlwUcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4624
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UGluZwoKQW5kcmV5CgpPbiAyMDIxLTA2LTAyIDEwOjIwIGEubS4sIEFuZHJleSBHcm9kem92c2t5
IHdyb3RlOgo+Cj4gT24gMjAyMS0wNi0wMiAzOjU5IGEubS4sIERhbmllbCBWZXR0ZXIgd3JvdGU6
Cj4+IE9uIFR1ZSwgSnVuIDEsIDIwMjEgYXQgMTA6MTcgUE0gQW5kcmV5IEdyb2R6b3Zza3kKPj4g
PGFuZHJleS5ncm9kem92c2t5QGFtZC5jb20+IHdyb3RlOgo+Pj4gQWRkaW5nIHNvbWUgdGVzdHMg
dG8gYWNvbXBhbnkgdGhlIHJlY2VudGx5IGFkZGVkIGhvdC11bnBsdWcKPj4+IGZlYXR1cmUuIEZv
ciBub3cgdGhlIHRlc3Qgc3VpdGUgaXMgZGlzYWJsZWQgdW50aWwgdGhlIGZlYXR1cmUKPj4+IHBy
b3BhZ2F0ZXMgZnJvbSBkcm0tbWlzYy1uZXh0IHRvIGRybS1uZXh0Lgo+Pj4KPj4+IEFuZHJleSBH
cm9kem92c2t5ICg3KToKPj4+IMKgwqAgdGVzdHMvYW1kZ3B1OiBGaXggdmFsZ3JpbmQgd2Fybmlu
Zwo+Pj4gwqDCoCB4Zjg2ZHJtOiBBZGQgZnVuY3Rpb24gdG8gcmV0cmlldmUgY2hhciBkZXZpY2Ug
cGF0aAo+Pj4gwqDCoCB0ZXN0L2FtZGdwdTogQWRkIGhlbHBlciBmdW5jdGlvbnMgZm9yIGhvdCB1
bnBsdWcKPj4+IMKgwqAgdGVzdC9hbWRncHUvaG90dW5wbHVnOiBBZGQgdGVzdCBzdWl0ZSBmb3Ig
R1BVIHVucGx1Zwo+Pj4gwqDCoCB0ZXN0L2FtZGdwdS9ob3R1bnBsdWc6IEFkZCBiYXNpYyB0ZXN0
Cj4+PiDCoMKgIHRlc3RzL2FtZGdwdS9ob3R1bnBsdWc6IEFkZCB1bnBsdWcgd2l0aCBjcyB0ZXN0
Lgo+Pj4gwqDCoCB0ZXN0cy9hbWRncHUvaG90dW5wbHVnOiBBZGQgaG90dW5wbHVnIHdpdGggZXhw
b3J0ZWQgYm8gdGVzdAo+PiBHaXZlbiBob3cgbmFzdHkgaG90dW5wbHVnIGlzIEkgcmVhbGx5IHRo
aW5rIGNvbGxhYm9yYXRpbmcgb24gaWd0IHRlc3RzCj4+IG9uIHRoaXMgd291bGQgYmUgYmVzdCBm
b3IgZXZlcnlvbmUgLi4uIGRvIHdlIGhhdmUgdG8ga2VlcCBkb2luZwo+PiBwYXJhbGxlbCB0ZXN0
cyBoZXJlIGZvciBhbWRncHU/Cj4+IC1EYW5pZWwKPgo+IEFGQUlLIGFzIGZhciBhcyBBTUQgZ29l
cyBhIGxvdCBvZiBkZXZlbG9wZXJzIHVzZSBsaWJkcm0gZm9yIHJlZ3Jlc3Npb24gCj4gdGVzdGlu
Zwo+IHdoaWxlIGRldmVsb3BpbmcgdGhlaXIgZmVhdHVyZXMgYW5kIGFsc28gUUEgYXMgaSBjYW4g
c2VlIGZyb20gc29tZSAKPiBpbnRlcm5hbCB0aWNrZXQKPiBzcGVjaWZpY2FsbHkgb3BlbmVkIGZv
ciBmYWlsaW5nIHRvIHBhc3MgbGliZHJtIHRlc3RzLiBGcm9tIG15IGJpdHRlciAKPiBleHBlcmll
bmNlIHdpdGgKPiBHUFUgcmVzZXQgLSBmZWF0dXJlcyB3aGljaCBhcmUgbm90IHBhcnQgb2YgYSBj
b21tb24gdXNlIGNhc2Ugc3VjaCBhcyAKPiBkZXZpY2UgbG9hZGluZywKPiBtb2RlIHNldHRpbmcg
b3IgY29tbWFuZHMgc3VibWlzc2lvbnMgdGVuZCB0byB2ZXJ5IHF1aWNrbHkgYnJlYWsgYXMgCj4g
cGVvcGxlIGRldmVsb3AKPiBmZWF0dXJlcyBidXQgbmV2ZXIgdGVzdCB0aGVtIGluIHRob3NlIHVu
Y29tbW9uIHVzZSBjYXNlcyAtIHRoaXMgaXMgd2h5IAo+IEkgZmVlbCBpdCB3aWxsIGJlCj4gdmVy
eSBoZWxwZnVsIHRvIGluY2x1ZGUgdGhvc2UgdGVzdHMgaW4gbGliZHJtLgo+Cj4gQWxzbyBnaXZl
biB0aGF0IHRoaXMgaXMgbGliZHJtIGFtZGdwdSBjb2RlIGl0IGZpdHMgbmF0dXJhbGx5IGludG8g
bGliZHJtLgo+Cj4gUmVnYXJkaW5nIElHVCAtIGFzIHlvdSBtYXkgcmVtZW1iZXIgSSBoYXZlIHRo
ZW0gdGhlcmUgdG9vIC0gCj4gaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2Fncm9kem92
L2lndC1ncHUtdG9vbHMvLS9jb21taXRzL21hc3Rlcgo+IEkgaGl0IHNvbWUgY29tcGlsZSBicmVh
a2FnZSBvbiBkZWJpYW4gcGxhdGZvcm0gdGhlcmUgd2hpY2ggaSBuZWVkIHRvIAo+IHJlc29sdmUg
YmVmb3JlIGkgd2lsbCBzdWJtaXQgZm9yIHJldmlldyB0aGVyZSB0b28uCj4KPiBBbmRyZXkKPgo+
Cj4+Cj4+PiDCoCB0ZXN0cy9hbWRncHUvYW1kZ3B1X3Rlc3QuY8KgwqDCoMKgIHzCoCA0MiArKyst
Cj4+PiDCoCB0ZXN0cy9hbWRncHUvYW1kZ3B1X3Rlc3QuaMKgwqDCoMKgIHzCoCAyNiArKysKPj4+
IMKgIHRlc3RzL2FtZGdwdS9iYXNpY190ZXN0cy5jwqDCoMKgwqAgfMKgwqAgNSArLQo+Pj4gwqAg
dGVzdHMvYW1kZ3B1L2hvdHVucGx1Z190ZXN0cy5jIHwgMzU3IAo+Pj4gKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrCj4+PiDCoCB0ZXN0cy9hbWRncHUvbWVzb24uYnVpbGTCoMKgwqDC
oMKgwqAgfMKgwqAgMSArCj4+PiDCoCB4Zjg2ZHJtLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgIDIzICsrKwo+Pj4gwqAgeGY4NmRybS5owqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEgKwo+Pj4gwqAgNyBmaWxlcyBj
aGFuZ2VkLCA0NTAgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKPj4+IMKgIGNyZWF0ZSBt
b2RlIDEwMDY0NCB0ZXN0cy9hbWRncHUvaG90dW5wbHVnX3Rlc3RzLmMKPj4+Cj4+PiAtLSAKPj4+
IDIuMjUuMQo+Pj4KPj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
