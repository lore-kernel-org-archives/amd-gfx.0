Return-Path: <SRS0=7vr2=CJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0924FC433E2
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 22:18:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C83CC20719
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 22:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gbokcRtg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C83CC20719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BE746E358;
	Mon, 31 Aug 2020 22:18:04 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A01D6E358
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2020 22:18:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfjHZndn/CLGsoV1UYvOxtz8AHhmClQ3TCrYz72BgReFUcX5s/+AVE/D3pGL3P2IKiBNL5P+jeYemA+yUL/NJ7Dcj5S0IgbPK6T7T2SGpKx3hf8wTU0OfEe1b0CdP/HoLS8mwEfOJRb4zFamkOuTslsiYWzbsxxw17vAFrXbIYX3VQK3mwpo4FiYEvH+AOQ2+fKSOVTnExS/ffctg6gyhNQo2rPBHFjYUIa5HWf22Ri0k3mYI9sq2kmfdoUev1LM8nPjpsG4AM1CUqb+tY89DFUg7Ntvbvq04qzirROZBMEvh/29cKAyK5p2NfYYLr3cUM7Oo1+9/cen/T2ydVxFjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcW8I8bkjqxogSgKC7+zAlYPnU3hNXex5OyU17tRids=;
 b=gRMCZDvZqV6uwIWbsbUYcF6tzt0RQtjQRzgZ+/KrRQlHwUIn9EoXp0g7j0MvYu8HSt70wAImJFHfBVCCzANhmRLK0Lpjav+ps99jOoSANYoix2H8K6ejnFHKkeuXYQ76Op4CPWc44KocA/ula01ahdjTss1zgjixeWMZGOWHavoC6NcsNrU42jTMyBaV1eudpqb7R5xhb4tG3s9slHblg1usRIHSnJkqZEEHP2hoaZT25z2afD2hCZ+UGDvZfQ+PoiZxtbTAabvfu3QyoMfePqfAf84kj59uyxilhzRVWzEsjAeEgPIkfW4bcdMcdVYkl/OdA2lLC3TbQssr0kHdxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcW8I8bkjqxogSgKC7+zAlYPnU3hNXex5OyU17tRids=;
 b=gbokcRtgh479JbwIlKAwbhssd5bYGaVpOb1CUSkPVgd/+OaKIYfAWNSqHMCFsLCiIcoFww6HgJtHDyXbtfTgqAt9nLcgbSMXlz36uGQlJAXFen5cx0RFK/0dZPoy+iw6vfTekftELkAQKa/MpyA26HTeFOOq5fuLAE5OYOEl0Ko=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1787.namprd12.prod.outlook.com (2603:10b6:3:113::12)
 by DM6PR12MB4369.namprd12.prod.outlook.com (2603:10b6:5:2a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Mon, 31 Aug
 2020 22:17:57 +0000
Received: from DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::fcaf:8267:b3d6:32ee]) by DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::fcaf:8267:b3d6:32ee%7]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 22:17:57 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: disable gpu-sched load balance for uvd
To: Alex Deucher <alexdeucher@gmail.com>
References: <20200831104553.10207-1-nirmoy.das@amd.com>
 <CADnq5_P=LUjg4GubYdFFSBM+aXpkxOJ6yoD_2iNLNMSe_Vyzrg@mail.gmail.com>
 <0162c712-a0cd-78ee-0e87-6a612a1e81cb@amd.com>
 <CADnq5_MMKrR=TMF=-YcUM60eJO=osVB9N=H+hM93Pak=VXLBvA@mail.gmail.com>
 <00075962-70ba-a7b6-82d4-448b97ae5c99@amd.com>
 <CADnq5_NR8zY_aHPcZ39fGk_4-TFfWOPcHiT8wUCuxfjxYN=YNw@mail.gmail.com>
From: Leo Liu <leo.liu@amd.com>
Message-ID: <e66fad81-8de5-75ec-f2fb-bdc36282d422@amd.com>
Date: Mon, 31 Aug 2020 18:17:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CADnq5_NR8zY_aHPcZ39fGk_4-TFfWOPcHiT8wUCuxfjxYN=YNw@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0028.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::41) To DM5PR12MB1787.namprd12.prod.outlook.com
 (2603:10b6:3:113::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YTXPR0101CA0028.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Mon, 31 Aug 2020 22:17:56 +0000
X-Originating-IP: [2607:fea8:a3c0:203:ddeb:dd7b:1414:d938]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 83192f5b-243a-4eed-9c79-08d84dfbb6be
X-MS-TrafficTypeDiagnostic: DM6PR12MB4369:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB436920359610CBEEA708BAB5E5510@DM6PR12MB4369.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eUlhCpJrXkh7CLyVlv7XgCMukKrVXli843eUG0SfOpPyPsa0ZzHUZtN7TSA5lnYj6wqyHJJnYTAGVq8DeI3fsjkxiLIIi2UFHY2HpDLC7h16uKdqGdHr9NJxV5afxPuAxKr3XedDDQlmC0n1YRSsuGIYSP7QC8yviDdWpsiTVK7yUoY9tCjszpVSo1UTIBm5f4RId48jbQTjZafQqf87hP9qwvgaBCVFQsykDy9tHBEBuWVAEbJbOuMCSuI4ibgZ2t8th8AV//dt1prvePWypUfzmpoGvdpYoWE5QDJ2md5OZvjhjn3NnWhNOUxB9Mz76pqNuY5x+lLjty8q3pWVxsR8RM0YhgP1ljzvE6U1Aw/l1N7VuT+d3jGsi/XAirRJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1787.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(5660300002)(6486002)(66946007)(31696002)(2616005)(956004)(6916009)(316002)(52116002)(4326008)(54906003)(66556008)(86362001)(53546011)(16576012)(66476007)(31686004)(44832011)(8676002)(186003)(2906002)(36756003)(8936002)(478600001)(83380400001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: +ugR73Vw3UnLJryqPnw08jTXkF0NzhzfrXeI9ewVQdlRnZWX076NKQcFFbbp18lWZAjSi1UtFpKglCwkPX68duEMgfMBMF1ZS47g9uJfLW1gAqwcwnbtPTduQM0t+PPsJLIuRptmqTgIrthwrclscog5lXuuG2KlXDaLW8lPQmIJwyu6mxtgwMivWKoWR9Jvw6mFAFYlMYjOl8AORnb/FhExFciYblp4rRbFhCmhAZAguZ0kj/Jc1MBTrdkcGobDtfc2RaA/6zK8/N5j61EeNiHZNTFT5Au6WrO9XX5A4FWrzt1yXxD/VKOlcnMUbCVFIY0iuPIAzannEQH+oRj4liYIA1KpqfDT3RjcT2QTyZGcHRKNebdekhP8zX33dKzUeWfco2kJv1+CfncwxgGTgdSWMpO6DXtotSte5vDPDB9+fArw7AEhb49ANGtRTKxYnLMXjTAf3AmNBH9vgNQfxsILoF3xBbvKLp0zzHNnfExMlZnAbkabInz2b5/D+wu02HrVzDyiLR+NQvuWJtFG3OUeEOrYgtoiphgp8+veZMz9vmh2Z7AUhN5gCEy4UGrS0qkp5yarfqF26utZ1oKtIsGgUUlNVehDivIQvSa0Kcc9JIDsQf9sd2mlU1trU6ceyaGTst3ojuERpY4bS7wwN6A3We5rYWD+sJCN+/wL258+WP7bRZTM8H2UB6lB/rLDbeER0wLr5JPgQfCTMRCi3g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83192f5b-243a-4eed-9c79-08d84dfbb6be
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 22:17:57.2699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6h3jTTU06Hg1759la9O83wYPNkbpmX6NRIxB0jIqC9wZOnqeCVciDSSNCGiZIJUl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4369
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
Cc: Nirmoy <nirmodas@amd.com>, tiancyin <Tianci.Yin@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Nirmoy Das <nirmoy.das@amd.com>,
 "Deucher, Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDIwMjAtMDgtMzEgNTo1MyBwLm0uLCBBbGV4IERldWNoZXIgd3JvdGU6Cj4gT24gTW9uLCBB
dWcgMzEsIDIwMjAgYXQgNTo1MCBQTSBMZW8gTGl1IDxsZW8ubGl1QGFtZC5jb20+IHdyb3RlOgo+
Pgo+PiBPbiAyMDIwLTA4LTMxIDE6MzkgcC5tLiwgQWxleCBEZXVjaGVyIHdyb3RlOgo+Pj4gT24g
TW9uLCBBdWcgMzEsIDIwMjAgYXQgMTA6NTUgQU0gTmlybW95IDxuaXJtb2Rhc0BhbWQuY29tPiB3
cm90ZToKPj4+PiBIaSBBbGV4LAo+Pj4+Cj4+Pj4gT24gOC8zMS8yMCA0OjE3IFBNLCBBbGV4IERl
dWNoZXIgd3JvdGU6Cj4+Pj4+IE9uIE1vbiwgQXVnIDMxLCAyMDIwIGF0IDY6NDEgQU0gTmlybW95
IERhcyA8bmlybW95LmRhc0BhbWQuY29tPiB3cm90ZToKPj4+Pj4+IFVWRCBkZXBlbmRlbnQgam9i
cyBzaG91bGQgcnVuIG9uIHRoZSBzYW1lIHVkdiBpbnN0YW5jZS4KPj4+Pj4+IFRoaXMgcGF0Y2gg
ZGlzYWJsZXMgZ3B1IHNjaGVkdWxlcidzIGxvYWQgYmFsYW5jZXIgZm9yCj4+Pj4+PiBhIGNvbnRl
eHQgd2hpY2ggYmluZHMgam9icyBmcm9tIHNhbWUgdGhlIGNvbnRleHQgdG8gYSB1ZHYKPj4+Pj4+
IGluc3RhbmNlLgo+Pj4+PiB0eXBvczogdWR2IC0+IHV2ZAo+Pj4+PiBXaXRoIHRoYXQgZml4ZWQ6
Cj4+Pj4+IFJldmlld2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+Cj4+Pj4+Cj4+Pj4+IERvZXMgVkNFIG5lZWQgYSBzaW1pbGFyIGZpeD8gIFdoYXQgYWJvdXQg
VVZEX0VOQz8KPj4+PiBJIGFtIG5vdCBzdXJlLCBjYW4geW91IHBsZWFzZSBjb25maXJtIHRoaXMu
Cj4+PiBATGVvIExpdSBjYW4geW91IGNvbmZpcm0/Cj4+IFZlZ2EyMCBoYXZlIDIgVVZEcyBhbmQg
MSBWQ0UsIHNvIFVWRF9FTkMoQU1ER1BVX0hXX0lQX1VWRF9FTkMpIHNob3VsZAo+PiBuZWVkIHRo
ZSBzYW1lIGZpeC4KPiBXaGF0IGFib3V0IG90aGVyIGNoaXBzPyAgRGlkbid0IENaIGFuZCB0b25n
YSBoYXZlIHR3byBWQ0UgaW5zdGFuY2VzPwo+IEkgZ3Vlc3MgYW55IGVuZ2luZSB3aXRoIGh3IGNv
bnRleHRzIG5lZWRzIHRoaXMuCgpWZWdhMjDCoCAyIFVWRHMgYXJlIGlkZW50aWNhbCBhbmQgc2Vw
YXJhdGVkLCBleHBvc2VkIHNlcGFyYXRlZCBvd24gc2V0IG9mIApyaW5ncyB0byBkcml2ZXIsIGFu
ZCBoYXZlIHRoZWlyIG93biBzY2hlZHVsZXIuCgpGb3IgQ1ogYW5kIFRvbmdhLCBpdCBnb3QgMiBW
Q0UgaW5zdGFuY2VzIGludGVybmFsbHksIGFuZCBqdXN0IGV4cG9zZSBvbmUgCnNldCBvZiByaW5n
cyB0byBkcml2ZXIuIGkuZSB0aGUgaW5zdGFuY2VzIHdpbGwgcmVjZWl2ZSB0aGUgSUIgdGhydSB0
aGUgCnNhbWUgcmluZywgYW5kIGRpZmZlcmVudCBJQiBzdHJ1Y3R1cmVzIHdpbGwgZGVjaWRlIHRo
YXQgb25lIGluc3RhbmNlIG9yIAp0d28gaW5zdGFuY2VzIHdpbGwgYmUgdXNlZC4KClJlZ2FyZHMs
CgpMZW8KCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
