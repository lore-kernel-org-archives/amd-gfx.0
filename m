Return-Path: <SRS0=uLL/=J3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0814AC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 23:42:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8451E61208
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 23:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8451E61208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 063136E517;
	Fri, 30 Apr 2021 23:42:45 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58C1D6E517
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Apr 2021 23:42:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W13FDBcXqn2eknNdLf0ebS24wM6SkOe83KXfEOPBY1JqTnkfM9ydybBFhqcvIloRfrP/UwDI3jAtrp5qVLRM+wQ2ufekBl8CJGc8OyJTruynDZdSH58NGK5hGm1LRSxo4wk1ogCg7sa4nhOPeLZtyP6IKvXLKvBponnn02qOHwV9AMubyMziF1ov/Z+UtaUYyat9ZMd6iPWKuG+lE7r7a2iR8dWQPEes9k7K2rSYP0pPfLev1a7aSNAYejHrr7c6csHrtWt4lV+dXpGxBy6jbVuN8bz8MwsB99Y9w+R1TtZj9Rv4bhV3fmcrKBRkHURdmwZXGHGYEL6WcKhYNgav3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPtbzoj+JOVxhMZ9tgOCuTHbCqgawBK3ysbGHHPyNeE=;
 b=iX6F7rsOYs/fHMzTJzf7+5AYyV/HjMtfN77Ymyu03h0vUclKjoEP8f0brpbT+GO9/mzRX/C92k/DyfY8Lf2RNLb67TMwcgn8dYOHfT/+r3Dm1jSA+XMqPNbuKhD7k27kEx1aeg79eEj03bG4jTxTT0tAeH5PwO6FjJ58An9CIrRQDdgoxdAH3RR9oKGttYt8ct3fupHIcCerNf5Bt18w58aXsQyYx1XLwek6IC4wee59HrFUJ/fENjdoxyPVV99dMz9r16KA2J0e0mriTFhkP8dG/BvOKmwX4CIffGzc1YHl5REY9xs95dBze85CKwm8CkCwL0viHyes6HCcce+M1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPtbzoj+JOVxhMZ9tgOCuTHbCqgawBK3ysbGHHPyNeE=;
 b=inwZh28OFL5/pm2gSRctTy5cUnj3xVGA+x0IB3G2v4ZkbESN0xj5WWoyoXFjrnBxtYIlbh16OcKvbRX0uLD29cdr8VxvAJEwwSC33p8Hi0nsLEpnwTKlXWl5TA9uY7n0Q0txg27VQbVVz+cs6l7Mc9irklLJohoDQ9MAC7kPKZQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26; Fri, 30 Apr
 2021 23:42:41 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%5]) with mapi id 15.20.4065.027; Fri, 30 Apr 2021
 23:42:41 +0000
Subject: Re: [PATCH] drm/amdkfd: add ACPI SRAT parsing for topology
To: amd-gfx@lists.freedesktop.org,
 "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>
References: <20210428151154.28317-1-jinhuieric.huang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <cd262559-2395-1bb9-81a1-a42e4dd20b8b@amd.com>
Date: Fri, 30 Apr 2021 19:42:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210428151154.28317-1-jinhuieric.huang@amd.com>
Content-Language: en-US
X-Originating-IP: [142.182.183.69]
X-ClientProxiedBy: YTOPR0101CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::31) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.183.69) by
 YTOPR0101CA0054.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25 via Frontend
 Transport; Fri, 30 Apr 2021 23:42:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 725aa0ea-09dc-4ec9-6528-08d90c31a4ee
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB41927735FD12479EA9BDE860925E9@MN2PR12MB4192.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O8aNEmCItHkzYOdVHD2ZV9aRqLxJUefultSgp7ndi9s/fQYANxGqnxCDJ+E3PRMXeEFBlTf6QY+uQxpVec4GYvW1iXF7HOAY+SDGIczb+O4JBCCbb9zwFGY94/wb2ocaqHG97WZyzU75P1IDRRUjUFekRo6I8RY6i+GQSpy6Gxs3DVHd6syEET5pAjSi+agkTvd6r3cixMjyli7LltVV3aZ/wV0l7EHY71B0Odf2NUKRmPu96vsViMDcqQCbud/KRMSHL1ZcMz0tqkNUPPUUi17eSritIJ2JRcUPZYExcqTqlN4xy1l7L89C0RbhjLmdoja69ZzR8DRR+tg3FwTyOprNwhXsJrIua7A8ogoqEEMHeXZs1T4tskNNIe8rQR6eH6EG5qJAeA/97WdOmX+9skkTtvhF+tSbNhv6Q0hS6kKgKxj6yelcfOW9YtfK6fE1JmbFhrIu5ZtYSIwOI+1l8HyV+vPWywBh6DfxSxT10864PNWg8hcW16m1fFK07QdEK4o9/8+xtFvnswh3VD5eIBd+f+v7ukCFhjLf/dO+7HSN5yceuOHvMEzJBj3w31ZQph1njhQ42V+7zRVhJEIvfC/vPkpn/73aU4vovUBIA29sWNOm7JeGXopnJHGUFCWliTTyOdbsoOfFCAVp0noGNNhNavn06+NHag+7OxMu+zDm8czook4dMX96wGIWXsk9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(2906002)(316002)(6486002)(66946007)(37006003)(6636002)(83380400001)(66476007)(16576012)(8676002)(8936002)(66556008)(6862004)(26005)(31696002)(36756003)(2616005)(5660300002)(16526019)(44832011)(956004)(86362001)(38100700002)(31686004)(478600001)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZmpQazNQS3h3STRWMjEwdmdaU2RlZnB1anlSRGRtWlNmNllxRVhpY1FkdERN?=
 =?utf-8?B?MTI2RWpnMWk3WUh2VUNPSlNSeXQ3S1VOeG11YVZtaVhEWmo2cjZVQVNvenBB?=
 =?utf-8?B?bytyck9YeW9CSGFxOHhKejdZMWtwYlNDVWYzMjFTYTMxczl5Zm1nUDlxbENi?=
 =?utf-8?B?LzdseHE3WVJyNFBNeFRYZjBaL0x3Q2tKZElMZEphNWFpODhvTDE4NjJnUG9u?=
 =?utf-8?B?WWxLRGZmSTlJdGtDWk1URnV6RUVFMlBwMHdhK2k5OHd3R2NMMEFYRnh1a21w?=
 =?utf-8?B?VGExeTdVZWI0cDA5ek5yc2dpakg5SUp5SEx5RFN1RWVqMW5Qam41c29aNVQ2?=
 =?utf-8?B?OHpNRzZ3clFUdmVVL0ZJT3BUeGR2bWJSZkFVNlZmNzg4U0pKUmcxY2EvUUhH?=
 =?utf-8?B?ZnMyMjd5Rm0rMERFdmYxdkN1Z09VZ1FpNjlHQXpNZThEamhrdE41UWxVTVl2?=
 =?utf-8?B?dzhpS1Byakx2SUhzemF3WXl4ZlVHeThnRFlsTXozb3NFQWFFWGxKV1Z1b1RN?=
 =?utf-8?B?U2FLbEpnQSs0N0w2bW0rSzdNRkNRWVFlQXJrZk9OMmw5eThubDhKQXVQTURr?=
 =?utf-8?B?WmJjL2JLZkZiQTN4aWxXZmE2eGJ2cmVwaTFZQzQ2ZUNoOGNKWkRQTW1HNWtN?=
 =?utf-8?B?bDkvTDBUNThPM0MwY1E3WFpmak9xanczSXc1Y2Y1akwwN3prTzcvak9EVE9K?=
 =?utf-8?B?OThFWkY3eGxGZ3d1OUI3SXBZVk11WklieHJOTzUrNTNveWtxVU1PVEVaYzha?=
 =?utf-8?B?L0pVUWdiRHJUY2QvTWJ6SWRoOWVrNmxSVVRPd3JoZi9iZmFCbmhHaElYekZt?=
 =?utf-8?B?YnVoV3h2T1JvOWYxRzBrWHcwSHZJVktZTkdhRjdFT1FRNGRsSzJSalBZemZF?=
 =?utf-8?B?MG1RbUR4b1ZGc3pCOThrVmp0RlV6eXM4UkFRczBEbTNGUHJURVhvV29tbWJZ?=
 =?utf-8?B?OXVTckhXZ3NGQTd3RTV5c2EyNUw4SXJIdHNNaEVUWDlhN3MrdGJ3M2F2c0wy?=
 =?utf-8?B?M0hyTXFNZGRUbGJnUElIRURBTVk5akxiSlV2TUtHcldNSHU1bG9ZNEJkQ0pM?=
 =?utf-8?B?Ujd6bVpGMnYyRldiNENaZWJHN1J0UUFESUI5ZjBXTFA1MkVWQ1pRYWtVZDY3?=
 =?utf-8?B?V2NUS3JXekFkUjhqZTdFZzN4V1RhZXQ4d2d2V1NHbjNDMTVNNXVvbXlrclIw?=
 =?utf-8?B?TC9WbmdZT0wvMm1XRWRQdG1xNW8zbGZoa2FkWWlLeStVWGxsY2plT3J0V2cz?=
 =?utf-8?B?eGo0aVFWS2dqYjcyc3pCbWx4ZTlteWNWL1ZaYzZYc1NNcXpuWStFcHUvaHpG?=
 =?utf-8?B?bW81YTNLeFMvZy9adE1qM0V3TzMzSWVFK0ZPNzBiWnJwUVlRRDQ4aVJ4THMw?=
 =?utf-8?B?ZkVEZ2w3NE1NZUZnb3k1M29NSkdqTnQ5aElJRmJCSVBpNkFoT2EyWXhxRXVY?=
 =?utf-8?B?K0dYYTVGOGZnOUEwczhYWDVEZnJyQU9oendlbU4zUk5NUEZIeUFRcDJ2UnV1?=
 =?utf-8?B?Uy9XNjhBSzRITlhqeUtTSHZvTHFCODMvdWdkVW1LR1JkZGExSDNaZm41NVJu?=
 =?utf-8?B?M0ZUM0wrZWJ0bk0rMllPejhhclByQlQxMDVvSkVETTNWRmhERWR1d1pjU01m?=
 =?utf-8?B?eVdoa2pjL2pYQ0FSTWdXTWtScGY1Rys5Y1JlcmFtU1I4cnlsV3FBaFdJaHE1?=
 =?utf-8?B?b3hVL096Mnh5TUpvZTZ2bFNIYy95TGpkakMrYURBZ3RzNlduMWo1Z3orUmNS?=
 =?utf-8?Q?/nWX7fDsn9AkX9RutCjPSneBLPu2cnd+jFp6hgn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 725aa0ea-09dc-4ec9-6528-08d90c31a4ee
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 23:42:41.1963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K79H2FqqERsQ3jaLb4b83vqKArbcuJpIqGvulbVBY//FVeoLl/aMjZ8/FkivlOx8c0+qAuopz8npgMxypEPf1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4192
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMS0wNC0yOCB1bSAxMToxMSBhLm0uIHNjaHJpZWIgRXJpYyBIdWFuZzoKPiBJbiBOUFM0
IEJJT1Mgd2UgbmVlZCB0byBmaW5kIHRoZSBjbG9zZXN0IG51bWEgbm9kZSB3aGVuIGNyZWF0aW5n
Cj4gdG9wb2xvZ3kgaW8gbGluayBiZXR3ZWVuIGNwdSBhbmQgZ3B1LCBpZiBQQ0kgZHJpdmVyIGRv
ZXNuJ3Qgc2V0Cj4gaXQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBFcmljIEh1YW5nIDxqaW5odWllcmlj
Lmh1YW5nQGFtZC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9j
cmF0LmMgfCA5NCArKysrKysrKysrKysrKysrKysrKysrKysrKy0KPiAgMSBmaWxlIGNoYW5nZWQs
IDkxIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NyYXQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9jcmF0LmMKPiBpbmRleCAzOGQ0NTcxMTY3NWYuLjU3NTE4MTM2YzdkNyAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY3JhdC5jCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NyYXQuYwo+IEBAIC0xNzU5LDYgKzE3NTksODcg
QEAgc3RhdGljIGludCBrZmRfZmlsbF9ncHVfbWVtb3J5X2FmZmluaXR5KGludCAqYXZhaWxfc2l6
ZSwKPiAgCXJldHVybiAwOwo+ICB9Cj4gIAo+ICsjaWZkZWYgQ09ORklHX0FDUEkKPiArc3RhdGlj
IHZvaWQga2ZkX2ZpbmRfbnVtYV9ub2RlX2luX3NyYXQoc3RydWN0IGtmZF9kZXYgKmtkZXYsCj4g
KwkJaW50ICpudW1hX25vZGUpCj4gK3sKPiArCXN0cnVjdCBhY3BpX3RhYmxlX2hlYWRlciAqdGFi
bGVfaGVhZGVyID0gTlVMTDsKPiArCXN0cnVjdCBhY3BpX3N1YnRhYmxlX2hlYWRlciAqc3ViX2hl
YWRlciA9IE5VTEw7Cj4gKwl1bnNpZ25lZCBsb25nIHRhYmxlX2VuZCwgc3VidGFibGVfbGVuOwo+
ICsJdTMyIHBjaV9pZCA9IHBjaV9kb21haW5fbnIoa2Rldi0+cGRldi0+YnVzKSA8PCAxNiB8Cj4g
KwkJCXBjaV9kZXZfaWQoa2Rldi0+cGRldik7Cj4gKwl1MzIgYmRmOwo+ICsJYWNwaV9zdGF0dXMg
c3RhdHVzOwo+ICsJc3RydWN0IGFjcGlfc3JhdF9jcHVfYWZmaW5pdHkgKmNwdTsKPiArCXN0cnVj
dCBhY3BpX3NyYXRfZ2VuZXJpY19hZmZpbml0eSAqZ3B1Owo+ICsJaW50IHB4bSA9IDAsIG1heF9w
eG0gPSAwOwo+ICsJYm9vbCBmb3VuZCA9IGZhbHNlOwo+ICsKPiArCS8qIEZldGNoIHRoZSBTUkFU
IHRhYmxlIGZyb20gQUNQSSAqLwo+ICsJc3RhdHVzID0gYWNwaV9nZXRfdGFibGUoQUNQSV9TSUdf
U1JBVCwgMCwgJnRhYmxlX2hlYWRlcik7Cj4gKwlpZiAoc3RhdHVzID09IEFFX05PVF9GT1VORCkg
ewo+ICsJCXByX3dhcm4oIlNSQVQgdGFibGUgbm90IGZvdW5kXG4iKTsKPiArCQlyZXR1cm47Cj4g
Kwl9IGVsc2UgaWYgKEFDUElfRkFJTFVSRShzdGF0dXMpKSB7Cj4gKwkJY29uc3QgY2hhciAqZXJy
ID0gYWNwaV9mb3JtYXRfZXhjZXB0aW9uKHN0YXR1cyk7Cj4gKwkJcHJfZXJyKCJTUkFUIHRhYmxl
IGVycm9yOiAlc1xuIiwgZXJyKTsKPiArCQlyZXR1cm47Cj4gKwl9CkFmdGVyIGEgc3VjY2Vzc2Z1
bCBjYWxsIHRvIGFjcGlfZ2V0X3RhYmxlIHlvdSBuZWVkIHRvIGNhbGwKYWNwaV9wdXRfdGFibGUg
YmVmb3JlIHRoaXMgZnVuY3Rpb24gcmV0dXJucyB0byBhdm9pZCBsZWFraW5nIG1lbW9yeS4KCgo+
ICsKPiArCXRhYmxlX2VuZCA9ICh1bnNpZ25lZCBsb25nKXRhYmxlX2hlYWRlciArIHRhYmxlX2hl
YWRlci0+bGVuZ3RoOwo+ICsKPiArCS8qIFBhcnNlIGFsbCBlbnRyaWVzIGxvb2tpbmcgZm9yIGEg
bWF0Y2guICovCj4gKwo+ICsJc3ViX2hlYWRlciA9IChzdHJ1Y3QgYWNwaV9zdWJ0YWJsZV9oZWFk
ZXIgKikKPiArCQkJKCh1bnNpZ25lZCBsb25nKXRhYmxlX2hlYWRlciArCj4gKwkJCXNpemVvZihz
dHJ1Y3QgYWNwaV90YWJsZV9zcmF0KSk7Cj4gKwlzdWJ0YWJsZV9sZW4gPSBzdWJfaGVhZGVyLT5s
ZW5ndGg7Cj4gKwo+ICsJd2hpbGUgKCgodW5zaWduZWQgbG9uZylzdWJfaGVhZGVyKSArIHN1YnRh
YmxlX2xlbiAgPCB0YWJsZV9lbmQpIHsKPiArCQkvKgo+ICsJCSAqIElmIGxlbmd0aCBpcyAwLCBi
cmVhayBmcm9tIHRoaXMgbG9vcCB0byBhdm9pZAo+ICsJCSAqIGluZmluaXRlIGxvb3AuCj4gKwkJ
ICovCj4gKwkJaWYgKHN1YnRhYmxlX2xlbiA9PSAwKSB7Cj4gKwkJCXByX2VycigiU1JBVCBpbnZh
bGlkIHplcm8gbGVuZ3RoXG4iKTsKPiArCQkJYnJlYWs7Cj4gKwkJfQo+ICsKPiArCQlzd2l0Y2gg
KHN1Yl9oZWFkZXItPnR5cGUpIHsKPiArCQljYXNlIEFDUElfU1JBVF9UWVBFX0NQVV9BRkZJTklU
WToKPiArCQkJY3B1ID0gKHN0cnVjdCBhY3BpX3NyYXRfY3B1X2FmZmluaXR5ICopc3ViX2hlYWRl
cjsKPiArCQkJcHhtID0gKigodTMyICopY3B1LT5wcm94aW1pdHlfZG9tYWluX2hpKSA8PCA4IHwK
PiArCQkJCQljcHUtPnByb3hpbWl0eV9kb21haW5fbG87Cj4gKwkJCWlmIChweG0gPiBtYXhfcHht
KQo+ICsJCQkJbWF4X3B4bSA9IHB4bTsKPiArCQkJYnJlYWs7Cj4gKwkJY2FzZSBBQ1BJX1NSQVRf
VFlQRV9HRU5FUklDX0FGRklOSVRZOgo+ICsJCQlncHUgPSAoc3RydWN0IGFjcGlfc3JhdF9nZW5l
cmljX2FmZmluaXR5ICopc3ViX2hlYWRlcjsKPiArCQkJYmRmID0gKigodTE2ICopKCZncHUtPmRl
dmljZV9oYW5kbGVbMF0pKSA8PCAxNiB8Cj4gKwkJCQkJKigodTE2ICopKCZncHUtPmRldmljZV9o
YW5kbGVbMl0pKTsKPiArCQkJaWYgKGJkZiA9PSBwY2lfaWQpIHsKPiArCQkJCWZvdW5kID0gdHJ1
ZTsKPiArCQkJCSpudW1hX25vZGUgPSBweG1fdG9fbm9kZShncHUtPnByb3hpbWl0eV9kb21haW4p
Owo+ICsJCQl9Cj4gKwkJCWJyZWFrOwo+ICsJCWRlZmF1bHQ6Cj4gKwkJCWJyZWFrOwo+ICsJCX0K
PiArCj4gKwkJaWYgKGZvdW5kKQo+ICsJCQlicmVhazsKPiArCj4gKwkJc3ViX2hlYWRlciA9IChz
dHJ1Y3QgYWNwaV9zdWJ0YWJsZV9oZWFkZXIgKikKPiArCQkJCSgodW5zaWduZWQgbG9uZylzdWJf
aGVhZGVyICsgc3VidGFibGVfbGVuKTsKPiArCQlzdWJ0YWJsZV9sZW4gPSBzdWJfaGVhZGVyLT5s
ZW5ndGg7Cj4gKwl9Cj4gKwo+ICsJLyogd29ya2Fyb3VuZCBiYWQgY3B1LWdwdSBiaW5kaW5nIGNh
c2UgKi8KPiArCWlmIChmb3VuZCAmJiAoKm51bWFfbm9kZSA8IDAgfHwgKm51bWFfbm9kZSA+IG1h
eF9weG0pKQo+ICsJCSpudW1hX25vZGUgPSAwOwoKQSBzdWdnZXN0aW9uOiBJZiB5b3UgZmluZCBh
IHNlbnNpYmxlIE5VTUEgbm9kZSwgY2FsbCBzZXRfZGV2X25vZGUgaGVyZS4KVGhhdCBzaW1wbGlm
aWVzIHRoZSBjYWxsZXIuIFNlZSBiZWxvdwoKCj4gK30KPiArI2VuZGlmCj4gKwo+ICAvKiBrZmRf
ZmlsbF9ncHVfZGlyZWN0X2lvX2xpbmsgLSBGaWxsIGluIGRpcmVjdCBpbyBsaW5rIGZyb20gR1BV
Cj4gICAqIHRvIGl0cyBOVU1BIG5vZGUKPiAgICoJQGF2YWlsX3NpemU6IEF2YWlsYWJsZSBzaXpl
IGluIHRoZSBtZW1vcnkKPiBAQCAtMTc3NCw2ICsxODU1LDkgQEAgc3RhdGljIGludCBrZmRfZmls
bF9ncHVfZGlyZWN0X2lvX2xpbmtfdG9fY3B1KGludCAqYXZhaWxfc2l6ZSwKPiAgCQkJdWludDMy
X3QgcHJveGltaXR5X2RvbWFpbikKPiAgewo+ICAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYg
PSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKilrZGV2LT5rZ2Q7Cj4gKyNpZmRlZiBDT05GSUdfTlVN
QQo+ICsJaW50IG51bWFfbm9kZSA9IDA7CgpTaG91bGQgdGhpcyBiZSBOVU1BX05PX05PREU/CgoK
PiArI2VuZGlmCj4gIAo+ICAJKmF2YWlsX3NpemUgLT0gc2l6ZW9mKHN0cnVjdCBjcmF0X3N1YnR5
cGVfaW9saW5rKTsKPiAgCWlmICgqYXZhaWxfc2l6ZSA8IDApCj4gQEAgLTE4MDUsOSArMTg4OSwx
MyBAQCBzdGF0aWMgaW50IGtmZF9maWxsX2dwdV9kaXJlY3RfaW9fbGlua190b19jcHUoaW50ICph
dmFpbF9zaXplLAo+ICAKPiAgCXN1Yl90eXBlX2hkci0+cHJveGltaXR5X2RvbWFpbl9mcm9tID0g
cHJveGltaXR5X2RvbWFpbjsKPiAgI2lmZGVmIENPTkZJR19OVU1BCj4gLQlpZiAoa2Rldi0+cGRl
di0+ZGV2Lm51bWFfbm9kZSA9PSBOVU1BX05PX05PREUpCj4gLQkJc3ViX3R5cGVfaGRyLT5wcm94
aW1pdHlfZG9tYWluX3RvID0gMDsKPiAtCWVsc2UKPiArCWlmIChrZGV2LT5wZGV2LT5kZXYubnVt
YV9ub2RlID09IE5VTUFfTk9fTk9ERSkgewo+ICsjaWZkZWYgQ09ORklHX0FDUEkKPiArCQlrZmRf
ZmluZF9udW1hX25vZGVfaW5fc3JhdChrZGV2LCAmbnVtYV9ub2RlKTsKPiArI2VuZGlmCj4gKwkJ
c3ViX3R5cGVfaGRyLT5wcm94aW1pdHlfZG9tYWluX3RvID0gbnVtYV9ub2RlOwo+ICsJCXNldF9k
ZXZfbm9kZSgma2Rldi0+cGRldi0+ZGV2LCBudW1hX25vZGUpOwo+ICsJfSBlbHNlCj4gIAkJc3Vi
X3R5cGVfaGRyLT5wcm94aW1pdHlfZG9tYWluX3RvID0ga2Rldi0+cGRldi0+ZGV2Lm51bWFfbm9k
ZTsKCkl0J3MgYmV0dGVyIHN0eWxlIHRvIHVzZSBicmFjZXMgb24gYWxsIGlmL2Vsc2UgYnJhbmNo
ZXMsIGlmIG9uZSBicmFuY2gKbmVlZHMgdGhlbS4KCkJ1dCB3aXRoIG15IHN1Z2dlc3Rpb24gYWJv
dmUgdGhpcyB3b3VsZCBiZWNvbWUgc2ltcGxlcjoKCisjaWZkZWYgQ09ORklHX0FDUEkKKwlpZiAo
a2Rldi0+cGRldi0+ZGV2Lm51bWFfbm9kZSA9PSBOVU1BX05PX05PREUpCisJCWtmZF9maW5kX251
bWFfbm9kZV9pbl9zcmF0KGtkZXYpOworI2VuZGlmCglpZiAoa2Rldi0+cGRldi0+ZGV2Lm51bWFf
bm9kZSA9PSBOVU1BX05PX05PREUpCgkJc3ViX3R5cGVfaGRyLT5wcm94aW1pdHlfZG9tYWluX3Rv
ID0gMDsKCWVsc2UKCQlzdWJfdHlwZV9oZHItPnByb3hpbWl0eV9kb21haW5fdG8gPSBrZGV2LT5w
ZGV2LT5kZXYubnVtYV9ub2RlOwoKUmVnYXJkcywKwqAgRmVsaXgKCgo+ICAjZWxzZQo+ICAJc3Vi
X3R5cGVfaGRyLT5wcm94aW1pdHlfZG9tYWluX3RvID0gMDsKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
