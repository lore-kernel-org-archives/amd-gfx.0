Return-Path: <SRS0=Oth2=3N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CD8C2D0DB
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2020 15:16:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFDCB20709
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2020 15:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CbUL80gd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFDCB20709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 996C76E3A8;
	Fri, 24 Jan 2020 15:16:57 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3C3E6E3A8
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2020 15:16:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrrYay/AauL9weRs6d/bUQ5Tn/hmOu1ITMPgfjtJRqGTxnLnKMw/IgXyqZr9fKAFakwKqDfBu5OMxZIFwZM9PG2nzkrFNDlvVsIqUcU1p4/vhyWP4opypTApo24NNkku6W36FD+iBf1ZPFw3BEnKRCKNCzEz0mln+1RYxJSc9p2ycBzeF1VRgHon6AZsM1t16/IsesstMVlJFaVf4VbeJnSpKp1fkdcKWvF77/6WFV3AQAJdzRYhJWmJ+n7xmJxmG64JT1YxCSs9Df1IboIO1WgrAYRtfR0p6c8A+VgHzv9dLUESiJ3m2dI+YI3cFXvwZnTPbI1QAI6ux3qPBXVWPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Kn52kq/mJf+reXpKpegpYzw576nIjePmssUsDfpbos=;
 b=U6sabBCZ9rWhHLlc3KOnR7IHDHK8l7MSGr4U8/CSSzfl5Da0RZcy3arCWj4EUEDQ13J8LAa/WG9Ux+B7PEXjq2Z5B0eb0DW0RomuBPfZQmgIt8i3Qtr1KKxoepkYtaaR5RPFTFtutq+eETG74h1WgH0EOECR8AfyiV8eZGY/w0EkHpbckMusMrlEhx/b0j46+AfBQ7/1DtdE0ghRnJbSwn2X50HJ4ptL8iAN/xQoyG5/4ewxA+QtAfeDGFjYm1+J4cz952DTzzibFdX/NM3HBfNpu1jRC3GYZECCftlVot818L4IuwdTYXu7OVBHqu4sHCDKTJ7vIfKgbgYSVQnUOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Kn52kq/mJf+reXpKpegpYzw576nIjePmssUsDfpbos=;
 b=CbUL80gd1QuDAwLI0W/cESKxamiWG8iyH4Ms2niZhmMAUW7Fu7LlFUOSA5n25ItQO0apeKP4Z6b9AcAQW8hD7PpAB+q0yTn2RhW7Pi6uO77mY33rL+4X8E2bHkgnliJ674wiWTjpElD4S4nyUH8vB6qWugtaomeWdbGBiMEiVkg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (52.132.143.139) by
 DM5PR12MB1148.namprd12.prod.outlook.com (10.168.237.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Fri, 24 Jan 2020 15:16:54 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::c06c:24da:d4c5:5ee3]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::c06c:24da:d4c5:5ee3%6]) with mapi id 15.20.2644.028; Fri, 24 Jan 2020
 15:16:53 +0000
Subject: Re: [PATCH] drm/amdgpu: allocate entities on demand
To: christian.koenig@amd.com, Nirmoy Das <nirmoy.aiemd@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20200124115311.8037-1-nirmoy.das@amd.com>
 <20200124124149.4420-1-nirmoy.das@amd.com>
 <2051b4e3-0ae0-999a-6161-284c9c5862b0@gmail.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <1a9d67e2-bbc1-f02b-5713-1886a64dd081@amd.com>
Date: Fri, 24 Jan 2020 16:18:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
In-Reply-To: <2051b4e3-0ae0-999a-6161-284c9c5862b0@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0078.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::19) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
Received: from [IPv6:2003:c5:8f2a:4600:f739:b646:7d2a:1c91]
 (2003:c5:8f2a:4600:f739:b646:7d2a:1c91) by
 AM0PR01CA0078.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.22 via Frontend
 Transport; Fri, 24 Jan 2020 15:16:52 +0000
X-Originating-IP: [2003:c5:8f2a:4600:f739:b646:7d2a:1c91]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 355af586-fa62-44a5-e1eb-08d7a0e071b5
X-MS-TrafficTypeDiagnostic: DM5PR12MB1148:|DM5PR12MB1148:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB114829A39B60902BDD8401458B0E0@DM5PR12MB1148.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 02929ECF07
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(199004)(189003)(31696002)(4326008)(8676002)(36756003)(6666004)(81156014)(8936002)(81166006)(5660300002)(4744005)(316002)(2906002)(66476007)(66556008)(31686004)(66946007)(2616005)(53546011)(6486002)(186003)(16526019)(478600001)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1148;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: phgCrK/aKp4M7Yr0VZrHmuJD+b3As8Z+vvXgC6PAs/4gQV1G5VL8paanTCaHFDP0UdxQtXpn3ZfWtdmKCN0qSB/PLheSXLWsGA5ApFJ4AfbXZIHfkFQGsM/K4S2IcsMWevHaKriPdVImnZHvRc2g3gxnZW7R3WeL7riHpZnok4xCcCTmAZ3FMBR9qEgFNcn05R9wYdyhcVRg5Wp2lrphLyLv3Bw7f3mA89AFB6tV6OzEv2SHoO+P62uDYGx/+xv3P0JBgxURx6yZt7JAqI2yI9aP7TahT78QDtvoNJX7Y7nMBVAAxKiYmITsL09rGP3cQultoX/O8wVLGp5tzQVANiXuPvHZnOdFM9sru/fFmJ4qMk/zS/AQem3xMxWh9ED3uPx+HY2CY3O2NADgJ9oCwieznLDTZaSOE1MTFGB6S3YuIrVUrZVucDAywlCLl32E
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 355af586-fa62-44a5-e1eb-08d7a0e071b5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2020 15:16:53.9426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P1NWplXVOZtAPbD0MKaRPpAzGklRiC1/49cOeT7agjMXNXsSlLARWWMqnJxXx2TM2emD0k/1A5NpNKANi2jfsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1148
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
Cc: alexander.deucher@amd.com, kenny.ho@amd.com, nirmoy.das@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDEvMjQvMjAgMTo1NiBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPgo+PiArwqDCoMKg
IGVudGl0eS0+ZmVuY2VzID0ga2NhbGxvYyhhbWRncHVfc2NoZWRfam9icywKPj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNpemVvZihzdHJ1Y3QgZG1hX2ZlbmNlKiksIEdGUF9L
RVJORUwpOwo+Cj4gSXQgd291bGQgYmUgcmF0aGVyIG5pY2UgdG8gaGF2ZSB0byBhbGxvY2F0ZSB0
aGUgZmVuY2VzIGFycmF5IHRvZ2V0aGVyIAo+IHdpdGggdGhlIGVudGl0eS4KPgo+IFRha2UgYSBs
b29rIGF0IHN0cnVjdCBkbWFfcmVzdl9saXN0IGFuZCB0aGUgZnVuY3Rpb24gCj4gZG1hX3Jlc3Zf
bGlzdF9hbGxvYygpIG9uIGhvdyB0byBkbyB0aGlzLgo+ClRoYXQgaXMgdmVyeSBpbnRlcmVzdGlu
ZyBhbGxvY2F0aW9uIG1ldGhvZC4KClVwZGF0ZWQgdGhlIHBhdGNoLgoKVGhhbmtzLAoKTmlybW95
Cgo+IEFwYXJ0IGZyb20gdGhhdCB0aGUgcGF0Y2ggbm93IGxvb2tzIGxpa2UgYSBuaWNlIGNsZWFu
dXAgdG8gbWUsIGJ1dCBJIAo+IG5lZWQgdG8gZnVsbHkgcmVhZCBpdCBmcm9tIHRvcCB0aWxsIGJv
dHRvbSBvbmNlIG1vcmUuCj4KPiBSZWdhcmRzLAo+IENocmlzdGlhbi4KPgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
