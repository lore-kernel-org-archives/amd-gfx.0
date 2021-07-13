Return-Path: <SRS0=Y2YZ=MF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E00C07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 11:21:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A2BC611C0
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 11:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A2BC611C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F7F86E07F;
	Tue, 13 Jul 2021 11:21:13 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2060.outbound.protection.outlook.com [40.107.101.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 966106E07F
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 11:21:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fk7nKIaNQY8/HEMLQkdV5QU0e8kKW0XbrlDnTwJx1n0x242D8d2L2xoj+zVFDcrTXGMcGD+UThhM48PVx5cM5UGYP5can8SJj1cch/WQsb48s2W0Vc5ZeE4Rhkt4RqQRYMlS+AZzd2M+63Z7B3jYRxAg7UIBAr1ivcPSYGg0aIwIryYfzRBFacDrJj1dCjzdvv9EYdEmQ2nE07rpSjxHt9JwGcBH5RMax7+qVRZGWJnzK1uxWDPDyoH09rARYFbdYa/9LdAlNsEXXNfHk0AnERU2HnYuVP7VwGkQheIOyQYgRn3QiIC0uIWdzugHnFFqdbh/3tTfNJYUb9P6zNiZHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sanVA7dEwMb9Nkq1SDixTuCBHEaKNAsskhYtQvG5cA=;
 b=dOKg7/7sY/A4q7co9y1tm7UyiVl9IZSOZE7F9SIpi5A7/m9sBcpeCVr+2zUl2deC2J1mIsYgP2iHDV/fcZDpBq4K3RrIB79fG6u4sA8xp5P6/itSH1YjEUfWOf3A9hErjSSWRsdKGysvtfuj+k9eHAD4mpzduMjWF5ufOIbBwJA7H5KmJi+Z2RTF/ywBaLu4XNi5j0Q56AJZP87J1LmlUjBoyYPTnX5GRsSWEDHOZu69u/gBGBCNPfNNdCko0+NN2OWzWfinlEQ2iC3oSGvzBRhMHVxO4z478LAFLjAbZ2Af9f3Jssuep8vvENeq9JpG+f2U+Fl4/oJEut1pGsOMlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sanVA7dEwMb9Nkq1SDixTuCBHEaKNAsskhYtQvG5cA=;
 b=MvTe8F+CM2LDq4sou/zSxXbjSpe4wN2GpYs7OaNfOEpONWXlAl15b+AixK7aXuJn2y0FyqFUoVhsd0gZxN1ftfHB1POYQQrCp2lNfQfuRWiksTTXyafzgGH/aP6Ajuhb7wqejRF9/vAClMwl0XaSAEeD+od8aL5PbAsWjf2tRG8=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5036.namprd12.prod.outlook.com (2603:10b6:408:135::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Tue, 13 Jul
 2021 11:21:10 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5dd:148c:8b35:b31b]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5dd:148c:8b35:b31b%3]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 11:21:10 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Recall: [PATCH] drm/amdgpu: Resolve bug in UMC 6.7 UMC error offset
Thread-Topic: [PATCH] drm/amdgpu: Resolve bug in UMC 6.7 UMC error offset
Thread-Index: AQHXd9kuDh//pJvGTUWvp98bJ315PQ==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Tue, 13 Jul 2021 11:21:10 +0000
Message-ID: <BN9PR12MB5257989C167F6CA0786A14C4FC149@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f7c62be-e6a9-4e42-3a2e-08d945f05112
x-ms-traffictypediagnostic: BN9PR12MB5036:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB50368AF80FC92F7687054F4EFC149@BN9PR12MB5036.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V/1Zm4wjmDhPMZVSgPLZrvyp2Z4hiDsVjRC7S9AaKXii2n3+kO61EM+XdMtmACBUYBZ4n43oi1olTqxKMLbjQydue4pvIV7RfstsXOheQXY+PdPqc4IP9M7St3PNnsIi/SqFHGP7defU9g3ArxugGuY45o+Iey5Me2My+E6RljdU7OfCnQ8DgADpzyRYBRbc2a47PocGFBUZPNQuLJez3vZs6F+kxrsLrjXC0d7EEw9cGunLZxp0n495SNvaZcFsKYyKeR4UdHU0+2Ww9T6BYslHlzJSx4SPDbdENewULhlhE48F5u/s0taFezS4uxfeup2Og+mubXeIrDPnjbWKMnaSEcG9keNpYSsylyeN0ZmQLWhxQ2K6b/UZubtCKcI6LL647EZhMJeM+pNnR9u8m1r8x9yOuq6TAljdRJmnu2bQG6YK1yN+0DyWoMaWhkIeRwQNgxEhMOZfM74qN8RoyTFcjWSNyy9QTkfB52t4DKm0iMzZM92O5uHSCY0uxR+L7FKPofzi1SP+rHxq0T0C4nUfG8gyAVFymY3czr/8XRBg6OBhi1QDPVBVjH7PDBX7T4vG6wnyPgoXeIdkZibzS1LZUZnQw2b4pZK/4cwTntRWyUbz2wpTheRzDou+1sJP7JBITBRcYIf83c4CbOgoIA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(5660300002)(8936002)(55016002)(6506007)(71200400001)(83380400001)(66476007)(7696005)(186003)(558084003)(66446008)(9686003)(38100700002)(478600001)(76116006)(8676002)(26005)(2906002)(52536014)(86362001)(110136005)(64756008)(66556008)(33656002)(122000001)(66946007)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MSsX/83LQQOKNGya6WHEODBSrk3oWLxWkvIhD7T4ITv+qKXqueqqvU+DUN?=
 =?iso-8859-1?Q?KDqXxuurp8b2QB1UgGtpOGe2WVVyYcSTzvmR0mG9SfoxjsCOOLj1Lx/t66?=
 =?iso-8859-1?Q?jAI84Ms24nHTrD0vqJ7BsAoxV85uN9OsZxIrNLNk0K+huttkCLr1X3/Jzh?=
 =?iso-8859-1?Q?0CFU4OV0LcEkZJBAY46wyRV2TnYTFFeVSg6XEtLXF/lMy43+rf5mJGUIqf?=
 =?iso-8859-1?Q?YJ+Q21voMMjB6QGNCrFl7VozuclZOCkDky0XQxzCF0awz5hiGzvR56Ie0G?=
 =?iso-8859-1?Q?skAAy5Qp9x6rxQFNT7sFsRTkMGUDzde/bhjpMKruH7Sb5jB7hHQMDxHICw?=
 =?iso-8859-1?Q?kjFS+x7Tnbbmq+wLW7TAFcdpuK0TYiWh+z7BVn2kyKTHthiN/ivgl41kqL?=
 =?iso-8859-1?Q?4mAS//gapCfculixSLYC5MLClR+OwRtBX93PQvG+th6BxaLUYJoHbvpekV?=
 =?iso-8859-1?Q?unGl2dD9U1XDSNnq5FnUm2l9tbk5aMA0QSKpDTJxZjtC8UWYLL0whajO/i?=
 =?iso-8859-1?Q?BPzF3fJ/RMaA45AxJQkDoAb4OzE8WhJ4nztvgB97khQD7v5wR7v7OXyW7D?=
 =?iso-8859-1?Q?qliQn/snLLYcE1KTGMR33XYARkqFe94YIeZv+aGNdZ6rCtkqkMKESS02yj?=
 =?iso-8859-1?Q?0rU7uQc5nhnpH6u8t9rSKd29cirXtjDaNGUc3mQfRiXw8EiVznDnXd4iRE?=
 =?iso-8859-1?Q?K5XoTaidWm9vK19DJpWIsuVHG28G3aTYWWQQOrRJxQ/vlx/q1NeNhsbvAL?=
 =?iso-8859-1?Q?+pQFSLkL86OUZsi7Zj6nt4/6nMUu872ykYyTJzcT5J6Isa5mXRhJGOTjVV?=
 =?iso-8859-1?Q?enCIm6gKuu3wV/NqcibEFQcbP98k5xWx1UOTuXJE8I0shytALOCD+EP4z7?=
 =?iso-8859-1?Q?CP9V5RTcoNtdD0onLNmcKpMxZiCNpnEnq5Dh5Ie4G/ws1nCo1MKBpHOrxD?=
 =?iso-8859-1?Q?MesaVM0uM/kgkmszVYXZWkRrODoNdPeOWm3jIOrXejyVZ+GvRN0khVk9y8?=
 =?iso-8859-1?Q?0/ukA92EAGgI3NKYbtpH/45KVzuSQ7l2XQ0XLnenNU9EoSMyA8NyoPxFcr?=
 =?iso-8859-1?Q?OHZMMU6DRb7DocOjK8dDX7JTjUIarjyF/AfBe/lUCBJzKKBZ+E3MT0faaO?=
 =?iso-8859-1?Q?2sfX1prSAiCPtrMIHycxGMD2G6NreoygFwIlT4wyStnjVwj1aqy3U3SWlN?=
 =?iso-8859-1?Q?XX/24Xy4zWAHTwh3NgDqrrCZmEWjjRjWd5HDB2oPzwAK7TGY8U3cx8nGtw?=
 =?iso-8859-1?Q?LpWr/qQkg31rgm7zzQSD8Qmtp09aESpcBa7sLPmOjXIStdWyiWEeLxRqVu?=
 =?iso-8859-1?Q?1ouYuCPNNhi4VN3A8g0qkIG8LNDmnxOccm0Oc1ig2DdM4AETPRLTSYwVJO?=
 =?iso-8859-1?Q?JoQd4fmynF?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f7c62be-e6a9-4e42-3a2e-08d945f05112
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2021 11:21:10.2818 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lg5HuafQFdbt+C9/+C0vpJ/uZcrx6AD3+pqLfVmV7Zp/6CE17dEajNpSZFGpG1dGaKmCXmQUmZhL/C+rb5qgDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5036
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Zhang, Hawking would like to recall the message, "[PATCH] drm/amdgpu: Resolve bug in UMC 6.7 UMC error offset".
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
