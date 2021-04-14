Return-Path: <SRS0=h6PS=JL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C38BC433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 09:16:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55EEC611C9
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 09:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55EEC611C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03F666E8FD;
	Wed, 14 Apr 2021 09:16:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F15D6E8FD
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 09:16:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9OFyPOVL6JW+MJqsh8VHhGWgAh5hVcod55OBRIymyfYSWTD9Y6s4316jhnxF4QfgzQMR/D2XW+RCFeR+H9C5SublvmmTlGjPQ9nUxBsuslIhquGP5kvUzLahXYTV93DEF2CWJXGz3tCwNxMa/IvpfPPRh/QeAvJ1/cZKEQAJtMRKJM91I69MYc346wJBnw1EjPVmZ4BLQ8GeQi2EKF/Ilqrj/qPPPyPS/JoDcxOu/XpL9t6GckGTpZIfOIgRoAI/nnN95b05fT/SmPImULo6wCAKT4D8kPzmP2NgrcUtHP0Gc65CsW0+06WXi4COd0F6qVt9pLbkJXzgAcX2+HYMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nUGiuUmZ0xzTfXp/lntHQmJgM24DNlkwP5eAKNeVZ0=;
 b=NuSJrFkAOKtdRcldu7hUtTnlrfjMNB8eYII8AVdUGhV0/g/AZS8u+FWWAP9d7ZWEq9hB3d8EQ5CLnUbbfZ6G11HnYBh5azzPlRj1TbPCZ66W0hu3WdeE+fLX7YwJDzbZtZoVrDjfxJEnrFasJRdXZ/r4dz+gwqlIe3+l2VXxZJXhSGJX4CK9IVXD35ep92YPKZ+qg3Mg4YG1efhW83FarjDiOn9BgRhgSTwCxc+oMbH5Y891bb8k2GWHY4xmpxzb3CKxxr5QmcxSRoNiGg9wlUWTG6xoXyeoii5VliP5HiYsNBVBuawaud8GBKrorBoLcn/7mCCjgq5Ry89EK2SSWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nUGiuUmZ0xzTfXp/lntHQmJgM24DNlkwP5eAKNeVZ0=;
 b=FAd8kzeKKAXQy4INcnyxiUGjbiOISU1HqynjT/x7UF7TmGBbci75BlZvISr0G0oDR9az4EhmwN/um57NnkTmndYylZOx2+FBYUY2/1ZCKSzEVKeCQX+GnATeDYku17Mc6NGubtfeIThanIJVUWe8zV26wpdXtOV16twpc5S8cfs=
Received: from MW2PR12MB2460.namprd12.prod.outlook.com (2603:10b6:907:9::11)
 by MWHPR1201MB0174.namprd12.prod.outlook.com (2603:10b6:301:55::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Wed, 14 Apr
 2021 09:16:38 +0000
Received: from MW2PR12MB2460.namprd12.prod.outlook.com
 ([fe80::6930:cfb8:c85b:1fd]) by MW2PR12MB2460.namprd12.prod.outlook.com
 ([fe80::6930:cfb8:c85b:1fd%7]) with mapi id 15.20.4020.022; Wed, 14 Apr 2021
 09:16:38 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Clements,
 John" <John.Clements@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: Recall: [PATCH] drm/amd/sriov no need to config GECC for sriov
Thread-Topic: [PATCH] drm/amd/sriov no need to config GECC for sriov
Thread-Index: AQHXMQ7f1yaD1QNN206w0M3+GfFL9g==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Wed, 14 Apr 2021 09:16:37 +0000
Message-ID: <MW2PR12MB2460D96A62394ED7327A42B29A4E9@MW2PR12MB2460.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31b38bce-0f04-4276-b599-08d8ff260208
x-ms-traffictypediagnostic: MWHPR1201MB0174:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1201MB0174A6C60168B3E722FF1FCB9A4E9@MWHPR1201MB0174.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zyA+5qpM9R2YTHObx4KtXjzuZ0zese4mTXYhl3xz3j1WZDvUuxx7VcJSJ8QThIZsQ4WGp0b6RrlpXFnniSR65ys+VOzVou433MGN/4Jz2HdkjmuoBZxlqCybklTdVngId6VzW2XdVyWTP6p2/QTjp33h7irIhuxEK4F0F5LQg8vlx14GYdHreeW2syW05VZhP0kZg7IVhHumHO/rollIe1xBPeKDarX4wDlfnVFUCPl0Unt54IXTAp/F1kDGKakznh95k2725Odgz330j5Xy4S1wnYLVdvIGybK/zR9E1hPjS9XtqJ+zrA3zuL6tb5V+ua7trTwiz/9k62hIs4jEkrI06TWPj3V9etRp1+7JlK0GE2kQAM1VvGXRoM4A9bMY0gWxXGzPqxE/+s3yja95cNyx7IJnxl0c5Wl+24rV331M5wxTsgyZVL7a+stEq/9TqRofEpAq5fxBr1TFfJ7R1Yb7taKpEHn2aOI9TuZ8SZK57q5RiMDdAHZidRJsyal16tmWb3UARHrGaB0o4Q/xsX8woUaerWBrAT1wdlfehxc40Hqu4HyB76jLnJGdhMuOdvAmgU1a6cc/83j7TCh3l1Q1NtfTRHzKcnHYgiaOdus=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(55016002)(86362001)(9686003)(33656002)(478600001)(110136005)(4326008)(6636002)(8936002)(558084003)(8676002)(186003)(52536014)(316002)(64756008)(66476007)(66946007)(76116006)(66556008)(66446008)(83380400001)(6506007)(7696005)(38100700002)(71200400001)(2906002)(26005)(122000001)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?xC6gHuCnRMQDszamzFUclt8uBxMyzl1fOcBJVQ/ZBSqoMHJAv+xvCko5C4sO?=
 =?us-ascii?Q?+8ft+aNBI9t3JryzI1xIgnwAdzvss/Edb7yROPtEPzebdWY3pg9EUV4aNTf1?=
 =?us-ascii?Q?ipbESFxK0s9LrZPjWZlgKJSoC8gyoaZ0/X/JxiHkZhljNw7Y02D4stSCQct4?=
 =?us-ascii?Q?3Yqzt997wacPo90UTgMBkLT7ecZXDI50QWT91o3arJYiWr2PSx94X+oJJVLx?=
 =?us-ascii?Q?FWzQ0h46aaD6m20GQ5+PksAOxGH4vt4HB33R7596OX3bpvgkocv57uXfnedA?=
 =?us-ascii?Q?wDhqENkh6Z4N5SSvdXcFfAO0lNm+rxcmx3qUY6CNUiQbNbg4B8/1iRg8S82p?=
 =?us-ascii?Q?umwZbOIZrWlFgS7L5hWMQwcRypfInu6R1z3WZK4oNYLvlqNTmFRTNI8/7ISo?=
 =?us-ascii?Q?u9acV/nFTLHfYF9qduoxfPksOsm34e7X7PlqIC4MxezZDLODa3s0+t4ZkCA+?=
 =?us-ascii?Q?5CE4v1+PoOUv4fCizhAjgReKOfzmZA8zT3BqcJkTUHpYvQ6zlsvY15DoGaWj?=
 =?us-ascii?Q?c7DE6mJ6E3mWLrMyF8zYdTlimm55w4mMcDvC71gCMt9ONDRf48u7esWLQ9Ju?=
 =?us-ascii?Q?cfUX04YXmJb2lEWarMALocPG2fH4LGSsOike3HYxpq58d/Z+mZd2UpmdvzkS?=
 =?us-ascii?Q?VsHQfrrQ6xdjK4n2+naLtB4DvOQXxalIZi38l+/lrWol68LT94ds0aSXa5Vw?=
 =?us-ascii?Q?SuBENYOVOJfhBGxcT0BebYlFuK++/646U82CLe4IHmfx2fF/MUDVKYlMSb6+?=
 =?us-ascii?Q?nRUixSJW2H507yu+PFf7EIrCzU2UoWH1vyoFE8XIHmF/lN4Rj83sf1D+kgUv?=
 =?us-ascii?Q?jxh2pFnn/W7rmGf1sfkCYN+fMFVj6Ht2jkPy1HJgyMQgVtNyQEqzNxa/OPqb?=
 =?us-ascii?Q?ZsQc2ds3mFMSeJP6ZgROcFI9q6Fgxw9Mf0TMzhei/6ZrGWXPUMMtcZuniixL?=
 =?us-ascii?Q?/FkUSdBLLROSubJcHE5Eywbw95FrhIzA6XHdRvcQhQLRWkjOiLfuMKS47bxg?=
 =?us-ascii?Q?mtqEXPUSMQCKzLIl/DFkFZGVtSnzpzNid11Mv27xs2iQsg5OmLyVkZ6BJ0BM?=
 =?us-ascii?Q?iTlCyE7bspBCoud/XSD5ncYOXbaG4haomsbjpeHf1rxXC0goxmNqRdaYFmnp?=
 =?us-ascii?Q?pMpYFNsT+EpcdQqX1rGBf+ZyVMQEYmquyRSIRgW6NWcyTWMVnj9+N2VgCo7X?=
 =?us-ascii?Q?gH9Aqezyc+gaIndI68N5bzxxgx3LNzffcd2Cn6zWzY+T97qJnF33DHJT8id0?=
 =?us-ascii?Q?3LXiby6ytLhYlnHot/AAVVdZ70impBKck+dFMv0fts9MWBudFq03Khcbbk1R?=
 =?us-ascii?Q?Dj/j4VHgwW0jrfNU9gcPi7yE?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b38bce-0f04-4276-b599-08d8ff260208
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 09:16:37.8761 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GZE9as4y9rZSSD1o9AMhpEZJ0Iuo16wt0LTvODz5NLiXz3C1S61FPVde6DnxR7pzt3hLKsAJeqjY9rfaZFPu8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0174
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
Cc: "Zhang, Jack \(Jian\)" <Jack.Zhang1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Yang, Stanley would like to recall the message, "[PATCH] drm/amd/sriov no need to config GECC for sriov".
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
