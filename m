Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1865BC47087
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 10:56:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA760613B5
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 10:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA760613B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C3BF6E3EC;
	Fri, 28 May 2021 10:56:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83AE16EEC1
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 10:56:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8rkI7GTrvDYCWJvwUOmcCAe2eAtZs3WH+RFiWbB53m00Dg9PehUQU+CSgxgUS56sTAww9QUnlRjZrL0/KdGaKx8U1fXd4abFfKBYqdDNOkAlr5ZYYDM/Ud1AYGct48wxWhAmcBlgLMW6y1pjSrFEk7TBMnvrrR3QPKA7FyriVFj5xqTAkir2nqUcDWWUQO6k7TmZmaLcS/BnEI6sEWQ3VWTono0IMmX3RAOZshwjjEYETmms1XijIW5j3c0I32LzLtd/1OxQ/IRT7ndbznl7bmgLZZzpgRBljuKeEaA977QxwfjqmsdRyahZ+FHUd2K1Huj/cbwICfgLACmMxsWJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aIebJB0O+m8I/hdQFKtTyHMTuC55Sp9eYCq5UQi+mA=;
 b=LwYzdKrIQ2LufhC90auqpH+sOh66Vxi3xG5pWWSaEMPvJrX/gXR0ogmxm6eSYiXKOXyvVNMW5DMOWcSFz5gUlUxEs1aJbHvdergpqB7c8RCPKlozndj1hP1fuQPPdgODAglLPj0jscCMH/VkuOa28Y21ciXPD4OSvG/ySkA6+Tdh5OO5nNlC7OELg6EZswB9KwfxIyaCs3wVYyvscxseBTzCtMar80m3jm83zfrYNjf1ZwAHT2XdR5HbWP3to9TNyYVGV/GpXtir5f0qpYa/zSSqSkRiqpWHMoykYsTd09oXf2qt7Be7KZ3HwoUou9fqcENIhyXhoo3/omyQ62X5Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aIebJB0O+m8I/hdQFKtTyHMTuC55Sp9eYCq5UQi+mA=;
 b=d1dnCbiiQlcXn9sug8dK6ykc1e5V90nBa0Gk21daFaF1vLdm/0QD7zr28wOyTaLaNVNHE3z/ehQ1zRLt+LSEw6GezQDVPHRLutyN6W5n/a8lFvadFA23c/iI8SAfXkP/Ji1d6itgfujYhpqAK54h2/gqsyYCDl4ih25NK+H71Ng=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM8PR12MB5416.namprd12.prod.outlook.com (2603:10b6:8:28::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Fri, 28 May
 2021 10:56:44 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4173.022; Fri, 28 May 2021
 10:56:44 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 5/6] drm/amdgpu: remove unused code
Date: Fri, 28 May 2021 12:56:22 +0200
Message-Id: <20210528105623.28148-5-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528105623.28148-1-nirmoy.das@amd.com>
References: <20210528105623.28148-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.100.114]
X-ClientProxiedBy: PR3P189CA0081.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::26) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.100.114) by
 PR3P189CA0081.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:b4::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 10:56:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 173fb964-2542-4c62-decf-08d921c7480e
X-MS-TrafficTypeDiagnostic: DM8PR12MB5416:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB5416C2F071355BFAB4ED71538B229@DM8PR12MB5416.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YeeQjAGjF2L90RmEfY7LrX5ejLqisOl9pWlQJtiCU5fcmcQ+JuaiJm60hOHkreNRKjK2FI4R9wA5NpVjSkJmqSOCWeOtfNVnqERARJBWNTF8kwpHKzUk988QFsNTsp7Hk6IIMACuMIUT/qMauucCixa46UFCXGPMyWEvmgBV2/yExsMYKwEhLTnimwYHg7NoZSGs4WLCoLiFmRnYG8glSkaJ53f3kHE14mWtIb37WUz0rOC60fB5mLgn73UsoXJJ/WsfIARZaRxhAGGIK0BQf2YlmYaQ952sem6kZrrLc7tLna4CC5AgCmhRW/CC2vuQprdk66TlqiK8rd4Fw3SN1BfLZNUErntNeLul1xM8BZoXFOpGKhTEG6Tvg2X4mLz1ExOkGnqpCXAJIPG6DaWtxmPcISxk1/SoVwQK8WCELZu5Yp2YpkeazxOR1lC9ylQrMKa5KMBDioeWLBfjtSI0DOOBOls23E/RFdMqA/UJ6AHkMAPRboqu9nOKy2YRQjQGpNIHdQIF0QH2gzECwGPz+1IDUbc+UNtPGWqObNJMAcfcBSfUoTEa2Tf9Z4wCGR2/NoFkZnUT5D6EqgqINc7lCIYM5EYJKsEJCFesTlezEZBokMyRzyUu8n7GZtqsusM7x0B2cR8rqeyrKIGFXsqdB9imRDP11mh91hABuubi0sA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39850400004)(366004)(346002)(136003)(376002)(6486002)(2906002)(6512007)(38350700002)(38100700002)(6916009)(36756003)(44832011)(16526019)(5660300002)(66476007)(186003)(66556008)(66946007)(86362001)(956004)(2616005)(26005)(8936002)(83380400001)(66574015)(6506007)(478600001)(52116002)(1076003)(54906003)(8676002)(6666004)(316002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WTJiTkxwVXY0QnAxb3oxMEcwRnB5VXlobU9YdGZXd2dBSVlRM1BjNkE3eHdB?=
 =?utf-8?B?L3dPZ1hxTE1WSHpWSTlHbVJHamJ1VnA0blUwWWVUdWp4TVdtNHdQb011S2VT?=
 =?utf-8?B?VGdiU0RKaW5kMCtpRjhTcWlVQ3pmYXRLZm9aVjBzVGRVRE5UUGtFMFJML2VK?=
 =?utf-8?B?YnQ0ZGFJT2RtaU54b1AxVXNTVTZlK05idmwxaHdReU1yUEhuSHNMUCt3Qk0x?=
 =?utf-8?B?b1ViNjhCQ3kvd1M0Q0JlUjhGNU1CODBUQWVmamRkQ0RCeXdNNmdlUWZDVlRD?=
 =?utf-8?B?UzhKRGFaU09RVFRYWk4xdzhWWk1hMi9uQ3p0aVV1aWsrYkdzV1IrZXRwRlZp?=
 =?utf-8?B?YzdMYUI1c1N6UzhuWnBxVE9Jckt5UVdhajNSTFUwUG1zTy9mUktUVUFwR1N1?=
 =?utf-8?B?cVF4Nm5XWVFKQkNXcmlZOVlmaTd3TkpWdnZId1FrV0ZoYWpFNzVlNUZkWFky?=
 =?utf-8?B?dk9Nd1F4WnlMRmJvdGtUSlhENHpya1RtOUFzSi9jSnFmdTdqY1h4dW9GT3NR?=
 =?utf-8?B?RnlycWVmVnNSY2tUbHh2aWhDSE5ndG5PeDZxeHdMcHgrc3pGVExQQWpVUm5I?=
 =?utf-8?B?NUd0ejd0dU9ZZWMxUnNZcXVNbGlUbmswOWZDMWFVNWpldmx3QXdGTHlnVG5t?=
 =?utf-8?B?a05weGRHSndkSktJY2VzWVlDOTdBdjhQTUxhUVFHU1l2TDd3bTc0TnlhTGpj?=
 =?utf-8?B?MEF2YVRHdzU4MnZHRGlxQ0VPRWpmRWJvTVFxTGZJSVpYa1h3MlVyZVhzQUNU?=
 =?utf-8?B?d1VZWVhnVFRCN2ZsNlMyR2VIZ1BxdDdMM2FNRHB4cnFSaXlIK1RxSHZhWHho?=
 =?utf-8?B?bVBKMkpMczYxY09meDlnblpsdDl3VkdrWGNVUjhYbjI4NDMvTTlBR2I2REl5?=
 =?utf-8?B?bUhTVlFKWGRYQkF0SlhyaFhwZWZJTWwwYVFUTDJIdVBSdkI5OEJhVy9zNitM?=
 =?utf-8?B?NzlUcFFVcmduc2VhK0FOdm1DazJCSitpbWlBbkdPYWF1Tkl4cysyQVkvVXE2?=
 =?utf-8?B?WFJkZDJLUkV0MUJaMFNLVzcxNzBrYjcrMVY4bU04cWp5dlQxQWNzZ1g0RlZk?=
 =?utf-8?B?OE04VTEzQXdFcHBvL2xZdmpyM2c5dEZpSkF6RSszZkpQUENJdEZHVXF0Vy9D?=
 =?utf-8?B?UUlmVCs2R3VFa1VkdWUvWk5Wbm53Sko2SDR3NWtTSkR1d3FIekFVUHpVQTFp?=
 =?utf-8?B?Si9STVkybytUbCtYN05KamdpTkVKam8zYThKL2dGUFhTMm1NanFYRnF5Zkpa?=
 =?utf-8?B?UWE2Z1lOb0I4Ky9XYnpKUkNONnJRVU14clZ4SE5nVEY5UktpYVlHQ3RkZDNk?=
 =?utf-8?B?RUlRWU83Vzh5bmpiTit0bUN1bmVmc3ZReitIMjRIK3RtQlA0T0h1RGZIckpr?=
 =?utf-8?B?S25lRzVxUjNFcTYxWGtaK0g0MGxoRU9lSEJyNVVFSXVsUDVNQXM3SldxV0Jo?=
 =?utf-8?B?cFZ1dDRhaGNVa3BIaDJmZ0VaRUJrUndSN0pmbUZ5cG5hTmg5L1lBVHJvYm5s?=
 =?utf-8?B?TVF6S3NuYXQ3b1pyVTFNalRHYURncXJhVENJL2ZjTGF3VXFCbVVtQVAxU1FF?=
 =?utf-8?B?L1lqWlVycDY5VFZQMUNPUWFBOGJaNDNiWkwrTXAwZkFKbzh6R1Q1NHQ1eUZ1?=
 =?utf-8?B?cndPSStrUmMvQytob3pJdkY1eXhWUE8zQlQvWHFNZ0dlTXF6T3h6dGp6R0Ny?=
 =?utf-8?B?NHkwNGFNSEtxcVZ4eXRkaDBmYm85REVtVGl3Mi90N2V3bEZscjh1TGNNaWYz?=
 =?utf-8?Q?d2Fzu/Lgu2OIes86E8xoivAXfMlN52qU0kwZtOn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 173fb964-2542-4c62-decf-08d921c7480e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 10:56:44.1933 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ENm8bSPFTA5W04WevOjEoWy1dRH92LZn/WTbm16IMeeoaan2L5TQfQ8xUbsQ6Mk+IWGlCQAJAHYUUlYi55dnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5416
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
Cc: alexander.deucher@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UmVtb3ZlIHVudXNlZCBjb2RlIHJlbGF0ZWQgdG8gc2hhZG93IEJPLgoKdjI6IHJlbW92aW5nIHNo
YWRvdyBibyBwdHIgZnJvbSBiYXNlIGNsYXNzLgoKU2lnbmVkLW9mZi1ieTogTmlybW95IERhcyA8
bmlybW95LmRhc0BhbWQuY29tPgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9vYmplY3QuYyB8IDI5IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuaCB8ICA2IC0tLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDM1
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9vYmplY3QuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3Qu
YwppbmRleCA4OWJhNjEyYTUwODAuLjE1Y2VlNDlmMTFlMiAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYwpAQCAtNjM4LDM1ICs2MzgsNiBAQCBpbnQgYW1kZ3B1
X2JvX2NyZWF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAlyZXR1cm4gcjsKIH0KCi1p
bnQgYW1kZ3B1X2JvX2NyZWF0ZV9zaGFkb3coc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCi0J
CQkgICAgdW5zaWduZWQgbG9uZyBzaXplLAotCQkJICAgIHN0cnVjdCBhbWRncHVfYm8gKmJvKQot
ewotCXN0cnVjdCBhbWRncHVfYm9fcGFyYW0gYnA7Ci0JaW50IHI7Ci0KLQlpZiAoYm8tPnNoYWRv
dykKLQkJcmV0dXJuIDA7Ci0KLQltZW1zZXQoJmJwLCAwLCBzaXplb2YoYnApKTsKLQlicC5zaXpl
ID0gc2l6ZTsKLQlicC5kb21haW4gPSBBTURHUFVfR0VNX0RPTUFJTl9HVFQ7Ci0JYnAuZmxhZ3Mg
PSBBTURHUFVfR0VNX0NSRUFURV9DUFVfR1RUX1VTV0M7Ci0JYnAudHlwZSA9IHR0bV9ib190eXBl
X2tlcm5lbDsKLQlicC5yZXN2ID0gYm8tPnRiby5iYXNlLnJlc3Y7Ci0JYnAuYm9fcHRyX3NpemUg
PSBzaXplb2Yoc3RydWN0IGFtZGdwdV9ibyk7Ci0KLQlyID0gYW1kZ3B1X2JvX2NyZWF0ZShhZGV2
LCAmYnAsICZiby0+c2hhZG93KTsKLQlpZiAoIXIpIHsKLQkJYm8tPnNoYWRvdy0+cGFyZW50ID0g
YW1kZ3B1X2JvX3JlZihibyk7Ci0JCW11dGV4X2xvY2soJmFkZXYtPnNoYWRvd19saXN0X2xvY2sp
OwotCQlsaXN0X2FkZF90YWlsKCZiby0+c2hhZG93LT5zaGFkb3dfbGlzdCwgJmFkZXYtPnNoYWRv
d19saXN0KTsKLQkJbXV0ZXhfdW5sb2NrKCZhZGV2LT5zaGFkb3dfbGlzdF9sb2NrKTsKLQl9Ci0K
LQlyZXR1cm4gcjsKLX0KLQogLyoqCiAgKiBhbWRncHVfYm9fY3JlYXRlX3VzZXIgLSBjcmVhdGUg
YW4gJmFtZGdwdV9ib191c2VyIGJ1ZmZlciBvYmplY3QKICAqIEBhZGV2OiBhbWRncHUgZGV2aWNl
IG9iamVjdApkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29i
amVjdC5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5oCmluZGV4
IDlhZmNjZjZjNjZmMi4uZmE3NTI1MTE0OGJlIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X29iamVjdC5oCkBAIC0xMDQsOSArMTA0LDYgQEAgc3RydWN0IGFtZGdwdV9ibyB7
CiAJc3RydWN0IGFtZGdwdV92bV9ib19iYXNlCSp2bV9ibzsKIAkvKiBDb25zdGFudCBhZnRlciBp
bml0aWFsaXphdGlvbiAqLwogCXN0cnVjdCBhbWRncHVfYm8JCSpwYXJlbnQ7Ci0Jc3RydWN0IGFt
ZGdwdV9ibwkJKnNoYWRvdzsKLQotCgogI2lmZGVmIENPTkZJR19NTVVfTk9USUZJRVIKIAlzdHJ1
Y3QgbW11X2ludGVydmFsX25vdGlmaWVyCW5vdGlmaWVyOwpAQCAtMzAwLDkgKzI5Nyw2IEBAIGlu
dCBhbWRncHVfYm9fY3JlYXRlX3ZtKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCQkJc3Ry
dWN0IGFtZGdwdV9ib192bSAqKnVib19wdHIpOwogdm9pZCBhbWRncHVfYm9fZnJlZV9rZXJuZWwo
c3RydWN0IGFtZGdwdV9ibyAqKmJvLCB1NjQgKmdwdV9hZGRyLAogCQkJICAgdm9pZCAqKmNwdV9h
ZGRyKTsKLWludCBhbWRncHVfYm9fY3JlYXRlX3NoYWRvdyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiwKLQkJCSAgICB1bnNpZ25lZCBsb25nIHNpemUsCi0JCQkgICAgc3RydWN0IGFtZGdwdV9i
byAqYm8pOwogaW50IGFtZGdwdV9ib19rbWFwKHN0cnVjdCBhbWRncHVfYm8gKmJvLCB2b2lkICoq
cHRyKTsKIHZvaWQgKmFtZGdwdV9ib19rcHRyKHN0cnVjdCBhbWRncHVfYm8gKmJvKTsKIHZvaWQg
YW1kZ3B1X2JvX2t1bm1hcChzdHJ1Y3QgYW1kZ3B1X2JvICpibyk7Ci0tCjIuMzEuMQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
