Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B608CC433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 11:39:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 530E36135B
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 11:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 530E36135B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3BB26ED34;
	Wed, 19 May 2021 11:39:37 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2083.outbound.protection.outlook.com [40.107.95.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E08F6ED34
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 11:39:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9gN+TuQ641mKk23Q2WNu348r2ce9hgvFR3XNsb+0x2jiaOVcJwYxpVIxUCx/y+7jVjGSol77y5Dvs/O71sU9zle+9MNArbqwILcLxzJPk7pStDAIIrQ+qxyhBcneQU+KTQTQBrOi8AGwVhePxyc2UvA/meEOfNYWk+f2vjNvgVDW61IdNsEDUPMfD9rzWfqc5oSI1sjAq9NwD0IWd6BIcSMLfnZF3A0KvlHcDDHrhCs5rlGNHn8ESjJG906xbq0tkuFh6GgvVRuc0iCYkl2qQ/6fykPp3ey7/sc8xFRQBm7y8ejo1cSWehPC98naWOEOtoBQVNYh9zjH7tdX3mGGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxT+lQN8LIFM5trTeB+9jpWOq0P7mkApwlwdVsxihSk=;
 b=MPIGzwctiZhDzd28AHZcTJjaKnc5OermwmpqhGUhtYQ/po/e7pgGZ3unRcTQKmdCaGWZVScGkyXvjXdZc9cFuJO3qUWUowwrcA5J9WtIlSX0OS+4L1o0XcTyCK/C2eHyI3pYr1rYqGWa6rJnkJYsKJFtoi1kXj0tP2XFrxHQyJIagIR+DPgkDdb5lWkeFWABMVkUvhYSyulXnu4yuw1hAjbnjsU1nlTrUEeAmwIF9KuvMuVWsAjAeg8o+OMSINjeczC8Ts3mWVSDXZv819AzAfiuPJW4vtcp+1WlG8JojQVJxcusCnpW/6v9JlkiemXcYyOblkT8/EllDPg63GMJAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxT+lQN8LIFM5trTeB+9jpWOq0P7mkApwlwdVsxihSk=;
 b=UduF4mZTiMsL18EXASS5RwA+On5fSBt2XpJmWjifIH/5kVCbBufW3OvRwBikyvECOVT3jExIBtBnD9z7MOn5lyHmcQt4CklyHpJHR2WluICkLsgv3mLuiuP+E4YDQdYfLi6QKneO1RpDTBWOvJMYfiaZjCNJg3art3c39Rw/rbA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 19 May
 2021 11:39:32 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c%7]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 11:39:32 +0000
Subject: Re: [PATCH] drm/amd/amdgpu: fix a potential deadlock in gpu reset
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210517105232.7776-1-Lang.Yu@amd.com>
 <cc8aedad-cca1-f486-651b-ed85e267aa95@gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <50f9e855-c331-6dd9-8d12-22b1f8be82b8@amd.com>
Date: Wed, 19 May 2021 07:39:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <cc8aedad-cca1-f486-651b-ed85e267aa95@gmail.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:1069:60ba:d67c:3ab3]
X-ClientProxiedBy: YTOPR0101CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::44) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:1069:60ba:d67c:3ab3]
 (2607:fea8:3edf:49b0:1069:60ba:d67c:3ab3) by
 YTOPR0101CA0067.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.30 via Frontend
 Transport; Wed, 19 May 2021 11:39:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fefbcf3-a496-411a-2aa3-08d91abac4ed
X-MS-TrafficTypeDiagnostic: SN6PR12MB4720:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB472090234893D34811D65B21EA2B9@SN6PR12MB4720.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZSqrPy/aOewPNJZi8BMbfdxM5qkJsZOM2pYdUfOg8XWB6xXTGDp/rqa1h97+dTgPEOZlzSAdWJ4zxNM3Bm4OnG94Ef0BQP60lg7j9kDzWwk9aDXql75807S4QbgQR/de57jyOCEcF+ZPvvrwQdtsE9ehGq1hPxGC5YnP3I3fTmr73Eb6qdntUxG6EyCykDWCQVHpH3xfzVxCxhO14k7rlnBbS1M3ocCLUKfmMVEjk5SwPAh5awX3qXVjhj79yJn35G6EcN39uwiOX+er8/27KadZmJb6akOKxoI0pZ/JangjjHOYgIOeUN/TyD3EO/WuspRPbqMqYNQLQluJ0p3/WWf+w2MLdTg63G6jsXzRrUypUfUSnjRInQvvCda3fjnfwTU7VSouKea/fkfGhB4qUCID0rg7+yy6fLyF/wy2kmrI6iv3NCsTNEyT7abBXBzgqnUEE6fgIBYi/vwCELlDtYByUDCPo4ul7vlddc2lZp6MJQ4LOpkWRK0qKWfDE7JJLPO9wsGrRN0BEWSEeCT7uKpJQyOOfqa+rFEVy+2FfGIvfQnl5SIqUhmLgzLwk92rPVdRC2TG8Rp9P6fafuBO2RRCX5yVJmMqZsRbkYJRk1LnOlIoIKPGIMmHCaq/XcKH8cTpJ+VYCmkj9OoUr2IXzmsLsSt0Nrz7ZxjpJ0friNVZXql6lHzuUNlz+UZ8e4ay
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(366004)(376002)(4326008)(86362001)(44832011)(31696002)(83380400001)(66574015)(110136005)(31686004)(316002)(2616005)(66556008)(8676002)(66476007)(8936002)(54906003)(52116002)(38100700002)(5660300002)(6486002)(2906002)(66946007)(36756003)(186003)(478600001)(16526019)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eGt3eFZ2MWFLbVBSUDRHS1J1U1dRZWdMam94cWUycWhlMzdlUFl1ZEYrbXp6?=
 =?utf-8?B?WFI3OFRXMmh1N1hkQ3J6UlVvN0Iwc3BJQmZ4NXBzd0VGU0IwQk9DRkpodFRx?=
 =?utf-8?B?VDVIZ085cVdEQUt4Wm5XcUtJNXlxNnhFOVJvTjVDMlN0NW14L3BCTno3Nm51?=
 =?utf-8?B?Q3JtdzNEWFRuTnZMaE5DOWVGR3p3WnRobkZORUNJZUFLYXFRTGlpVEtRaENu?=
 =?utf-8?B?RDN4WkFlWXRuZHVRS2NaNUhTVTlhTjgzWHdOTEhFMXVSMHpQTlF6Z1VIdGpT?=
 =?utf-8?B?dVJieGVhL3I3dFBRemxwMVFVNnVxeGR2V1pqMVcyMGtPWjNteWpWa2p1aEtj?=
 =?utf-8?B?V3NuMklYK1RHVEJuUG9JK216NlhUeGtSbFkrdmxTUHZiZUZaVmErOHVrZzR0?=
 =?utf-8?B?UWxqQnFDSVBCeHBjS09FeGh2WHVYaUs0N25UQ2Z3dXcrMmx4N1YrcnU2Q0ti?=
 =?utf-8?B?N3lNT1hyc25qbEpOczlIaC9pRzB2RlI2ancwb3UwbG5sRWJSUHd1VWJHb25G?=
 =?utf-8?B?bnVUZm5TbGpNczhnQ3I3d3J4dS9YZENsTEY2ZURiSjI0MHhDUTVHSGdNeVVH?=
 =?utf-8?B?NG1HRzIzL1k1bUNuQVJNQUVSQ3M2Z0crMFlmUDROVUlaOHAxMWROS2RKSk9W?=
 =?utf-8?B?UDREMDdFOGlJK0Z4UFNzdXEyaVdSdEtlK1pwem53TXQwTTdIaWlScm13QXBL?=
 =?utf-8?B?eFZYbUxTYmlZeHpBU0R3K1BUQm1CbEUwNDNtOW5YajhEa20vLy9xK3A0bzht?=
 =?utf-8?B?WUVvMlkvVTA1QnpONHJOU0Uvd0lYV0ZJSmVFdCs0M1IzcURxbk14cHRqVEoz?=
 =?utf-8?B?cjNQNGJqVHVFZ2xETkVVM1R6Nmxzb013SWJ5ZDhTQkZpSjBielhZNm9hVTgz?=
 =?utf-8?B?RlpNd0tGdGp0Q2pTS1VyN0Uzd3grUml2K010Qk5TNVlnclI2MkxYWis2SnNu?=
 =?utf-8?B?c3lsSXFONkRQdEJXbVNvUnRodmRka0tDU09xZXZFVG5lN1NPdElXdkNTL2lQ?=
 =?utf-8?B?QmF3QzZnWHJtSlc3V2RmNlFsV3VUSnJYZjZSbC9ZWVVlTFVzWllYUS81YTNh?=
 =?utf-8?B?WU4rNkpDcHg4bXdiUEFHYlZHMkJ5T1FyRjlNVjVoSi81OFRFeVVSSzNoMXBv?=
 =?utf-8?B?S0RMb1F6MG82c1E0azBQY0FKaWhiYzN1NVdDM2RMUndvTEdtdnUyRXp2QjFG?=
 =?utf-8?B?RHZ1dkxaWnZVdXRTUjlybUFNcEY3MzBNSDNDcjRxbWtmQk90QTV5UkhMZEN6?=
 =?utf-8?B?L2NTSzJyTjNUaU1DVkt4eTdKNkIxd1k2TGVXb1Vvc2xUVXY5bE9ycGlCWmdZ?=
 =?utf-8?B?UFdJd21XMStqbnhKSDlwU1Q2ckNadVUweGcvNzk1ZmVsa3A3ZkVzV0hCRnp2?=
 =?utf-8?B?cWYyNW5YYXlabGJSYk1yZEFEaEV0VHUvdmpCOU9VaEpvc1I4TmVtb0F5T2NF?=
 =?utf-8?B?WUp5QlFkc3FhVkVyRGlWbjVpNE5rUTArbzlWMER0b3VzNldsaGErem5CbG81?=
 =?utf-8?B?LzJOdk1xT1IzQVZoQnZacjZBRnFkWGk2WHZRRyt1OTN0OWEybU9iVnJ5OUdL?=
 =?utf-8?B?bWNaRURMSldtNkI0MkR2QkJETFB2YlVoRzJUVlVzWEI0a3ptaHVqdTdXS3cz?=
 =?utf-8?B?SVhOeFArNDdFdDU0SVJiV0I5cWZuNWFrQS9QWk1IbEFFSXRJK05hYjNKc1ox?=
 =?utf-8?B?S3Mxam85TEw3OHlVbjhQNjJEaWEwVHRab2xNRFB1MnhxRXR0em9Hb3o5bS9y?=
 =?utf-8?B?Z3VneDNLUUVEMnV0dnJxelBvWE9CekEyM3JXVGw1dndYUjV4ZHA0TGdnRXFL?=
 =?utf-8?B?bnNPK0tyYXFpZ05BZkkxU2FlMy9PSlhoREc5T25yMTJoU1hZTzRDUi9sQVNw?=
 =?utf-8?B?SDFDam8wdDhXeUJLVzJ5R3RrUFBmZVRueU1hbEJhUVFNWlE9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fefbcf3-a496-411a-2aa3-08d91abac4ed
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 11:39:32.1171 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cu0UrFvUEFYXshc0eeTy99LdKJRYI3ZfPyd5yT4vRnnrvTJqzLiQIz82R4RZORM9lKdAKDGZo3hCSzSNHK4D+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4720
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpPbiAyMDIxLTA1LTE3IDY6NTUgYS5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAx
Ny4wNS4yMSB1bSAxMjo1MiBzY2hyaWViIExhbmcgWXU6Cj4+IFdoZW4gYW1kZ3B1X2liX3Jpbmdf
dGVzdHMgZmFpbGVkLCB0aGUgcmVzZXQgbG9naWMgY2FsbGVkCj4+IGFtZGdwdV9kZXZpY2VfaXBf
c3VzcGVuZCB0d2ljZSwgdGhlbiBkZWFkbG9jayBvY2N1cnJlZC4KPj4KPj4gRGVhZGxvY2sgbG9n
Ogo+PiBbwqAgODA1LjY1NTE5Ml0gYW1kZ3B1IDAwMDA6MDQ6MDAuMDogYW1kZ3B1OiBpYiByaW5n
IHRlc3QgZmFpbGVkICgtMTEwKS4KPj4gW8KgIDgwNi4wMTE1NzFdIFtkcm1dIFJlZ2lzdGVyKDAp
IFttbVVWRF9QT1dFUl9TVEFUVVNdIGZhaWxlZCB0byByZWFjaCAKPj4gdmFsdWUgMHgwMDAwMDAw
MSAhPSAweDAwMDAwMDAyCj4+IFvCoCA4MDYuMjgwMTM5XSBbZHJtXSBSZWdpc3RlcigwKSBbbW1V
VkRfUE9XRVJfU1RBVFVTXSBmYWlsZWQgdG8gcmVhY2ggCj4+IHZhbHVlIDB4MDAwMDAwMDEgIT0g
MHgwMDAwMDAwMgo+PiBbwqAgODA2LjI5MDk1Ml0gW2RybV0gZnJlZSBQU1AgVE1SIGJ1ZmZlcgo+
Pgo+PiBbwqAgODA2LjMxOTQwNl0gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0KPj4gW8KgIDgwNi4zMjAzMTVdIFdBUk5JTkc6IHBvc3NpYmxlIHJlY3Vyc2l2ZSBs
b2NraW5nIGRldGVjdGVkCj4+IFvCoCA4MDYuMzIxMjI1XSA1LjExLjAtY3VzdG9tICMxIFRhaW50
ZWQ6IEfCoMKgwqDCoMKgwqDCoCBXwqAgT0VMCj4+IFvCoCA4MDYuMzIyMTM1XSAtLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+PiBbwqAgODA2LjMyMzA0M10gY2F0
LzI1OTMgaXMgdHJ5aW5nIHRvIGFjcXVpcmUgbG9jazoKPj4gW8KgIDgwNi4zMjM4MjVdIGZmZmY4
ODgxMzZiMWNkYzggKCZhZGV2LT5kbS5kY19sb2NrKXsrLisufS17MzozfSwgYXQ6IAo+PiBkbV9z
dXNwZW5kKzB4YjgvMHgxZDAgW2FtZGdwdV0KPj4gW8KgIDgwNi4zMjU2NjhdCj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBidXQgdGFzayBpcyBhbHJlYWR5IGhvbGRpbmcgbG9jazoK
Pj4gW8KgIDgwNi4zMjY2NjRdIGZmZmY4ODgxMzZiMWNkYzggKCZhZGV2LT5kbS5kY19sb2NrKXsr
LisufS17MzozfSwgYXQ6IAo+PiBkbV9zdXNwZW5kKzB4YjgvMHgxZDAgW2FtZGdwdV0KPj4gW8Kg
IDgwNi4zMjg0MzBdCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBvdGhlciBpbmZv
IHRoYXQgbWlnaHQgaGVscCB1cyBkZWJ1ZyB0aGlzOgo+PiBbwqAgODA2LjMyOTUzOV3CoCBQb3Nz
aWJsZSB1bnNhZmUgbG9ja2luZyBzY2VuYXJpbzoKPj4KPj4gW8KgIDgwNi4zMzA1NDldwqDCoMKg
wqDCoMKgwqAgQ1BVMAo+PiBbwqAgODA2LjMzMDk4M13CoMKgwqDCoMKgwqDCoCAtLS0tCj4+IFvC
oCA4MDYuMzMxNDE2XcKgwqAgbG9jaygmYWRldi0+ZG0uZGNfbG9jayk7Cj4+IFvCoCA4MDYuMzMy
MDg2XcKgwqAgbG9jaygmYWRldi0+ZG0uZGNfbG9jayk7Cj4+IFvCoCA4MDYuMzMyNzM4XQo+PiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqKiogREVBRExPQ0sgKioqCj4+Cj4+IFvC
oCA4MDYuMzMzNzQ3XcKgIE1heSBiZSBkdWUgdG8gbWlzc2luZyBsb2NrIG5lc3Rpbmcgbm90YXRp
b24KPj4KPj4gW8KgIDgwNi4zMzQ4OTldIDMgbG9ja3MgaGVsZCBieSBjYXQvMjU5MzoKPj4gW8Kg
IDgwNi4zMzU1MzddwqAgIzA6IGZmZmY4ODgxMDBkM2YxYjggKCZhdHRyLT5tdXRleCl7Ky4rLn0t
ezM6M30sIGF0OiAKPj4gc2ltcGxlX2F0dHJfcmVhZCsweDRlLzB4MTEwCj4+IFvCoCA4MDYuMzM3
MDA5XcKgICMxOiBmZmZmODg4MTM2YjFmZDc4ICgmYWRldi0+cmVzZXRfc2VtKXsrKysrfS17Mzoz
fSwgCj4+IGF0OiBhbWRncHVfZGV2aWNlX2xvY2tfYWRldisweDQyLzB4OTQgW2FtZGdwdV0KPj4g
W8KgIDgwNi4zMzkwMThdwqAgIzI6IGZmZmY4ODgxMzZiMWNkYzggKCZhZGV2LT5kbS5kY19sb2Nr
KXsrLisufS17MzozfSwgCj4+IGF0OiBkbV9zdXNwZW5kKzB4YjgvMHgxZDAgW2FtZGdwdV0KPj4g
W8KgIDgwNi4zNDA4NjldCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdGFjayBi
YWNrdHJhY2U6Cj4+IFvCoCA4MDYuMzQxNjIxXSBDUFU6IDYgUElEOiAyNTkzIENvbW06IGNhdCBU
YWludGVkOiBHwqDCoMKgwqDCoMKgwqAgV8KgIE9FTCAgICAKPj4gNS4xMS4wLWN1c3RvbSAjMQo+
PiBbwqAgODA2LjM0MjkyMV0gSGFyZHdhcmUgbmFtZTogQU1EIENlbGFkb24tQ1pOL0NlbGFkb24t
Q1pOLCBCSU9TIAo+PiBXTEQwQzIzTl9XZWVrbHlfMjBfMTJfMiAxMi8yMy8yMDIwCj4+IFvCoCA4
MDYuMzQ0NDEzXSBDYWxsIFRyYWNlOgo+PiBbwqAgODA2LjM0NDg0OV3CoCBkdW1wX3N0YWNrKzB4
OTMvMHhiZAo+PiBbwqAgODA2LjM0NTQzNV3CoCBfX2xvY2tfYWNxdWlyZS5jb2xkKzB4MThhLzB4
MmNmCj4+IFvCoCA4MDYuMzQ2MTc5XcKgIGxvY2tfYWNxdWlyZSsweGNhLzB4MzkwCj4+IFvCoCA4
MDYuMzQ2ODA3XcKgID8gZG1fc3VzcGVuZCsweGI4LzB4MWQwIFthbWRncHVdCj4+IFvCoCA4MDYu
MzQ3ODEzXcKgIF9fbXV0ZXhfbG9jaysweDliLzB4OTMwCj4+IFvCoCA4MDYuMzQ4NDU0XcKgID8g
ZG1fc3VzcGVuZCsweGI4LzB4MWQwIFthbWRncHVdCj4+IFvCoCA4MDYuMzQ5NDM0XcKgID8gYW1k
Z3B1X2RldmljZV9pbmRpcmVjdF9ycmVnKzB4NTgvMHg3MCBbYW1kZ3B1XQo+PiBbwqAgODA2LjM1
MDU4MV3CoCA/IF9yYXdfc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSsweDQ3LzB4NTAKPj4gW8KgIDgw
Ni4zNTE0MzddwqAgPyBkbV9zdXNwZW5kKzB4YjgvMHgxZDAgW2FtZGdwdV0KPj4gW8KgIDgwNi4z
NTI0MzddwqAgPyByY3VfcmVhZF9sb2NrX3NjaGVkX2hlbGQrMHg0Zi8weDgwCj4+IFvCoCA4MDYu
MzUzMjUyXcKgID8gcmN1X3JlYWRfbG9ja19zY2hlZF9oZWxkKzB4NGYvMHg4MAo+PiBbwqAgODA2
LjM1NDA2NF3CoCBtdXRleF9sb2NrX25lc3RlZCsweDFiLzB4MjAKPj4gW8KgIDgwNi4zNTQ3NDdd
wqAgPyBtdXRleF9sb2NrX25lc3RlZCsweDFiLzB4MjAKPj4gW8KgIDgwNi4zNTU0NTddwqAgZG1f
c3VzcGVuZCsweGI4LzB4MWQwIFthbWRncHVdCj4+IFvCoCA4MDYuMzU2NDI3XcKgID8gc29jMTVf
Y29tbW9uX3NldF9jbG9ja2dhdGluZ19zdGF0ZSsweDE3ZC8weDE5IFthbWRncHVdCj4+IFvCoCA4
MDYuMzU3NzM2XcKgIGFtZGdwdV9kZXZpY2VfaXBfc3VzcGVuZF9waGFzZTErMHg3OC8weGQwIFth
bWRncHVdCj4+IFvCoCA4MDYuMzYwMzk0XcKgIGFtZGdwdV9kZXZpY2VfaXBfc3VzcGVuZCsweDIx
LzB4NzAgW2FtZGdwdV0KPj4gW8KgIDgwNi4zNjI5MjZdwqAgYW1kZ3B1X2RldmljZV9wcmVfYXNp
Y19yZXNldCsweGIzLzB4MjcwIFthbWRncHVdCj4+IFvCoCA4MDYuMzY1NTYwXcKgIGFtZGdwdV9k
ZXZpY2VfZ3B1X3JlY292ZXIuY29sZCsweDY3OS8weDhlYiBbYW1kZ3B1XQo+PiBbwqAgODA2LjM2
ODMzMV3CoCA/IF9fcG1fcnVudGltZV9yZXN1bWUrMHg2MC8weDgwCj4+IFvCoCA4MDYuMzcwNTA5
XcKgIGdwdV9yZWNvdmVyX2dldCsweDJlLzB4NjAgW2FtZGdwdV0KPj4gW8KgIDgwNi4zNzI4ODdd
wqAgc2ltcGxlX2F0dHJfcmVhZCsweDZkLzB4MTEwCj4+IFvCoCA4MDYuMzc0OTY2XcKgIGRlYnVn
ZnNfYXR0cl9yZWFkKzB4NDkvMHg3MAo+PiBbwqAgODA2LjM3NzA0Nl3CoCBmdWxsX3Byb3h5X3Jl
YWQrMHg1Zi8weDkwCj4+IFvCoCA4MDYuMzc5MDU0XcKgIHZmc19yZWFkKzB4YTMvMHgxOTAKPj4g
W8KgIDgwNi4zODA5NjldwqAga3N5c19yZWFkKzB4NzAvMHhmMAo+PiBbwqAgODA2LjM4MjgzM13C
oCBfX3g2NF9zeXNfcmVhZCsweDFhLzB4MjAKPj4gW8KgIDgwNi4zODQ4MDNdwqAgZG9fc3lzY2Fs
bF82NCsweDM4LzB4OTAKPj4gW8KgIDgwNi4zODY3NDNdwqAgZW50cnlfU1lTQ0FMTF82NF9hZnRl
cl9od2ZyYW1lKzB4NDQvMHhhOQo+PiBbwqAgODA2LjM4ODk0Nl0gUklQOiAwMDMzOjB4N2ZiMDg0
ZWExMTQyCj4+IFvCoCA4MDYuMzkwOTE0XSBDb2RlOiBjMCBlOSBjMiBmZSBmZiBmZiA1MCA0OCA4
ZCAzZCAzYSBjYSAwYSAwMCBlOCBmNSAKPj4gMTkgMDIgMDAgMGYgMWYgNDQgMDAgMDAgZjMgMGYg
MWUgZmEgNjQgOGIgMDQgMjUgMTggMDAgMDAgMDAgODUgYzAgNzUgCj4+IDEwIDBmIDA1IDw0OD4g
M2QgMDAgZjAgZmYgZmYgNzcgNTYgYzMgMGYgMWYgNDQgMDAgMDAgNDggODMgZWMgMjggNDggODkg
Cj4+IDU0IDI0Cj4+IFvCoCA4MDYuMzk1NDk2XSBSU1A6IDAwMmI6MDAwMDdmZmZkZTUwZWUwOCBF
RkxBR1M6IDAwMDAwMjQ2IE9SSUdfUkFYOiAKPj4gMDAwMDAwMDAwMDAwMDAwMAo+PiBbwqAgODA2
LjM5ODI5OF0gUkFYOiBmZmZmZmZmZmZmZmZmZmRhIFJCWDogMDAwMDAwMDAwMDAyMDAwMCBSQ1g6
IAo+PiAwMDAwN2ZiMDg0ZWExMTQyCj4+IFvCoCA4MDYuNDAxMDYzXSBSRFg6IDAwMDAwMDAwMDAw
MjAwMDAgUlNJOiAwMDAwN2ZiMDg0NGZmMDAwIFJESTogCj4+IDAwMDAwMDAwMDAwMDAwMDMKPj4g
W8KgIDgwNi40MDM3OTNdIFJCUDogMDAwMDdmYjA4NDRmZjAwMCBSMDg6IDAwMDA3ZmIwODQ0ZmUw
MTAgUjA5OiAKPj4gMDAwMDAwMDAwMDAwMDAwMAo+PiBbwqAgODA2LjQwNjUxNl0gUjEwOiAwMDAw
MDAwMDAwMDAwMDIyIFIxMTogMDAwMDAwMDAwMDAwMDI0NiBSMTI6IAo+PiAwMDAwNTU1ZDNkM2I1
MWYwCj4+IFvCoCA4MDYuNDA5MjQ2XSBSMTM6IDAwMDAwMDAwMDAwMDAwMDMgUjE0OiAwMDAwMDAw
MDAwMDIwMDAwIFIxNTogCj4+IDAwMDAwMDAwMDAwMjAwMDAKPiAKPiBJIHRoaW5rIHdlIHNob3Vs
ZCBzaG9ydGVuIHRoZSBiYWNrdHJhY2UgaGVyZSBhIGJpdC4KPiAKPj4KPj4gU2lnbmVkLW9mZi1i
eTogTGFuZyBZdSA8TGFuZy5ZdUBhbWQuY29tPgo+IAo+IExvb2tzIHNhbmUgdG8gbWUsIGJ1dCBB
bmRyZXkgc2hvdWxkIHByb2JhYmx5IGFsc28gdGFrZSBhIGxvb2suCj4gCj4gQWNrZWQtYnk6IENo
cmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KClllcywgc2VlbXMgbGlr
ZSBhIHR5cG8uLi4KClJldmlld2VkLWJ5OiBBbmRyZXkgR3JvZHpvdnNreSBhbmRyZXkuZ3JvZHpv
dnNreUBhbWQuY29tCgpBbmRyZXkKCgo+IAo+PiAtLS0KPj4gwqAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgMSAtCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGRl
bGV0aW9uKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZGV2aWNlLmMgCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rl
dmljZS5jCj4+IGluZGV4IDdjNmM0MzVlNWQwMi4uZmYzNDExNTQzOTRlIDEwMDY0NAo+PiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCj4+IEBAIC00NDc2LDcgKzQ0
NzYsNiBAQCBpbnQgYW1kZ3B1X2RvX2FzaWNfcmVzZXQoc3RydWN0IGxpc3RfaGVhZCAKPj4gKmRl
dmljZV9saXN0X2hhbmRsZSwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgciA9IGFtZGdw
dV9pYl9yaW5nX3Rlc3RzKHRtcF9hZGV2KTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aWYgKHIpIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfZXJyKHRt
cF9hZGV2LT5kZXYsICJpYiByaW5nIHRlc3QgZmFpbGVkIAo+PiAoJWQpLlxuIiwgcik7Cj4+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgciA9IGFtZGdwdV9kZXZpY2VfaXBfc3VzcGVu
ZCh0bXBfYWRldik7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmVlZF9m
dWxsX3Jlc2V0ID0gdHJ1ZTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBy
ID0gLUVBR0FJTjsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVu
ZDsKPiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
