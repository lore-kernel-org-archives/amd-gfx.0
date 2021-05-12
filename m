Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF630C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 20:38:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F5B361168
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 20:38:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F5B361168
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 121A26ECDF;
	Wed, 12 May 2021 20:38:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77BC36E50B;
 Wed, 12 May 2021 20:38:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPviHPh5oE/r2EaPpevpVZ10bMI96bE0kwAHyguhiPKhVFNZP4MlsNyCsE+meVz+JJ5b1XH30RA7dJ1uf3CzHH1ERcua1HJnAzZnMK0eQ/+FytO75GzLLU+CQgv2110uCFjJFVxbHJD6BeBWXuS6g60pof5HIt1OsE1bcW+xbn9wP1QaK2hEWH2lD62XjCGeWR8U15A/df0DIE0EcJolk1z78eVoARb2Qo6P7ftRQjo9dnokyvr2wkhYw3mKw36puTtfyRrgeRhvt4PkJAIO1ME4ljhtijbcoo9jSJlJVefkgwv5H9WMuPFwYJBiXmyW7G2l9qbV1l3xHsPAaOKLKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKlgjTnyV25BjTSARJfnvSzOT3450XEOaEKVfXKgy4E=;
 b=Q+NN8wlOGOSyK+/wzwqztlwcDkEf19PviS4P01yhamOWV02HItYssbvvuK/jLLDapaRfLdkO8VIx3knzjktATgFRYEhp3S78AHPnrfhOMdwwht9AQC4CixxgGvspV062S8bQfHRzvB/EwrNiOzyJ5A3lTu4DeoXD5x98BEuc0LcO0NxvrPpcQydHw3VTpaA3f6DWXtBPTDGsQ1Vc38RKXRESfo3IlZtk+/6C3WLp1dFmm64VhEewb0xg9P3wnQWWC5MzwoFPZ+5vU6aydYnMy7FxCQ/2K2gv130dlFlkLmLYFNfohlw44QwUqywJSWdsdaEslifsUdBaHBPWVxyNdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKlgjTnyV25BjTSARJfnvSzOT3450XEOaEKVfXKgy4E=;
 b=elV9aY3W/7fhXx5jkb4XdvlJDvMMYk326E7jkT23YUB+xyaDN2g61FvVfxR51+mD/VtqZyp3upxyBk5DmHYSXUpetLFsNt14SP+t+5yz15GyrYXsE6pI98IbfwsxliW6NQ0RR55IvBnrUCWr4HzOEWjlqEAT+c6oGXf655nfHEg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB2751.namprd12.prod.outlook.com (2603:10b6:805:6c::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 12 May
 2021 20:38:10 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c%7]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 20:38:10 +0000
Subject: Re: [PATCH v7 03/16] drm/amdkfd: Split kfd suspend from device exit
To: Felix Kuehling <felix.kuehling@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org,
 ckoenig.leichtzumerken@gmail.com, daniel.vetter@ffwll.ch,
 Harry.Wentland@amd.com
References: <20210512142648.666476-1-andrey.grodzovsky@amd.com>
 <20210512142648.666476-4-andrey.grodzovsky@amd.com>
 <d17c82ae-ce00-9496-b2ed-8761814f51fe@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <1bd1f32b-2705-b08c-2998-196a34fee7de@amd.com>
Date: Wed, 12 May 2021 16:38:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <d17c82ae-ce00-9496-b2ed-8761814f51fe@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:3876:5646:9034:63b2]
X-ClientProxiedBy: YT1PR01CA0073.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::12) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:3876:5646:9034:63b2]
 (2607:fea8:3edf:49b0:3876:5646:9034:63b2) by
 YT1PR01CA0073.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Wed, 12 May 2021 20:38:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd329df1-cab5-4f7a-4563-08d91585db5e
X-MS-TrafficTypeDiagnostic: SN6PR12MB2751:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB27517491B7C9F82BF5A706D3EA529@SN6PR12MB2751.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d9GaA+dKlXx8oq3t/+TqilpIbBPIWz8s32071wf3Y9GgQ/75aVLu7LmhHi4TDzbgITmD1qguvtdS1m2A/9y/I0smMgX11dvK/eOgudRcSzuTprSVopsRBxip8PemBIo1eGjWHw7yO0OJXiVogamdV9EXmlITFupk4g/3ccY6Rs1cpCU83JS9tHzz/EqhE6a16Y6O08YEryMzXR1ZNmsrWggbpD1vs78Zkfw0xF10TM80Wp3v8GNxJTLXyxMkHajLU+UGofx6X9Iw5j8YRdwQMpa0/5UU+VeCzszZRmqMORWL9Sr9xlXErw60vY/Yc7MtX1vCJAzXO0KBV4ct+hzTBDnJuIJhr64afVzmSCWn5HhiOeH2qEEd2+t9c48IHqQIIBfDo60cEtikKG+9psstk3YifP8LfM6g3s8bnw2C7m/Xu8r9po9HyKBU1Ae2weHZ6gtFvLv7mp5Iq7j7Y3XUanzZKF66Yyj9QOZfHu8B6CBmyLXKshAdOjPXEYPD/sdaNd3BbRfN4LrrvlT5ted3emQlNy2LxAKd2EVzRHAf6jzXWDePofDDc4LSkfy+VeDC8UN+5yhSGKT0AhLHn3R5e9M+hjU/mtQtiotKLY5liblBGLts9570iMjqbhVC00WK+MNoZqn0jrk5PhVCHljDtHxxJrgSLoNOPvRvca3WY5ix1l5bcCw/y0+qL2BGDK64
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(44832011)(2906002)(186003)(53546011)(83380400001)(36756003)(6636002)(5660300002)(66946007)(2616005)(4326008)(16526019)(66476007)(52116002)(86362001)(31696002)(8676002)(66556008)(31686004)(478600001)(8936002)(316002)(38100700002)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MzBPWSsxWWxMTGRDUHIwWkFFdTVhRUVlWmFmWklnUEYwVFVONEQzbndoOHhk?=
 =?utf-8?B?dmFLcXg0UkZoWS8rKzZObjE1eWZMbUJpc0ZmaVNvS1o2MmFISFhYbzdYa3lw?=
 =?utf-8?B?Y3prTXg0cXdTNDZFVExBTzZHeGFDVVovd2lNWk0vaElqaXhVSUNUMUNBTjgr?=
 =?utf-8?B?UUhJeEp2a3dMVGRDZ3h5RlJpZ1dpSzlxejA5U2RJQ21EM0E3Yy9yV0cwSHhC?=
 =?utf-8?B?alhMT3FadUxQTXpzdTRSdjJrOXp0UEFrQ0lhYXZDN0hsV0FvMHhwOEVOWmc2?=
 =?utf-8?B?YWtkZTllT0hLNzVBSFhRMm1wZURHb0N1N1pDTXBmd3h5NkN4M0FSTW1sQkhv?=
 =?utf-8?B?M0lsU0ZUQlhhSHJsVEowQ281d0ZEbTJlQ1pYTDNsYkRJcDdlbXl5YmpBdzBa?=
 =?utf-8?B?TlFxOHZGR3lYNklwSVZ0TVU3bEoxS21sM0xIek8zUlBWTFRxZUxoRUp1Ukwy?=
 =?utf-8?B?eWlmS1hlSVZpUllWZzM2aEpHV1M0UzdmTFJJWVVuaDJFSG85cTl1K09vN1R1?=
 =?utf-8?B?bHBBTnZHLzY3RDJCQ1g0cUdJdVFvUFBNc0tBd0QvZnRLY0JHNmRmK1d2YkNi?=
 =?utf-8?B?SW5LVzFWTW1WcVR5TllaMVhyRE5hUFExVkhFNDhLbWtabnhxVjRRWFNuM2Jn?=
 =?utf-8?B?YmF6S2cvczgxR2ZDMFNHTHVRaFl3QnpXZ1RLRDFIZk0zS1dIVENzRWRIcjNJ?=
 =?utf-8?B?ZC8zVW9mNE02aWpYZlMxdGRuUmp6bThnQXpRNEhSaTZaOUdoYXhGRWhjM3F0?=
 =?utf-8?B?eE1DVWFJa25HMEIzV2JJS3J3L2I4cjFmcFUvTVVjNXJNaHowakNYR1NjZ0xL?=
 =?utf-8?B?UWVqa01xbXlxY2JvaUJmZVNJS1p2S1M4b0ZxZE5pK0JKMHM4M0ZpMFdXUkZG?=
 =?utf-8?B?Y0IvOFFkdllNUnpDL2lnN2UrN0tyYXVoSTRndXlaNlh2bTh6VStlWkFBS2pn?=
 =?utf-8?B?aG5Kd0U2OW0zYmhTeVRCN0ZjM05VYXdQSXdOL25UUm5pdys4UzVaT2hQWmN5?=
 =?utf-8?B?USthOUw1STU2akhkUDNCYTFsaFV1LzBMZTNDTlNyV09KMk9wS0ZzcUM3M0Jl?=
 =?utf-8?B?WENyVlRURUtxdXcyUGRycmdtWHBLN2h5cHFyb05jNkFkNVlnN283bWtzMGxP?=
 =?utf-8?B?bStiUm50MWM0VnNaZTBwelNoN2NrMk5ST20vNXpLZW4yNlFXT29vRnkxM1R3?=
 =?utf-8?B?MTcwQmZyWGltTXlvQ2Npc2M0bG1LSTJ3bGdHTTRwMDFvMTdvdmxyTE1zYlBO?=
 =?utf-8?B?dTZCVklBR21qZjhVcGlBZ2JaZE1SMW1aeGhSbU5SYm1UNEFwd0FueVFXalRQ?=
 =?utf-8?B?Zk1raVA3c0pXKzZmT2Z6cWk3dUczRVVtdWplMWdQcUVGbzFkNTkxS1lVYWl6?=
 =?utf-8?B?Z3lHcjBWQ2pCV0w3YUIvZ3hjVW1vcjcvQzdUMFZZekZKc01LZkw5cVJ1V3FF?=
 =?utf-8?B?SUE2a281eTIyR1ZZYk1nNVpBOEl0eDc2QTk4VDY4NEV1Vk12clhEd3Jqa3hh?=
 =?utf-8?B?dm1tMkpNWTBva1BWVXVlQlJEMXBlVzlHKzEwOElYeEJ0RW0yd1kyTHJESTQz?=
 =?utf-8?B?Q0k0L2htOTY4L1d1MCs0U1Uray9IendCUk1MbHB3aGRncFFHVXdqM1d0WFk3?=
 =?utf-8?B?VVNoYWZFODA1aUppWURnelVQZG9nOFY1and5b1o0emlrQmIzSHIzUjlvWmlK?=
 =?utf-8?B?YWxJcC8ydWdLNTdKQzJXRDVkRjh1aUI5RTVaZ2I0QzVaRXVBSVk3V1EzK0Y2?=
 =?utf-8?B?ZWxvMmVGMGNkTG5xYTFlMW4rQWJkZW0ycnRQSDhWd1JVZndKUjhIaEptakQx?=
 =?utf-8?B?WnMvb3ZpOXBoZEl1WjdkSUpKWnY5NURlZUFjbGx6WU5VK1BySy9PSDJQNVBL?=
 =?utf-8?B?WFZsZG9sZDBzQy8zM3UzL3N0RTBZL1J3SSs3YUhxeEJ1Z3c9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd329df1-cab5-4f7a-4563-08d91585db5e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 20:38:10.7746 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UakmWNtBOaKm0n3b49dgL2rnqekvIOs80f0JrNj9naZjW9ZA0pWQadwNdyB8TBzQZa/ZvgOB65cJtNlm/yKU6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2751
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
Cc: Alexander.Deucher@amd.com, gregkh@linuxfoundation.org, ppaalanen@gmail.com,
 helgaas@kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpPbiAyMDIxLTA1LTEyIDQ6MzMgcC5tLiwgRmVsaXggS3VlaGxpbmcgd3JvdGU6Cj4gQW0gMjAy
MS0wNS0xMiB1bSAxMDoyNiBhLm0uIHNjaHJpZWIgQW5kcmV5IEdyb2R6b3Zza3k6Cj4+IEhlbHBz
IHRvIGV4cGRpdGUgSFcgcmVsYXRlZCBzdHVmZiB0byBhbWRncHVfcGNpX3JlbW92ZQo+Pgo+PiBT
aWduZWQtb2ZmLWJ5OiBBbmRyZXkgR3JvZHpvdnNreSA8YW5kcmV5Lmdyb2R6b3Zza3lAYW1kLmNv
bT4KPj4gLS0tCj4+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5j
IHwgMiArLQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuaCB8
IDIgKy0KPj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlLmMgICAgfCAz
ICsrLQo+PiAgIDMgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygt
KQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Ft
ZGtmZC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jCj4+IGlu
ZGV4IDVmNjY5NmEzYzc3OC4uMmIwNmRlZTlhMGNlIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jCj4+IEBAIC0xNzAsNyArMTcwLDcgQEAgdm9pZCBh
bWRncHVfYW1ka2ZkX2RldmljZV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+PiAg
IAl9Cj4+ICAgfQo+PiAgIAo+PiAtdm9pZCBhbWRncHVfYW1ka2ZkX2RldmljZV9maW5pKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2KQo+PiArdm9pZCBhbWRncHVfYW1ka2ZkX2RldmljZV9maW5p
X3N3KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+IAo+IFlvdSdyZSByZW5hbWluZyB0aGlz
IGZ1bmN0aW9uLCBidXQgSSBkb24ndCBzZWUgeW91IGZpeGluZyB1cCBhbnkgb2YgdGhlCj4gY2Fs
bGVycy4gTG9va3MgbGlrZSB5b3UgZG8gdGhhdCBpbiB0aGUgbmV4dCBwYXRjaC4gU28gdGhpcyBw
YXRjaCBicmVha3MKPiB0aGUgYnVpbGQsIHRoZSBuZXh0IG9uZSBmaXhlcyBpdC4gTWF5YmUgeW91
IG5lZWQgdG8gcmVmYWN0b3IgdGhpcyBvcgo+IGp1c3Qgc3F1YXNoIHRoZSB0d28gcGF0Y2hlcy4K
CldpbGwgZG8uCgpBbmRyZXkKCj4gCj4gUmVnYXJkcywKPiAgwqAgRmVsaXgKPiAKPiAKPj4gICB7
Cj4+ICAgCWlmIChhZGV2LT5rZmQuZGV2KSB7Cj4+ICAgCQlrZ2Qya2ZkX2RldmljZV9leGl0KGFk
ZXYtPmtmZC5kZXYpOwo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2FtZGtmZC5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtm
ZC5oCj4+IGluZGV4IDE0ZjY4YzAyODEyNi4uZjhlMTBhZjk5YzI4IDEwMDY0NAo+PiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmgKPj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5oCj4+IEBAIC0xMjcsNyArMTI3LDcg
QEAgdm9pZCBhbWRncHVfYW1ka2ZkX2ludGVycnVwdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
diwKPj4gICAJCQljb25zdCB2b2lkICppaF9yaW5nX2VudHJ5KTsKPj4gICB2b2lkIGFtZGdwdV9h
bWRrZmRfZGV2aWNlX3Byb2JlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsKPj4gICB2b2lk
IGFtZGdwdV9hbWRrZmRfZGV2aWNlX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOwo+
PiAtdm9pZCBhbWRncHVfYW1ka2ZkX2RldmljZV9maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KTsKPj4gK3ZvaWQgYW1kZ3B1X2FtZGtmZF9kZXZpY2VfZmluaV9zdyhzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldik7Cj4+ICAgaW50IGFtZGdwdV9hbWRrZmRfc3VibWl0X2liKHN0cnVjdCBr
Z2RfZGV2ICprZ2QsIGVudW0ga2dkX2VuZ2luZV90eXBlIGVuZ2luZSwKPj4gICAJCQkJdWludDMy
X3Qgdm1pZCwgdWludDY0X3QgZ3B1X2FkZHIsCj4+ICAgCQkJCXVpbnQzMl90ICppYl9jbWQsIHVp
bnQzMl90IGliX2xlbik7Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlLmMK
Pj4gaW5kZXggMzU3YjliZjYyYTFjLi5hYjZkMmE0M2M5YTMgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2UuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlLmMKPj4gQEAgLTg1OCwxMCArODU4LDExIEBAIGJvb2wg
a2dkMmtmZF9kZXZpY2VfaW5pdChzdHJ1Y3Qga2ZkX2RldiAqa2ZkLAo+PiAgIAlyZXR1cm4ga2Zk
LT5pbml0X2NvbXBsZXRlOwo+PiAgIH0KPj4gICAKPj4gKwo+PiArCj4+ICAgdm9pZCBrZ2Qya2Zk
X2RldmljZV9leGl0KHN0cnVjdCBrZmRfZGV2ICprZmQpCj4+ICAgewo+PiAgIAlpZiAoa2ZkLT5p
bml0X2NvbXBsZXRlKSB7Cj4+IC0JCWtnZDJrZmRfc3VzcGVuZChrZmQsIGZhbHNlKTsKPj4gICAJ
CWRldmljZV9xdWV1ZV9tYW5hZ2VyX3VuaW5pdChrZmQtPmRxbSk7Cj4+ICAgCQlrZmRfaW50ZXJy
dXB0X2V4aXQoa2ZkKTsKPj4gICAJCWtmZF90b3BvbG9neV9yZW1vdmVfZGV2aWNlKGtmZCk7Cl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
