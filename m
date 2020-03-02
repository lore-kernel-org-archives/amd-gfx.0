Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1951C3F2D1
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 12:32:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C02512173E
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 12:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oONH+kRY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C02512173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63F496E26F;
	Mon,  2 Mar 2020 12:32:43 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1A326E261
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 12:32:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnUe+1FX1ffr785OZo+pwPyoqj2IbMns9+OJpWBO88sAcQCepQ60WcDYI6/oXSh83axteUz/JHmxP9zFsis9STJSAEWjEz7qsgaxvHh5DxOzeFRpPjAiuOfefhCR8jGfwCKEo0GsEy1vlDjVCuL6IxZW+9lgKBZeCmtIvIgp43nFKSGczMWIK7f3cGDNlkBJTJRG1FPv3oP4VPofUJ4F7YbweWqq3JdS4SVmT9jlOoyWt1QHXeuBRWIJM4xHucc2K32ElVlMYqV8NtKMOmT/nDquv5VEkUoz0sVfrXVCU+O0/a6ffopQdBnQySRf5QOT0Pfa3UEUZToXAc0t2vU96g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btV0XhZJ0OI1sBJJfkDgC2sb7ribbUfQUZBw8zp80sU=;
 b=VQ2ZY6Yohl57xHuT83K1ZbPonIvsdA++ToX4heOuY6z4zZcPZMj7uoGoNcL1FU/1pyIEXIxy/eRfrW4xmGU3P89t6vVJfuspkxiqFGxnQCT/Es7SdU01s+j1Sw/80Q9qrmMhBH+Tx5EPMOVEOoBfRkvM1pUDFlyRF8bi5pU+cQ2qVo4x9/yiMbaA1Te8J3nefXbPvaWTcNJDDjv/ycEQYD3FKjJE7re9h7kqvx1hjUDOOFYr6EeGrjvqUzcGZmAMTcQx+cwFmO5bkUtNWfl83p/ZZcgfG2qIEnsUxnpcuQww3fCWh37CdXV7j8pq0aOnC1807nl0tNf/ZY/wIfxFrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btV0XhZJ0OI1sBJJfkDgC2sb7ribbUfQUZBw8zp80sU=;
 b=oONH+kRYk3TnjqeB5eC80+7gQ2+GiXbSJ6ndyReveDXpZEVtCBz3pw35J3/QsbuISK885lDU7LO3oNM8fL8IvgWm277nNdUmKRVLWNiEI10mWSN5HEtENM0OFwGdL91mFcatxSa9e46+crsO3P0B/aJczqOykm9HitrZObNDOJ0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (2603:10b6:4:b9::11) by
 DM5PR12MB1916.namprd12.prod.outlook.com (2603:10b6:3:112::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Mon, 2 Mar 2020 12:32:40 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904%4]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 12:32:40 +0000
Subject: Re: [PATCH v3 3/4] drm/amdgpu: change hw sched list on ctx priority
 override
To: christian.koenig@amd.com, Nirmoy Das <nirmoy.aiemd@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20200302095234.3638-1-nirmoy.das@amd.com>
 <20200302095234.3638-3-nirmoy.das@amd.com>
 <e3cd9281-fa33-2050-f69a-261444f26bf5@gmail.com>
 <f687e152-a1e1-49f6-a81d-c09ec8f5d6ee@amd.com>
 <4c592b11-6d1b-562f-1563-d0c3e863d860@gmail.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <26cad491-901a-eb8c-a5b1-ee69f1d08e00@amd.com>
Date: Mon, 2 Mar 2020 13:35:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <4c592b11-6d1b-562f-1563-d0c3e863d860@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: ZR0P278CA0047.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::16) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f21:fc00:9e54:a4a7:c1b6:6128]
 (2003:c5:8f21:fc00:9e54:a4a7:c1b6:6128) by
 ZR0P278CA0047.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15 via Frontend Transport; Mon, 2 Mar 2020 12:32:38 +0000
X-Originating-IP: [2003:c5:8f21:fc00:9e54:a4a7:c1b6:6128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 434f36f2-937d-449d-3b9a-08d7bea5cc00
X-MS-TrafficTypeDiagnostic: DM5PR12MB1916:|DM5PR12MB1916:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB19160494BE98DB386100EEFD8BE70@DM5PR12MB1916.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(189003)(199004)(16526019)(5660300002)(4326008)(8676002)(36756003)(66946007)(66476007)(66556008)(478600001)(316002)(81156014)(81166006)(31686004)(31696002)(6666004)(2906002)(2616005)(6486002)(8936002)(52116002)(186003)(4744005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1916;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lKhu3X4/QnpIFQe7+1DU9rX6ymPCzXxNuG6rRRq52MAJ2aoIkzXGz7FAnbeBhMLU8mrah9p8BKKUwTXvubwUwzZAhtt8UL8AqjYk/3A2R6ZvYN+gWtlfcI/nYOzfGWTTVr4Q2CzbzEhBhAad/3FMdoL5puFgRKxcZAiEfpnKpRE4/jAQwRqL0wIvGRb1DsS5a95oEEbSvElgDw1BDK7yJgDtVhUfdnm1w30fUeHsB+EabVM3xM2wxg8NgILBUoOMhppq0wHtT2Y+ydWSqukVvXMwzzPbOoJAWjHmeHb7g42/E1BNxxwiM4xx2n8Fe/7MAMrkYH5UEtMnx1k5a+K7n7RWIee6Xs4jEhFudn0smoVB4uBZ6XgSCP4yhzO7MtzLfp7wbi/5vBz8jAiU/s1xAQi1UR+jkSBNlZ/BOQi7/QxLo2kYjHHlqjCdC1S4KeRf
X-MS-Exchange-AntiSpam-MessageData: v8xzG7SJUnU6buJglMAhoNoCR4u4fAORQlXnTFK07SDQnLL1Kl+ZYP5uxUf2+jm3Fk3Fm0hNvIAgwYAqvrFtK8YoMyHtk1IP9Z0EmzTKrXaMj4u8bZBfA6vUcbkWPVjFuL1W7UlGdZF1ijtN5+T6j4W1J/UZ1IkeBhxnMjjHZm7BZ/Py+atbjx+VieIYeyWK0heCKBzexkme5l02v17GAA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 434f36f2-937d-449d-3b9a-08d7bea5cc00
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 12:32:40.0411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+zsVlXjI/uGQvHCXAVCQ57FhEXADGmCAwMHXELSab6q/RnD1ecenrS3J3v8WHx6NVdJc0/0qcpy7GoTJ7pXOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1916
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Kwo+Pj4+ICvCoMKgwqAgc3dpdGNoIChod19pcCkgewo+Pj4+ICvCoMKgwqAgY2FzZSBBTURHUFVf
SFdfSVBfQ09NUFVURToKPj4+PiArwqDCoMKgwqDCoMKgwqAgY29tcHV0ZV9wcmlvcml0eSA9Cj4+
Pj4gKyBhbWRncHVfY3R4X3NjaGVkX3ByaW9fdG9fY29tcHV0ZV9wcmlvKHByaW9yaXR5KTsKPj4+
PiArwqDCoMKgwqDCoMKgwqAgc2NoZWRzID0gYWRldi0+Z2Z4LmNvbXB1dGVfcHJpb19zY2hlZFtj
b21wdXRlX3ByaW9yaXR5XTsKPj4+PiArwqDCoMKgwqDCoMKgwqAgbnVtX3NjaGVkcyA9IGFkZXYt
PmdmeC5udW1fY29tcHV0ZV9zY2hlZFtjb21wdXRlX3ByaW9yaXR5XTsKPj4+PiArwqDCoMKgwqDC
oMKgwqAgYnJlYWs7Cj4+Pj4gK8KgwqDCoCBkZWZhdWx0Ogo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBy
ZXR1cm47Cj4+Pj4gK8KgwqDCoCB9Cj4+Pj4gKwo+Pj4+ICvCoMKgwqAgZHJtX3NjaGVkX2VudGl0
eV9tb2RpZnlfc2NoZWQoJmFlbnRpdHktPmVudGl0eSwgc2NoZWRzLCAKPj4+PiBudW1fc2NoZWRz
KTsKPj4+Cj4+PiBUaGF0IG5lZWRzIHRvIGJlIHVuZGVyIHRoZSAiY2FzZSBBTURHUFVfSFdfSVBf
Q09NUFVURSIgb3Igb3RoZXJ3aXNlIAo+Pj4gd2Ugc2V0IHRoZSBzY2hlZHVsZXJzIHRvIE5VTEwg
Zm9yIFNETUEuCj4+IFNETUEgd2lsbCBmYWxsIGludG/CoCBkZWZhdWx0IGNhc2Ugd2hpY2ggd2ls
bCByZXR1cm4gZnJvbSB0aGUgZnVuY3Rpb24gCj4+IGltbWVkaWF0ZWx5Lgo+Cj4gT2gsIHRoYXQn
cyBhIGJhZCBpZGVhLiBXZSBzdGlsbCB3YW50IHRoZSBjYWxsIHRvIAo+IGRybV9zY2hlZF9lbnRp
dHlfc2V0X3ByaW9yaXR5KCkgaW4gdGhpcyBjYXNlLgo+Cj4gTWF5YmUgbW92ZSB0aGUgY2FsbCB0
byBkcm1fc2NoZWRfZW50aXR5X3NldF9wcmlvcml0eSgpIGFib3ZlIHRoZSBzd2l0Y2g/ClJpZ2h0
IHdlIHN0aWxsIG5lZWQgZHJtX3NjaGVkX2VudGl0eV9zZXRfcHJpb3JpdHkoKS4gSSB3aWxsIHVw
ZGF0ZSBpdC4KCgpSZWdhcmRzLAoKTmlybW95CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
