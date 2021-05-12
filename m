Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21F3C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 14:27:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FA256142D
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 14:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA256142D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 995F16EC1B;
	Wed, 12 May 2021 14:27:39 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE6446EC18;
 Wed, 12 May 2021 14:27:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ktk1Bp3p2ZH/zwOCuurfcUnlFQXMAhj06P29c3MCZU6ArpsKIMpWPtvVH8M44Gh4Cj2Zzp3o15F5Y9HQohsH/sx6VDS4VyeVsXPdi251qkMDPDHTbazYE7gtj+YAK+Gr1N4gO049iT5IwnvCb+TMSox4BBNyjPJ5OnDiF+bH48Ujkq44nOfMffqlKF/ZWZSq8i8N+oe1X0BZyoWWM3tQYIoFq+Eps4EicMYHO6Vj57ORfMnNDVusvzG2jZ6LLKwNJVVjicbMFGeSSkYFhzlOOzik+Icto8qTbtLp7OgGBluBkEa7llHXivl6zxQ0kOEojWK5XhF6mPqZW56FzVtnxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsuHwoXxG2GPArc939kNaSlXDwLw+Fkof8ti3WmEEZA=;
 b=TNZ2FXE9QjUl1Xe4Ck/f4obAOyFv8MUe54VDvOY5qAyVn4+ifQq8jby1giUNrNFeXg86AF02TrT6acWB3QE0fRVpGo7WSafTDW7qQLWSxvktV54MG6BcHiOmo+VM+l6sCoP2qFxY9IdA5qz7QTgp6+018MIwsgjYxoX56bO8jum6+5zct4bEQZ5QDCkU/H8nsHVm6qVzqFuB/WRKExGjTQuzGQV8mVlrrKRfBbo7E+8CcqoYuQi/g2g5QV8aD0s1OFPX4GWNtuAFALHvIcuDpG1Yn+7ctU1kzt+yeIznTt7WDacxIu+wLkCInggbYWtn4vtBTwaVLSlPEclNNCQjXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsuHwoXxG2GPArc939kNaSlXDwLw+Fkof8ti3WmEEZA=;
 b=z2Z8DPhzF4Ztx63weg4NF1yA/a0sSiYhQPMy8ULpPIiCqcl3t59QbWPyDoojpMeBjkSlAZ2aIfm5zi7I7UhAPszzVDz+b5gn32eibXPX/5ZJdoLuQ2lLME/mSljYGWQ7sv7Nrm6JSAZZITKyBSxmqFpX1Y6WkjZovApyYs+6a14=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB2845.namprd12.prod.outlook.com (2603:10b6:805:75::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 14:27:35 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c%7]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 14:27:35 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-pci@vger.kernel.org, ckoenig.leichtzumerken@gmail.com,
 daniel.vetter@ffwll.ch, Harry.Wentland@amd.com
Subject: [PATCH v7 11/16] drm/amdgpu: Prevent any job recoveries after device
 is unplugged.
Date: Wed, 12 May 2021 10:26:43 -0400
Message-Id: <20210512142648.666476-12-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210512142648.666476-1-andrey.grodzovsky@amd.com>
References: <20210512142648.666476-1-andrey.grodzovsky@amd.com>
X-Originating-IP: [2607:fea8:3edf:49b0:7576:4f76:97d8:1487]
X-ClientProxiedBy: YTOPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::45) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from agrodzovsky-All-Series.hitronhub.home
 (2607:fea8:3edf:49b0:7576:4f76:97d8:1487) by
 YTOPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::45) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.30 via Frontend
 Transport; Wed, 12 May 2021 14:27:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bec6a8e7-d976-4c93-9d8e-08d9155215ee
X-MS-TrafficTypeDiagnostic: SN6PR12MB2845:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2845982DF4DE627C8446465FEA529@SN6PR12MB2845.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aOnQuY4GtXVhAzs2cVIDlW15ErGYjE9IiIOxxvp9z3jvdEctnikmIYr3Wy3jdWv0n6zUUscxqbUViOO4hCMCX8TL2VaWMzhu7FXEIvt8C6hbRQ/Za4LntQGGWEozvyhGYEuFNUTbr6zjMOlMvuo4Zeu86OZmMhhqsVro1EUX45uGIXVJvSIM4pUnMKUCbQR99NgpTupY72AW+Qsr3YUjpe6X5A7FJaezPT210MWl+MqffgZu5PD8fhR76O5APoHO9dhrgOEpWmvsWnyOGWvevLgj2SPUy70/BSsLuEJcchbGqFgVgAIfgnedG6NNf+EBBzYy9Bwn7dCp9nTJY9VFtNebdH3PewFyBilgcyskZkcAPP3IAMZGYEuyaN8kS5kYoqA//6gTNXi6IMyjWHOiRZ1pn7cdTtEVqL/zaDYU1gl1GL8kOtnmmBbG1y0HoJ3Gj7IynnQf+6CZ5NduuNz4vMEyaiiSQYqdslXUc6HIbwjkHyBADTidUNkhtwmxfGkoc6uJGLEAPPhStsyWcXIhNGOOMmqkcL8fi2+slM2KtS/OzaVpBwffKPAK8IDJIOVRFBGrTOkEk+0GO/5dVWkESmtQN93IHGSLUqrYaX3jryY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(6486002)(8676002)(54906003)(316002)(6512007)(16526019)(6636002)(478600001)(1076003)(186003)(4326008)(44832011)(2906002)(6506007)(8936002)(5660300002)(2616005)(38100700002)(66574015)(36756003)(86362001)(6666004)(66476007)(66946007)(66556008)(83380400001)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MVBvaXZDaENWcU82SnVlejFXNDU0NmJWNlpJTkhNSGlGSXVKbFlwRjcrLzFi?=
 =?utf-8?B?YVlyd0ZMYXZ0UFhUVXA1ZC9UalMvNE5rYVpzaXNtRXpiQ00xTUltRmxzWWJ0?=
 =?utf-8?B?em1jMUprTTNZaUFBemRFSzJmamZzQ2E3eGsvR2JQOWppMWRLTm9vZ2ZFRFZY?=
 =?utf-8?B?bzVIYWQxRGRPSE5Yb2JyQ0VqU01Sb0xwMU4rVVBHZWhGMnZuV3FYQ09lWjgw?=
 =?utf-8?B?Vzl0SzFqTnB5YkkrTCtzM0hMVWZFQmhPMlRyWUpFY2dCKzlxWVRkSlNTYktD?=
 =?utf-8?B?VlNkeEZUWG1ydGJodTNNTVNZeFBQTlJOZHl2dE8vYXpHVHhUNGpTMkt5Mklu?=
 =?utf-8?B?UlNLQTliOU5Lb0FIazZocVkvNUIwZ3VPOUJaZWE2Y2xqQjRSVWpQVGphdXpQ?=
 =?utf-8?B?M0prRGlzbDJWcEc2bURXUnJOYmkxdTVOSjNqTEpWYUo1eHRyNERpeEY1K0N3?=
 =?utf-8?B?NEFFV3IzSGlHd2t6Nml6ZjdEQ0MvWEVvUXozUTFMbUxaR1ZISGNLb2lGNFJl?=
 =?utf-8?B?a2JSeHc3S25DMjFDMmxLTTEvVUFUNWhhMTJWb2FnRitOSWpwWWdGUUI5Wmha?=
 =?utf-8?B?M2w0VDVBVklsaHBjeUx5WVFhZUQxVmJnZ3lLdzNNVWEzUWhEZ0FEM0RwOTJi?=
 =?utf-8?B?bm5NTFo0OUNKZHA1T3BCQ1FTcGcxZzBraFFCWnlGbENYanhSek5RckdMR29i?=
 =?utf-8?B?RnVWL0JZVlEyTnlXeVlvanBtSGpsZnJrUkNDaG5Pc2FueFQ2cXRhV3p4SlJj?=
 =?utf-8?B?Tlk3MlJPcG5vWFBNdlk2VGQxajBjYjUzcTg0emsrTWtPL21SbllUcnVta2lF?=
 =?utf-8?B?M2ZvYUh1aTAwVHNGNG9NMlkyTE1wa0wxR0gyS0VKSWJvQSt4U0ZwUWpHQkhY?=
 =?utf-8?B?REZrQ1hwdTgwbkNNbm80aGNEMmNnOWtXSTdrRjlQRDlMdnpybUhUVXd4MStO?=
 =?utf-8?B?Y2ZCeCtBRGxTNWZxUGIvRlM2anYwbkRmbnpkRlNDL3RhYnFncEs2Ym5EbDB4?=
 =?utf-8?B?QXhMR3hDQUg3MUI0ejhjUUErSVlTVWU1bUFkSFhOckpiSFBqRC9jQWkyOENX?=
 =?utf-8?B?YXV5aUhReUFEWFdmcUxiZzBOcWIxZDdvVUNNNVQrTDR5UEViZ285Q3dvN1Iw?=
 =?utf-8?B?R1A3ODlaQmpzTndSWGZnd2ViNXZrR21KMGVTRGxva3ppdzQwRFZ3YzcvRFlv?=
 =?utf-8?B?ZEZ3T2swSVREVWs5cytzd0FMSVp4K05kaXQrUEhCS21qZ1pZQjdvQTQzTTVV?=
 =?utf-8?B?b1M4V1pmbWZrSE5YaUsvWVFYYU1kNU1CS2o4WmIzSmlEZTBmNmdSM3VTdzVa?=
 =?utf-8?B?NHl1cGRhR3FyOWMyaDNUdVNBVFVraG1nWTI2dVpadngvV1k0QTAzczVpYVgy?=
 =?utf-8?B?aTVIUm9oMUp1bUhBVnplK3hMTTFOZnp3Z2hRVzZZY1hWNFdTVjdndWh3c1Br?=
 =?utf-8?B?VGpyUERtY3E5RVNUd2VWMDN6SHh4QmtvUkkxOUVWQnNNQnVGeVJGdDYrL241?=
 =?utf-8?B?S0xaUGlxbEZyTUh6MlpMS05KYWRyZ3U5WHJKZFlkRm9IdWx4dXBrcUxoaW5E?=
 =?utf-8?B?aEFPc3ovTUgremk5WEFtdkhzYzUxU2dVdHI0TDNua1ZkclFJUFBFMU5iUXp6?=
 =?utf-8?B?ZjVvT3lGd0hNRWdHZVYzVDlUVWxVSm9DNDl6eitCQWNFRmtjQkZ1ZmdjMGxk?=
 =?utf-8?B?UitEQWpqVDFWNE1Kd3c5QkZuWFg3RFRUUWRlRTZNbzRFdW5jWWtGeHAyQzZW?=
 =?utf-8?B?amV3bXdLVmNVakRxTUY5SjdIa1ZrWURtWUlkUW5zTlFoeksrcFRHYUN4OUVS?=
 =?utf-8?B?cUZvMFNaSEFaNE9CQmMrUHFDYXdqdllNelFGS3JvelBSc0IyZnNvdnpJZUtl?=
 =?utf-8?Q?9IJ19RJfPzUM0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bec6a8e7-d976-4c93-9d8e-08d9155215ee
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 14:27:35.1045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oOrrNCm3WrW2wSyBewI0vkE/bro2UGoAG67AedeQw7YjH0exhdt5Sbj2FNTAONp6UcR2niWdvgsBp0dP2jnOWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2845
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>, gregkh@linuxfoundation.org,
 Felix.Kuehling@amd.com, ppaalanen@gmail.com, helgaas@kernel.org,
 Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UmV0dXJuIERSTV9UQVNLX1NUQVRVU19FTk9ERVYgYmFjayB0byB0aGUgc2NoZWR1bGVyIHdoZW4g
ZGV2aWNlCmlzIG5vdCBwcmVzZW50IHNvIHRoZXkgdGltZW91dCB0aW1lciB3aWxsIG5vdCBiZSBy
ZWFybWVkLgoKdjU6IFVwZGF0ZSB0byBtYXRjaCB1cGRhdGVkIHJldHVybiB2YWx1ZXMgaW4gZW51
bSBkcm1fZ3B1X3NjaGVkX3N0YXQKClNpZ25lZC1vZmYtYnk6IEFuZHJleSBHcm9kem92c2t5IDxh
bmRyZXkuZ3JvZHpvdnNreUBhbWQuY29tPgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8
Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9qb2IuYyB8IDE5ICsrKysrKysrKysrKysrKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAx
NiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qb2IuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9qb2IuYwppbmRleCA3NTliMzQ3OTkyMjEuLmQzM2U2ZDk3Y2M4OSAxMDA2NDQKLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qb2IuYwpAQCAtMjUsNiArMjUsOCBAQAogI2luY2x1
ZGUgPGxpbnV4L3dhaXQuaD4KICNpbmNsdWRlIDxsaW51eC9zY2hlZC5oPgogCisjaW5jbHVkZSA8
ZHJtL2RybV9kcnYuaD4KKwogI2luY2x1ZGUgImFtZGdwdS5oIgogI2luY2x1ZGUgImFtZGdwdV90
cmFjZS5oIgogCkBAIC0zNCw2ICszNiwxNSBAQCBzdGF0aWMgZW51bSBkcm1fZ3B1X3NjaGVkX3N0
YXQgYW1kZ3B1X2pvYl90aW1lZG91dChzdHJ1Y3QgZHJtX3NjaGVkX2pvYiAqc19qb2IpCiAJc3Ry
dWN0IGFtZGdwdV9qb2IgKmpvYiA9IHRvX2FtZGdwdV9qb2Ioc19qb2IpOwogCXN0cnVjdCBhbWRn
cHVfdGFza19pbmZvIHRpOwogCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gcmluZy0+YWRl
djsKKwlpbnQgaWR4OworCisJaWYgKCFkcm1fZGV2X2VudGVyKCZhZGV2LT5kZGV2LCAmaWR4KSkg
eworCQlEUk1fSU5GTygiJXMgLSBkZXZpY2UgdW5wbHVnZ2VkIHNraXBwaW5nIHJlY292ZXJ5IG9u
IHNjaGVkdWxlcjolcyIsCisJCQkgX19mdW5jX18sIHNfam9iLT5zY2hlZC0+bmFtZSk7CisKKwkJ
LyogRWZmZWN0aXZlbHkgdGhlIGpvYiBpcyBhYm9ydGVkIGFzIHRoZSBkZXZpY2UgaXMgZ29uZSAq
LworCQlyZXR1cm4gRFJNX0dQVV9TQ0hFRF9TVEFUX0VOT0RFVjsKKwl9CiAKIAltZW1zZXQoJnRp
LCAwLCBzaXplb2Yoc3RydWN0IGFtZGdwdV90YXNrX2luZm8pKTsKIApAQCAtNDEsNyArNTIsNyBA
QCBzdGF0aWMgZW51bSBkcm1fZ3B1X3NjaGVkX3N0YXQgYW1kZ3B1X2pvYl90aW1lZG91dChzdHJ1
Y3QgZHJtX3NjaGVkX2pvYiAqc19qb2IpCiAJICAgIGFtZGdwdV9yaW5nX3NvZnRfcmVjb3Zlcnko
cmluZywgam9iLT52bWlkLCBzX2pvYi0+c19mZW5jZS0+cGFyZW50KSkgewogCQlEUk1fRVJST1Io
InJpbmcgJXMgdGltZW91dCwgYnV0IHNvZnQgcmVjb3ZlcmVkXG4iLAogCQkJICBzX2pvYi0+c2No
ZWQtPm5hbWUpOwotCQlyZXR1cm4gRFJNX0dQVV9TQ0hFRF9TVEFUX05PTUlOQUw7CisJCWdvdG8g
ZXhpdDsKIAl9CiAKIAlhbWRncHVfdm1fZ2V0X3Rhc2tfaW5mbyhyaW5nLT5hZGV2LCBqb2ItPnBh
c2lkLCAmdGkpOwpAQCAtNTMsMTMgKzY0LDE1IEBAIHN0YXRpYyBlbnVtIGRybV9ncHVfc2NoZWRf
c3RhdCBhbWRncHVfam9iX3RpbWVkb3V0KHN0cnVjdCBkcm1fc2NoZWRfam9iICpzX2pvYikKIAog
CWlmIChhbWRncHVfZGV2aWNlX3Nob3VsZF9yZWNvdmVyX2dwdShyaW5nLT5hZGV2KSkgewogCQlh
bWRncHVfZGV2aWNlX2dwdV9yZWNvdmVyKHJpbmctPmFkZXYsIGpvYik7Ci0JCXJldHVybiBEUk1f
R1BVX1NDSEVEX1NUQVRfTk9NSU5BTDsKIAl9IGVsc2UgewogCQlkcm1fc2NoZWRfc3VzcGVuZF90
aW1lb3V0KCZyaW5nLT5zY2hlZCk7CiAJCWlmIChhbWRncHVfc3Jpb3ZfdmYoYWRldikpCiAJCQlh
ZGV2LT52aXJ0LnRkcl9kZWJ1ZyA9IHRydWU7Ci0JCXJldHVybiBEUk1fR1BVX1NDSEVEX1NUQVRf
Tk9NSU5BTDsKIAl9CisKK2V4aXQ6CisJZHJtX2Rldl9leGl0KGlkeCk7CisJcmV0dXJuIERSTV9H
UFVfU0NIRURfU1RBVF9OT01JTkFMOwogfQogCiBpbnQgYW1kZ3B1X2pvYl9hbGxvYyhzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiwgdW5zaWduZWQgbnVtX2licywKLS0gCjIuMjUuMQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
