Return-Path: <SRS0=VH8F=JF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C58AC433B4
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 18:58:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E53F1610CF
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 18:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E53F1610CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D8E36E064;
	Thu,  8 Apr 2021 18:58:43 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A471A6E064
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Apr 2021 18:58:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jmvcZbjKt3Q6M4JrKK1HpYRg2I7DwJ+yjrJDX6xTYK+gEgGI4uZj2wiQUdDmZQsMITt9Nce5h88JyPRkCtye0aryN76iyb0U9aS28QsFdmQrLvAMirb8krePiyjLXaAyZJqMZ/6lQNgWGwhkFKWIkLt/yuJjy03itS0pglBDkiAa0UHjVUp7Eu/QHSDbyZsRQ7O4DWbmSa8zdyLBdm7s3wlM+55HhWRtdGV1RaoA6WzQBlNaFpgGgKFpayo0m2rYQTIDlf5KZsrSWrPBH/mgeVH1zt4LV9MrINaP9ZlAVU+41MwnydcE3fHDwfsEs0Cpn7cvjWTRf8DAhDXT4RF8VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9MvuHELmUI6F3iNsdn93BEObyP9yEWuWRUKKQfSRMM=;
 b=W8gsBbGSp7zAhkmT05yVWqPYMY3nnagrpCm7rsDn6bDUSgr6Wqyea3EOND3z3OcFD3hW6k8wvFN0dCj94O/MKrBFzpWLuL9MRGLnbMKcobyUEnc46uJTrE/aOw4J3zuoW4Mb7vdsv3pXItT/s+3x9oiOTAH83jmiB1lTZW5RUzTjbo5N3JSwVUNKS9dOf6Sy1DXuBUcn229JDcQ8Uj7D+LSM1VUVWW4VymdfPVU47L4TgsuBSHJf8LEQUiQ5j7YnVYOQb2Zzs9oQZzU4I70/U17D/RmwfZCU3dyYxc/QdSwXsrXKZOv06v8mKgMpK7DxXKtTS1zBw0kr6QOgPmXJ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9MvuHELmUI6F3iNsdn93BEObyP9yEWuWRUKKQfSRMM=;
 b=dki5l1Sc4zjEZA30hdesbB6oGsVQVkaE+5Pwgp1XaHTPJ+GywzfmyRiALhTd+KEWL8Og3j3KpRiIerNSxnV6yStNLwsyNY1tLnQ95CNnE6UiaEYMhlWxuCf3OQWCGuJhcFjueowMYnYtrLjZsWBZ3NQIfNa+BXTu4D1c9gIDfoQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4963.namprd12.prod.outlook.com (2603:10b6:208:17d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Thu, 8 Apr
 2021 18:58:40 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4020.017; Thu, 8 Apr 2021
 18:58:40 +0000
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
 <d40648ba-9948-5442-23ed-d352f824f8f9@amd.com>
 <DM5PR12MB25330F3CD92C587C2E921424ED699@DM5PR12MB2533.namprd12.prod.outlook.com>
 <MN2PR12MB3775531A74B886A207134B1583699@MN2PR12MB3775.namprd12.prod.outlook.com>
 <DM5PR12MB253379E8C89D8A20C8A0245AED699@DM5PR12MB2533.namprd12.prod.outlook.com>
 <378fdffb-99b5-2a14-736d-a06f310b040c@amd.com>
 <1e37bb4d-f54d-1b7e-4632-94cfcf749528@amd.com>
 <51d7873d-cf35-6be5-79c2-024937c67f6a@amd.com>
 <29ffe63b-9049-824f-84fc-a92fdb451e0d@amd.com>
 <e37bdceb-cdb2-a826-21cf-8cb88748be08@gmail.com>
 <1e4b766d-b5c2-e6b5-8be6-9b2fae3abc94@amd.com>
 <b67ab565-e4be-0809-7021-cb59fd10464a@amd.com>
 <8c2cbe39-ea05-add4-efee-65527e53bb34@gmail.com>
 <50e0907c-52d6-1fdb-aa5e-39b1c326180c@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <4a1e3961-8708-46b7-bfd8-86a4ee4e2726@amd.com>
Date: Thu, 8 Apr 2021 20:58:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <50e0907c-52d6-1fdb-aa5e-39b1c326180c@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:33cd:ea30:2a78:1446]
X-ClientProxiedBy: AM4PR0302CA0020.eurprd03.prod.outlook.com
 (2603:10a6:205:2::33) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:33cd:ea30:2a78:1446]
 (2a02:908:1252:fb60:33cd:ea30:2a78:1446) by
 AM4PR0302CA0020.eurprd03.prod.outlook.com (2603:10a6:205:2::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Thu, 8 Apr 2021 18:58:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d06c6ce8-3216-497f-2907-08d8fac0525c
X-MS-TrafficTypeDiagnostic: BL0PR12MB4963:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB49639273790092113972E8F583749@BL0PR12MB4963.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2RjLzfsKuM9iHb5jyaQVaSMhFwK2aMXQ38bVHuFQcvkxmg6Cg3uelXbJ2w87AJnEq7a1IkbOYQHIdBBSFxchGbyd4hCegYdRGUiN/SVaPYt95yWo+F6tRgzYzXo0wU0095RkGBY1kghjXn6erB6pR7XeAg3Ocws9pPUS6wkKfNXj1tFgikIKVGnXT2uDiMLUV9A9ltGTe+XZ6gHc5YfN4g5OgLvqDwP5r+F5IYrOGzmTpTCwYnjhMxfFw9JkStDwPRaV/xvsTnl1ZYX6sgrIDFuDLufZWqPzoPPlA2QyfxpqWXq6cNHzXHqGWaM3TZM51B6i5V0YDKhOJPPSm2dQRsVmdRRGGAT/vqMdu9DP3ppiw9y0T8XaR53ZJpg1cZEH9iK275DHwDlOEu3P0HWROXelrxqdQeCIFwei53rDdQmBYB+9Ldv4IsfcQtsXxxjGF3cwVDF4UCWXgGxXzi6TStt7DQazTVoeOVNKiHkQV3vJrdDjUwKKXZJu+drSY7KE3Jb2qROTyrnEPq47/lXrg78VUDfs/CZkhZoYlcnYHQLH9GDrwcyy89mL0MkuWKvRTfXuyw9NsE+X0Cey3VITxySx87QHiqOY7/UeeNdZr0FkKY3iqO2ijbaslhkCJthRD2ZfGcyhXa6weWsT3sMGPSIktgcZejp5q/B61k3r01i0B2+I4VaOIkO4RDrBCYpChb/GFR+mKEsSSTExaB3a5Jc7Uuvjuvy/7AMCHQxCsBC3lJAI2LSxLzMsFu06hsbdutoYFeS9FYS8kU6mFDmerA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(53546011)(66574015)(16526019)(31686004)(66556008)(2906002)(6486002)(6636002)(8676002)(52116002)(186003)(478600001)(31696002)(38100700001)(966005)(316002)(6666004)(86362001)(66946007)(36756003)(83380400001)(110136005)(66476007)(5660300002)(2616005)(8936002)(921005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?K0hqS21IelFBb0tjSndnNVZkOVQ5NlRyLzlSeVM5TlhKNmI4TDdFYnlDZG9I?=
 =?utf-8?B?Sm1URFRYbmI1a2pQMDRYa2Y3dElNaVdXOGZNUU5TVFlEWHlsN2VsYzZVbnll?=
 =?utf-8?B?OFdseTZ4M25ObzYydUdBZEJKZUVmM2hSZFlGZWxubzB4WHVwWkdWWHFWa05J?=
 =?utf-8?B?NFI5QjJmVi9MYUE3cFZuaG94aGhQTzk3anVMM3QyQ1plS0pkQ1dRQ2VjTmRj?=
 =?utf-8?B?dzEyZFo2ZjFqN3JDNnh5Yzl4ZXJ3dWtEMG1hZFljamp0YXdINXdyekhkZE5R?=
 =?utf-8?B?ZlBxdEJzQksrWW5lcHE2SXM4QWs4djZja3NSRTBUVFZRallLQUtENFVobUNk?=
 =?utf-8?B?SW41MW9pMHNjY05VdXpZWStPUjFEQkh4Q2krMUFieDF5RDV1UmNxTnk1RnEv?=
 =?utf-8?B?T0FYT1IvNEtRWkJsdnZwQ25BRThEek1NWXg1Vm94bFZqb1kwZ09pTW9Qd3BD?=
 =?utf-8?B?RElrdWlXTk54a0pveHJhMkI3Z2llOFZXRzlQUVVCeGMwajVFUHp2SC8yckRl?=
 =?utf-8?B?QkpOTXRQdFhHQWZBNHY3VmVFQ1RDT2RIR0FEWVRSS3ZDRCtrL3c2TERNV2J2?=
 =?utf-8?B?MmRKS2tndFFxVFJ0eU93bkIzY04xQktGQVpMR3U1OUZjcVFnR1ZhQytHTmsx?=
 =?utf-8?B?YWlxYmpPczNaNEtiNVNrK3VBUzdXUkhiVGJudVRybC9QaEZhTUtuRW81VGp3?=
 =?utf-8?B?TmcvNWd0dXBCdGQrdUhMQ0xTZ09mWFpGSWU1ekE2MmprZjhyMjNaMFh2Ykxr?=
 =?utf-8?B?YkVMWDQwNWZqQTVvMTlya0hRSko5cW1ITnFrU01hZ1k1Qit0SzVkYTZPeUtj?=
 =?utf-8?B?QjFhWExpVnJIU3RRbHloL3psbkFEYkFNM2IrcGRDUmgyWW5vRHVnTWNCUk9u?=
 =?utf-8?B?Sm9vamE2RzUxSGRoaDVwK3B4SkM0Vnc2dUtXSFZNL0Y5cGhoOW1JVXVIY3Vk?=
 =?utf-8?B?amFZaFNUelNBZ0VqOWZRRlVPY216TmlNdHF0K3JDOEpYa2dDNmZvZTdhck1S?=
 =?utf-8?B?SFBMVjladkI4SkcxMWNDOGVkaHVWZmVTQWNFZExNOEtiTUs1UW5OelNvai9P?=
 =?utf-8?B?b2lZZnlwOHl4TWNLQ3VoQkxmMXIvM2Uxc2VldmFGRVRoQlVHSEJXd2F5MWJF?=
 =?utf-8?B?QWZzSUxRUjFWNmFod2QyQzJmaTFGMzJPVnNBYThURitJczdjaHhNN3g5b0NV?=
 =?utf-8?B?amZPWmJEUGtsck90ZTdDYnNTaDUwaU0xSmZXVlFlRHJlUnA1TnZySkZEVjgy?=
 =?utf-8?B?dmZ6RlYyU2FNT2FDOHZ2amZRdjJMTzVHQ1l1WVlkbVMrdXZRaStBVTlzbWg0?=
 =?utf-8?B?MElQVDA1eVlaUEJhQnNnNUFyU2hSeWsvdksrRHdpK3o4NmJuNnFxNytTYUdR?=
 =?utf-8?B?WjVaUlFrNTlDbjBIeHdjK1BBVG96aU1xTFAzallLWFdvREhsdnMrQkdkTm9x?=
 =?utf-8?B?cUY3d2hadjdYM1ZWVUN0UkF5bTFBdjFPYjdWSFVHeDhyMzdaY0Z5UFl4NW1x?=
 =?utf-8?B?R1JCMWtrdjZVUjhTUEtNRHpkYlduUFQvazRHYTAvUzljNFhtVjROcVY1a0JC?=
 =?utf-8?B?TnIySkRsd3h3eHJ0S0RZUTNjdmU0T2xrWTBUK2ZkazU0b0hPMkphMjlaVHFo?=
 =?utf-8?B?TXd6b1JDeXdRZ1VCMnJvQmI3RGErQml1bWJ1S0ppMGFBM3hZUGZSZ3JFcm8r?=
 =?utf-8?B?dHkrcUM4UmRPWWJtN2dscHZsaC9LQU9JbGRYL0NUcEFDZUw2UjdNYll0ZVU0?=
 =?utf-8?B?R0dMLzJwR05LZE5xWXBzRzBUcGdJdGpkOHB4TDI3N2hYR3BIMHlSRUtaVGl5?=
 =?utf-8?B?Q2VkcGdhMTF0ZjRTVjZ1aUxEdDBQeks5VE9rK3lRbEg1SGF3RTIzNk5rRVlJ?=
 =?utf-8?Q?2TDm38Hmy94Vb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d06c6ce8-3216-497f-2907-08d8fac0525c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 18:58:40.0588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B8RmisPdgetGA+m3VOW941ylSB37NRS6Te4Zrg5ttHzHonG1CYtAxkd+qU/8+Qsy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4963
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDguMDQuMjEgdW0gMTg6MDggc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPiBPbiAyMDIx
LTA0LTA4IDQ6MzIgYS5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0gMDguMDQuMjEg
dW0gMTA6MjIgc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+Pj4gW1NOSVBdCj4+Pj4+Cj4+Pj4+
Cj4+Pj4+PiBCZXlvbmQgYmxvY2tpbmcgYWxsIGRlbGF5ZWQgd29ya3MgYW5kIHNjaGVkdWxlciB0
aHJlYWRzIHdlIGFsc28gCj4+Pj4+PiBuZWVkIHRvIGd1YXJhbnRlZSBub8KgIElPQ1RMIGNhbiBh
Y2Nlc3MgTU1JTyBwb3N0IGRldmljZSB1bnBsdWcgT1IgCj4+Pj4+PiBpbiBmbGlnaHQgSU9DVExz
IGFyZSBkb25lIGJlZm9yZSB3ZSBmaW5pc2ggcGNpX3JlbW92ZSAKPj4+Pj4+IChhbWRncHVfcGNp
X3JlbW92ZSBmb3IgdXMpLgo+Pj4+Pj4gRm9yIHRoaXMgSSBzdWdnZXN0IHdlIGRvIHNvbWV0aGlu
ZyBsaWtlIHdoYXQgd2Ugd29ya2VkIG9uIHdpdGggCj4+Pj4+PiBUYWthc2hpIEl3YWkgdGhlIEFM
U0EgbWFpbnRhaW5lciByZWNlbnRseSB3aGVuIGhlIGhlbHBlZCAKPj4+Pj4+IGltcGxlbWVudGlu
ZyBQQ0kgQkFScyBtb3ZlIHN1cHBvcnQgZm9yIHNuZF9oZGFfaW50ZWwuIFRha2UgYSBsb29rIGF0
Cj4+Pj4+PiBodHRwczovL2NnaXQuZnJlZWRlc2t0b3Aub3JnL35hZ3JvZHpvdi9saW51eC9jb21t
aXQvP2g9eWFkcm8vcGNpZV9ob3RwbHVnL21vdmFibGVfYmFyc192OS4xJmlkPWNiYWEzMjQ3OTk3
MThlMmI4MjhhOGM3YjViMDAxZGQ4OTY3NDg0OTcgCj4+Pj4+PiBhbmQKPj4+Pj4+IGh0dHBzOi8v
Y2dpdC5mcmVlZGVza3RvcC5vcmcvfmFncm9kem92L2xpbnV4L2NvbW1pdC8/aD15YWRyby9wY2ll
X2hvdHBsdWcvbW92YWJsZV9iYXJzX3Y5LjEmaWQ9ZTM2MzY1ZDlhYjViYmMzMGJkYzIyMWFiNGIz
NDM3ZGUzNDQ5MjQ0MAo+Pj4+Pj4gV2UgYWxzbyBoYWQgc2FtZSBpc3N1ZSB0aGVyZSwgaG93IHRv
IHByZXZlbnQgTU1JTyBhY2Nlc3NlcyB3aGlsZSAKPj4+Pj4+IHRoZSBCQVJzIGFyZSBtaWdyYXRp
bmcuIFdoYXQgd2FzIGRvbmUgdGhlcmUgaXMgYSByZWZjb3VudCB3YXMgCj4+Pj4+PiBhZGRlZCB0
byBjb3VudCBhbGwgSU9DVExzIGluIGZsaWdodCwgZm9yIGFueSBpbiBmbGlnaHTCoCBJT0NUTCB0
aGUgCj4+Pj4+PiBCQVIgbWlncmF0aW9uIGhhbmRsZXIgd291bGQKPj4+Pj4+IGJsb2NrIGZvciB0
aGUgcmVmY291bnQgdG8gZHJvcCB0byAwIGJlZm9yZSBpdCB3b3VsZCBwcm9jZWVkLCBmb3IgCj4+
Pj4+PiBhbnkgbGF0ZXIgSU9DVEwgaXQgc3RvcHMgYW5kIHdhaXQgaWYgZGV2aWNlIGlzIGluIG1p
Z3JhdGlvbiAKPj4+Pj4+IHN0YXRlLiBXZSBldmVuIGRvbid0IG5lZWQgdGhlIHdhaXQgcGFydCwg
bm90aGluZyB0byB3YWl0IGZvciwgd2UgCj4+Pj4+PiBqdXN0IHJldHVybiB3aXRoIC1FTk9ERVYg
Zm9yIHRoaXMgY2FzZS4KPj4+Pj4+Cj4+Pj4+Cj4+Pj4+IFRoaXMgaXMgZXNzZW50aWFsbHkgd2hh
dCB0aGUgRFJNIFNSQ1UgaXMgZG9pbmcgYXMgd2VsbC4KPj4+Pj4KPj4+Pj4gRm9yIHRoZSBob3Rw
bHVnIGNhc2Ugd2UgY291bGQgZG8gdGhpcyBpbiB0aGUgdG9wbGV2ZWwgc2luY2Ugd2UgY2FuIAo+
Pj4+PiBzaWduYWwgdGhlIGZlbmNlIGFuZCBkb24ndCBuZWVkIHRvIGJsb2NrIG1lbW9yeSBtYW5h
Z2VtZW50Lgo+Pj4+Cj4+Pj4KPj4+PiBUbyBtYWtlIFNSQ1UgJ3dhaXQgZm9yJyBhbGwgSU9DVExz
IGluIGZsaWdodCB3ZSB3b3VsZCBuZWVkIHRvIHdyYXAgCj4+Pj4gZXZlcnkgSU9DVEwgKCBwcmFj
dGljYWxseSAtIGp1c3QgZHJtX2lvY3RsIGZ1bmN0aW9uKSB3aXRoIAo+Pj4+IGRybV9kZXZfZW50
ZXIvZHJtX2Rldl9leGl0IC0gY2FuIHdlIGRvIGl0ID8KPj4+Pgo+Pgo+PiBTb3JyeSB0b3RhbGx5
IG1pc3NlZCB0aGlzIHF1ZXN0aW9uLgo+Pgo+PiBZZXMsIGV4YWN0bHkgdGhhdC4gQXMgZGlzY3Vz
c2VkIGZvciB0aGUgaG90cGx1ZyBjYXNlIHdlIGNhbiBkbyB0aGlzLgo+Cj4KPiBUaGlua2luZyBt
b3JlIGFib3V0IGl0IC0gYXNzdW1pbmcgd2UgYXJlwqAgdHJlYXRpbmcgc3luY2hyb25pemVfc3Jj
dSBhcyAKPiBhICd3YWl0IGZvciBjb21wbGV0aW9uJyBvZiBhbnkgaW4gZmxpZ2h0IHtkcm1fZGV2
X2VudGVyLCBkcm1fZGV2X2V4aXR9IAo+IHNjb3BlLCBzb21lIG9mIHRob3NlIHNjb3BlcyBtaWdo
dCBkbyBkbWFfZmVuY2Vfd2FpdCBpbnNpZGUuIFNpbmNlIHdlIAo+IGhhdmVuJ3QgZm9yY2Ugc2ln
bmFsZWQgdGhlIGZlbmNlcyB5ZXQgd2Ugd2lsbCBlbmQgdXAgYSBkZWFkbG9jay4gV2UgCj4gaGF2
ZSB0byBzaWduYWwgYWxsIHRoZSB2YXJpb3VzIGZlbmNlcyBiZWZvcmUgZG9pbmcgdGhlICd3YWl0
IGZvcicuIEJ1dCAKPiB3ZSBjYW4ndCBzaWduYWwgdGhlIGZlbmNlcyBiZWZvcmUgc2V0dGluZyAn
ZGV2LT51bnBsdWdnZWQgPSB0cnVlJyB0byAKPiByZWplY3QgZnVydGhlciBDUyBhbmQgb3RoZXIg
c3R1ZmYgd2hpY2ggbWlnaHQgY3JlYXRlIG1vcmUgZmVuY2VzIHdlIAo+IHdlcmUgc3VwcG9zZWQt
dG8gZm9yY2Ugc2lnbmFsIGFuZCBub3cgbWlzc2VkIHRoZW0uIEVmZmVjdGl2ZWx5IHNldHRpbmcg
Cj4gJ2Rldi0+dW5wbHVnZ2VkID0gdHJ1ZScgYW5kIGRvaW5nIHN5bmNocm9uaXplX3NyY3UgaW4g
b25lIGNhbGwgbGlrZSAKPiBkcm1fZGV2X3VucGx1ZyBkb2VzIHdpdGhvdXQgc2lnbmFsbGluZyBh
bGwgdGhlIGZlbmNlcyBpbiB0aGUgZGV2aWNlIGluIAo+IGJldHdlZW4gdGhlc2UgdHdvIHN0ZXBz
IGxvb2tzIGx1Y2sgYSBwb3NzaWJsZSBkZWFkbG9jayB0byBtZSAtIHdoYXQgZG8gCj4geW91IHRo
aW5rID8KPgoKSW5kZWVkLCB0aGF0IGlzIGEgcmVhbGx5IGdvb2QgYXJndW1lbnQgdG8gaGFuZGxl
IGl0IHRoZSBzYW1lIHdheSBhcyB0aGUgCnJlc2V0IGxvY2suCgpFLmcuIG5vdCB0YWtpbmcgaXQg
YXQgdGhlIGhpZ2ggbGV2ZWwgSU9DVEwsIGJ1dCByYXRoZXIgd2hlbiB0aGUgZnJvbnRlbmQgCm9m
IHRoZSBkcml2ZXIgaGFzIGFjcXVpcmVkIGFsbCB0aGUgbmVjZXNzYXJ5IGxvY2tzIChCTyByZXN2
LCBWTSBsb2NrIApldGMuLi4pIGJlZm9yZSBjYWxsaW5nIGludG8gdGhlIGJhY2tlbmQgdG8gYWN0
dWFsbHkgZG8gdGhpbmdzIHdpdGggdGhlIApoYXJkd2FyZS4KCkNocmlzdGlhbi4KCj4gQW5kcmV5
Cj4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
