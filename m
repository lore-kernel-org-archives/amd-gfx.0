Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C006EC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Nov 2021 17:15:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6467889DB9;
	Mon, 22 Nov 2021 17:15:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB30E89DB9
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Nov 2021 17:15:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBNmpGRNfScnC1XfB/WbfYuksr2tqmpf0NfD47XtscX1lQRNpELRJp+aVHO6sAP4Ptp3oMiO2sX52Ux+PSTCsMqS8MD+re7dlpmaeTxATkOv2zT3cCczeEfFRnlACBSW4Hfk9bqY0D3MN2xZbG+Jak2QWH/YFlzQ5jPS92bG5pR1d6AAS8vqlCPWBocy3w5JuqfvW7qgkUXf/tbosABYY6Cel1bXy/9dsgzofd6klbG3GL4OH65buQqIh/hn9l4IJMhQ6mSfGh+U9MgD8q5me2u7+54R9OmFVlD5WYyTqr4QM0TWWHO0ko3wdK+RQp1o13jh4M8bjS75hGpwULnF6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+E4Ec0Hapdde6i6ig1b+F0B2dm/qagxChcGDDGZPhA=;
 b=EV7rAn7mCCy2A2GCvxa+CBfE9zk7rNNfsakwq7PCVsCF1buswjK0eaCguj/xl8ZVaXsNS/TKzpl64KFSGEftKJPZpfE33GP5kvGHCDBiLi4ol4GdWcoEIwND5nS/xXZtsSX9/aAS1ihN9N2mFgah8TAc0hVJuO4TTABjvhdSuNQsx053zWqJ3XTKLTfB/uMIp7HeM5dWylxHaQ2X4N+MCyp91Nc4dsTCasPp9Uu4b/DL7ypw7l3NZV39ygAsMb2YE6s/xjN1ASNVWCuIvLzYLMtKFpl5bZJ6FOBMrSe+3NifMAmAwAaKMg/zXUgL9V/38RXtsUwtXXJMI/DboMNI8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+E4Ec0Hapdde6i6ig1b+F0B2dm/qagxChcGDDGZPhA=;
 b=KTmc2anI8Yg/q7fZPFhjN9BxxlcXfZgT0l+vaFXPmGaH3k4ApSqAmADplc5ZCGw7BwBsS8gouQ7sMAgWA1Grgi7m0EJEpYCqa4lJODFXddwEqRojL/NnHKkcMNKtF9OUbfCevFBQofgLD3GeJ/5D+EvsNPgHCLAf2GZw8uJ5sX8=
Received: from DM6PR12MB3306.namprd12.prod.outlook.com (2603:10b6:5:186::20)
 by DM6PR12MB3115.namprd12.prod.outlook.com (2603:10b6:5:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Mon, 22 Nov
 2021 17:15:53 +0000
Received: from DM6PR12MB3306.namprd12.prod.outlook.com
 ([fe80::b18a:1e44:d12a:7c89]) by DM6PR12MB3306.namprd12.prod.outlook.com
 ([fe80::b18a:1e44:d12a:7c89%7]) with mapi id 15.20.4713.025; Mon, 22 Nov 2021
 17:15:53 +0000
From: "Zhuo, Qingqing (Lillian)" <Qingqing.Zhuo@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 14/16] drm/amd/display: add else to avoid double destroy
 clk_mgr
Thread-Topic: [PATCH 14/16] drm/amd/display: add else to avoid double destroy
 clk_mgr
Thread-Index: AQHX3X3S3o4Xhc5GmEeKOKe6v1COiKwPsvSAgAAZf5A=
Date: Mon, 22 Nov 2021 17:15:53 +0000
Message-ID: <DM6PR12MB33061790756C46BF6D6DC4F2FB9F9@DM6PR12MB3306.namprd12.prod.outlook.com>
References: <20211119194339.97573-1-qingqing.zhuo@amd.com>
 <20211119194339.97573-15-qingqing.zhuo@amd.com>
 <BL1PR12MB514434CD840471692E9894A2F79F9@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB514434CD840471692E9894A2F79F9@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-22T17:15:49Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13edd7b3-3902-4ec3-bcb4-08d9addbbd79
x-ms-traffictypediagnostic: DM6PR12MB3115:
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR12MB3115DA6710F40D1755001B2BFB9F9@DM6PR12MB3115.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1l3fxGCWVRFLsVPJjg2lcA5OxO5NCqMPzKqlCPcejLdIhc0IGasDOsh45KGShw7k8hwuSwKsTfthGTu/i2AUlWfcoGI2tD5gSfj4S+kxR8dbayx/NENJzDYq/g5CTsRx+iwR2BTAKlRtstgtdI6loQ9D42x/Zrz8eyOkVwO0AiNK18z//yBzIHivm2YkRfHq/7qUNjcUnFXpw4MvGeOX4bTwfsVfNKbvjTwUYp3fXzjRQ1tcLoW2tUlyC7dmQK9y+nCA06H1QhpwHHVS856B5JWEvSvRmvxVgw2481Qps/P3WaH7JYrcHxUO7eKeFxXCVeocwmKY7Qb8ca2nbANkEPsoW8/DNxGCnny4I4nDRK5WB4KM0RkyonDAWBWmS7Wp8ycnWhntFqv+UEjNNLnx8ZV3OnxIwqzpEXUSS8XGsgTJQQWWf2ZZ3+s6byQUz1OyxXfSYyuUGHwwxdgdZIjoZ1yoi34zIYJ64qbIiz06KW68X1102OdP29L5k/m37e/YKXzdLCcJfDAxrj4eaxzA/znv790ycZmBBtNiRxpf+IV2oLqUomTqBR2ySOoYaTfQdP/E/CMtLrF3Arxsox0v+OmMWdkEeRsfv2CpBICC8QzE28h0dOXp+AA9R0boRlyMR4Pn24sSIGJOi5yCkQnxyiH3sIZgcmfrcEX25a4mEODeHwX8MAyLw57IqDXr8t7eWdzIs6x+MpR11yz3SF3fBQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3306.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33656002)(83380400001)(4326008)(66446008)(71200400001)(5660300002)(86362001)(66946007)(2906002)(76116006)(9686003)(38100700002)(122000001)(55016002)(8936002)(66476007)(66556008)(64756008)(110136005)(7696005)(186003)(26005)(316002)(54906003)(508600001)(6506007)(38070700005)(53546011)(52536014)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2D6dmZcc+D0Hyq18uBPl3CSlIC4eDhdlq+isMFEcHyFCGAOCtRnS3INg2jf2?=
 =?us-ascii?Q?iHQ6YvWdo1hOAx+Wx27KBCFBPGAptHbm3YW8et4J81b25jOTtTO6st+qMCIo?=
 =?us-ascii?Q?aoFr0eTw+iLgnx21c/GGBqi/TXTTG8Nn4Bz14FkGOkIKqmHXtKLt7cAxippS?=
 =?us-ascii?Q?dD0+UHLJZ08LrjvjLrnTWoQzsPZ77ByhzXBHsSoWsQ8krjNJrn1/BrkH68Tv?=
 =?us-ascii?Q?iYcRV6jJTWvnSM95Jq2Seyebpi1+cQ6tv8/pVRcrV6zasMyf+FwaxKtcHso4?=
 =?us-ascii?Q?Td5BZvjVsQN2VQNRnA/aS1ycslhmj9YF0CyfVBt6GE7bGmXmJOiVN1RSOAhv?=
 =?us-ascii?Q?cVoO8lYzxoCQhMR4L9NbfF3v3jT1wg9eeoCqv1fUTRQRt5B7HNi56elO6Kvg?=
 =?us-ascii?Q?sQyt12xFvLwcnxvTrDOILc7G+W3EHWg376YXHymKxB8CR7LmLpebcMxDzumE?=
 =?us-ascii?Q?dccpf5zJi+iUNVECZF3EfTBOENJxnMc7Ziex1vawPsImJYTXa00arC3Jedbu?=
 =?us-ascii?Q?f0xlFt/zc/02HthPIi0zAmjzuSv5QHWIq2FkVsb0wRqNxJ9pwAEJa8K17okG?=
 =?us-ascii?Q?r3FxEwaptmJW2DlZRT7nm//ZaEbdSP7V4qLJ1Ve6jCDU77tRG75VRJtLoo1k?=
 =?us-ascii?Q?0UTZz19hIGFFG/1yJDK4xc4CJcp4wn6AGjC06T1DccBHyopdNMdw8QANSt/t?=
 =?us-ascii?Q?Rj5tXdl7v+h/PS4cZD8FmsWpVwQBDUlm6exzWozEI93z5yCdnACWPwi/bpXK?=
 =?us-ascii?Q?Ay6V24Mzv/dQy2yhwFlnqpFgXpMlygpIgksGmHk+4iysPIJpIBv/dhpxgjGo?=
 =?us-ascii?Q?5z6QIKzsDGki4Qaz6Pzmp36kA5derWRD4Y4xtnHAKAJKjVq7yaf72EGQUz3Y?=
 =?us-ascii?Q?CqyCZUhvDy1VpMWZPn41Oe1lxPhDSgkrWScPnriHqIUkVH5cVheWM5EiZ18H?=
 =?us-ascii?Q?L/iOsQycilAx1uYQDrsI4rNMoqzzYld1wGF7atePMveUBIQ5J2IcuVt0A7r1?=
 =?us-ascii?Q?JR0KZwcxX3ndrSWa3tZVE7uCo28X7xsdAiq1V59hLPWDRhwF/p9FOjR6sU15?=
 =?us-ascii?Q?G1YK45PVcMQjoIEadzfzWzIS6rMnzzM2hCELj6isl5f27FknlSJLK/WLNY4p?=
 =?us-ascii?Q?m4Sb+ZQ1owqZOnjah/y+nyv5K9pyu488AIy5IsHOCQfkvQhKDfWe0lTTP+K9?=
 =?us-ascii?Q?GgBmzh5B/kz/XA8fx2MSTp5kuB3869kooouuXrRk1JkvtOVMj3k22ELlImrv?=
 =?us-ascii?Q?a6K7Rdy7Ozmu5IOXeVtRFvRNio9pIoafDDqiCffuBvlejuIxsvrajs4i7ltB?=
 =?us-ascii?Q?ciFMAo+SbsWtOvuBUhEutxL8FCMMuopxLTx5CbEmFD3dNNjbdOZhZjU9hc7D?=
 =?us-ascii?Q?fqnS/eaMY096wpto6JaUHNpirQ18ArgT7evnXEZTV1max9fzB3XIsLxIin19?=
 =?us-ascii?Q?rMsNQA19NqI2AtkEke1DaxlsGVjFHBPhRnIXTAPSEiGEnpG4q1qwsT6uKDd2?=
 =?us-ascii?Q?Zw45n7CL1EVcMUrIteib2t8tYBaYGog7FxucCfWn6NqPuMUAbD7oYyFHMxbm?=
 =?us-ascii?Q?rTvBjQ/e24uikvEqgrA=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB33061790756C46BF6D6DC4F2FB9F9DM6PR12MB3306namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3306.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13edd7b3-3902-4ec3-bcb4-08d9addbbd79
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2021 17:15:53.5002 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DDnf9cEhBVcW4G+XpMF1Lk+fJLFpQQDAw8r5h9EMC0rWKx/8UpaL0gMf3extOmc1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3115
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Cyr,
 Aric" <Aric.Cyr@amd.com>, "Jacob, Anson" <Anson.Jacob@amd.com>, "Li, Sun peng
 \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Lin,
 Wayne" <Wayne.Lin@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Chiu, Solomon" <Solomon.Chiu@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Leung, Martin" <Martin.Leung@amd.com>,
 "Lipski, Mikita" <Mikita.Lipski@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM6PR12MB33061790756C46BF6D6DC4F2FB9F9DM6PR12MB3306namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Hi Alex,

Thank you for the advice! Last week's DC candidate has in fact already been=
 merged to upstream, but I will bring up your suggestion to the patch autho=
r for review.

Thank you,
Lillian
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Monday, November 22, 2021 10:38 AM
To: Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; amd-gfx@lists.freedes=
ktop.org
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Cyr, Aric <Aric.Cyr@amd.=
com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@=
amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Leung, Martin <Martin.L=
eung@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Li, Roman <Rom=
an.Li@amd.com>; Jacob, Anson <Anson.Jacob@amd.com>; Pillai, Aurabindo <Aura=
bindo.Pillai@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Lipski, Mikita <Miki=
ta.Lipski@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Gutierr=
ez, Agustin <Agustin.Gutierrez@amd.com>; Kotarac, Pavle <Pavle.Kotarac@amd.=
com>
Subject: Re: [PATCH 14/16] drm/amd/display: add else to avoid double destro=
y clk_mgr


[Public]

Do you want to change the ASICREV_IS_BEIGE_GOBY_P() check to else if as wel=
l?  maybe something like:

if (ASICREV_IS_SIENNA_CICHLID_P(clk_mgr_base->ctx->asic_id.hw_internal_rev)=
 ||
    ASICREV_IS_DIMGREY_CAVEFISH_P(clk_mgr_base->ctx->asic_id.hw_internal_re=
v) ||
     ASICREV_IS_BEIGE_GOBY_P(clk_mgr_base->ctx->asic_id.hw_internal_rev))
         dcn3_clk_mgr_destroy(clk_mgr);

Alex
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Qingqing Zhuo <qingqing.zhuo@amd.com<=
mailto:qingqing.zhuo@amd.com>>
Sent: Friday, November 19, 2021 2:43 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com<mailto:Stylon.Wang@amd.com=
>>; Cyr, Aric <Aric.Cyr@amd.com<mailto:Aric.Cyr@amd.com>>; Chiu, Solomon <S=
olomon.Chiu@amd.com<mailto:Solomon.Chiu@amd.com>>; Li, Sun peng (Leo) <Sunp=
eng.Li@amd.com<mailto:Sunpeng.Li@amd.com>>; Wentland, Harry <Harry.Wentland=
@amd.com<mailto:Harry.Wentland@amd.com>>; Zhuo, Qingqing (Lillian) <Qingqin=
g.Zhuo@amd.com<mailto:Qingqing.Zhuo@amd.com>>; Leung, Martin <Martin.Leung@=
amd.com<mailto:Martin.Leung@amd.com>>; Siqueira, Rodrigo <Rodrigo.Siqueira@=
amd.com<mailto:Rodrigo.Siqueira@amd.com>>; Li, Roman <Roman.Li@amd.com<mail=
to:Roman.Li@amd.com>>; Jacob, Anson <Anson.Jacob@amd.com<mailto:Anson.Jacob=
@amd.com>>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com<mailto:Aurabindo.Pi=
llai@amd.com>>; Lin, Wayne <Wayne.Lin@amd.com<mailto:Wayne.Lin@amd.com>>; L=
ipski, Mikita <Mikita.Lipski@amd.com<mailto:Mikita.Lipski@amd.com>>; Lakha,=
 Bhawanpreet <Bhawanpreet.Lakha@amd.com<mailto:Bhawanpreet.Lakha@amd.com>>;=
 Gutierrez, Agustin <Agustin.Gutierrez@amd.com<mailto:Agustin.Gutierrez@amd=
.com>>; Kotarac, Pavle <Pavle.Kotarac@amd.com<mailto:Pavle.Kotarac@amd.com>=
>
Subject: [PATCH 14/16] drm/amd/display: add else to avoid double destroy cl=
k_mgr

From: Martin Leung <Martin.Leung@amd.com<mailto:Martin.Leung@amd.com>>

[Why & How]
when changing some code we accidentally
changed else if-> if. reverting that.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com<mailto:Aric.Cyr@amd.com>>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com<mailto:qingqing.zhuo@amd.com=
>>
Signed-off-by: Martin Leung <Martin.Leung@amd.com<mailto:Martin.Leung@amd.c=
om>>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu=
/drm/amd/display/dc/clk_mgr/clk_mgr.c
index 26f96ee32472..9200c8ce02ba 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -308,8 +308,7 @@ void dc_destroy_clk_mgr(struct clk_mgr *clk_mgr_base)
         case FAMILY_NV:
                 if (ASICREV_IS_SIENNA_CICHLID_P(clk_mgr_base->ctx->asic_id=
.hw_internal_rev)) {
                         dcn3_clk_mgr_destroy(clk_mgr);
-               }
-               if (ASICREV_IS_DIMGREY_CAVEFISH_P(clk_mgr_base->ctx->asic_i=
d.hw_internal_rev)) {
+               } else if (ASICREV_IS_DIMGREY_CAVEFISH_P(clk_mgr_base->ctx-=
>asic_id.hw_internal_rev)) {
                         dcn3_clk_mgr_destroy(clk_mgr);
                 }
                 if (ASICREV_IS_BEIGE_GOBY_P(clk_mgr_base->ctx->asic_id.hw_=
internal_rev)) {
--
2.25.1

--_000_DM6PR12MB33061790756C46BF6D6DC4F2FB9F9DM6PR12MB3306namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader23c54b6f, li.msipheader23c54b6f, div.msipheader23c54b6f
	{mso-style-name:msipheader23c54b6f;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"msipheader23c54b6f" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hi Alex,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you for the advice! Last week&#8217;s DC candi=
date has in fact already been merged to upstream, but I will bring up your =
suggestion to the patch author for review.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">Lillian<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander &lt;Alexander.Deuche=
r@amd.com&gt; <br>
<b>Sent:</b> Monday, November 22, 2021 10:38 AM<br>
<b>To:</b> Zhuo, Qingqing (Lillian) &lt;Qingqing.Zhuo@amd.com&gt;; amd-gfx@=
lists.freedesktop.org<br>
<b>Cc:</b> Wang, Chao-kai (Stylon) &lt;Stylon.Wang@amd.com&gt;; Cyr, Aric &=
lt;Aric.Cyr@amd.com&gt;; Chiu, Solomon &lt;Solomon.Chiu@amd.com&gt;; Li, Su=
n peng (Leo) &lt;Sunpeng.Li@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland=
@amd.com&gt;; Leung, Martin &lt;Martin.Leung@amd.com&gt;; Siqueira,
 Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Li, Roman &lt;Roman.Li@amd.com&g=
t;; Jacob, Anson &lt;Anson.Jacob@amd.com&gt;; Pillai, Aurabindo &lt;Aurabin=
do.Pillai@amd.com&gt;; Lin, Wayne &lt;Wayne.Lin@amd.com&gt;; Lipski, Mikita=
 &lt;Mikita.Lipski@amd.com&gt;; Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@am=
d.com&gt;;
 Gutierrez, Agustin &lt;Agustin.Gutierrez@amd.com&gt;; Kotarac, Pavle &lt;P=
avle.Kotarac@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 14/16] drm/amd/display: add else to avoid double=
 destroy clk_mgr<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Do you =
want to change the
</span><span style=3D"color:black">ASICREV_IS_BEIGE_GOBY_P</span><span styl=
e=3D"font-size:12.0pt;color:black">() check to else if as well?&nbsp; maybe=
 something like:<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">if (ASI=
CREV_IS_SIENNA_CICHLID_P(clk_mgr_base-&gt;ctx-&gt;asic_id.hw_internal_rev) =
||<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;&=
nbsp;&nbsp;&nbsp;ASICREV_IS_DIMGREY_CAVEFISH_P(clk_mgr_base-&gt;ctx-&gt;asi=
c_id.hw_internal_rev) ||<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;&=
nbsp;&nbsp;&nbsp; ASICREV_IS_BEIGE_GOBY_P(clk_mgr_base-&gt;ctx-&gt;asic_id.=
hw_internal_rev))<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_clk_mgr_destroy(clk_mgr);<o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex<o:=
p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf o=
f Qingqing Zhuo &lt;<a href=3D"mailto:qingqing.zhuo@amd.com">qingqing.zhuo@=
amd.com</a>&gt;<br>
<b>Sent:</b> Friday, November 19, 2021 2:43 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Wang, Chao-kai (Stylon) &lt;<a href=3D"mailto:Stylon.Wang@amd.co=
m">Stylon.Wang@amd.com</a>&gt;; Cyr, Aric &lt;<a href=3D"mailto:Aric.Cyr@am=
d.com">Aric.Cyr@amd.com</a>&gt;; Chiu, Solomon &lt;<a href=3D"mailto:Solomo=
n.Chiu@amd.com">Solomon.Chiu@amd.com</a>&gt;; Li, Sun peng
 (Leo) &lt;<a href=3D"mailto:Sunpeng.Li@amd.com">Sunpeng.Li@amd.com</a>&gt;=
; Wentland, Harry &lt;<a href=3D"mailto:Harry.Wentland@amd.com">Harry.Wentl=
and@amd.com</a>&gt;; Zhuo, Qingqing (Lillian) &lt;<a href=3D"mailto:Qingqin=
g.Zhuo@amd.com">Qingqing.Zhuo@amd.com</a>&gt;; Leung, Martin
 &lt;<a href=3D"mailto:Martin.Leung@amd.com">Martin.Leung@amd.com</a>&gt;; =
Siqueira, Rodrigo &lt;<a href=3D"mailto:Rodrigo.Siqueira@amd.com">Rodrigo.S=
iqueira@amd.com</a>&gt;; Li, Roman &lt;<a href=3D"mailto:Roman.Li@amd.com">=
Roman.Li@amd.com</a>&gt;; Jacob, Anson &lt;<a href=3D"mailto:Anson.Jacob@am=
d.com">Anson.Jacob@amd.com</a>&gt;;
 Pillai, Aurabindo &lt;<a href=3D"mailto:Aurabindo.Pillai@amd.com">Aurabind=
o.Pillai@amd.com</a>&gt;; Lin, Wayne &lt;<a href=3D"mailto:Wayne.Lin@amd.co=
m">Wayne.Lin@amd.com</a>&gt;; Lipski, Mikita &lt;<a href=3D"mailto:Mikita.L=
ipski@amd.com">Mikita.Lipski@amd.com</a>&gt;; Lakha, Bhawanpreet
 &lt;<a href=3D"mailto:Bhawanpreet.Lakha@amd.com">Bhawanpreet.Lakha@amd.com=
</a>&gt;; Gutierrez, Agustin &lt;<a href=3D"mailto:Agustin.Gutierrez@amd.co=
m">Agustin.Gutierrez@amd.com</a>&gt;; Kotarac, Pavle &lt;<a href=3D"mailto:=
Pavle.Kotarac@amd.com">Pavle.Kotarac@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH 14/16] drm/amd/display: add else to avoid double des=
troy clk_mgr</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">From: Martin Leung &l=
t;<a href=3D"mailto:Martin.Leung@amd.com">Martin.Leung@amd.com</a>&gt;<br>
<br>
[Why &amp; How]<br>
when changing some code we accidentally<br>
changed else if-&gt; if. reverting that.<br>
<br>
Reviewed-by: Aric Cyr &lt;<a href=3D"mailto:Aric.Cyr@amd.com">Aric.Cyr@amd.=
com</a>&gt;<br>
Acked-by: Qingqing Zhuo &lt;<a href=3D"mailto:qingqing.zhuo@amd.com">qingqi=
ng.zhuo@amd.com</a>&gt;<br>
Signed-off-by: Martin Leung &lt;<a href=3D"mailto:Martin.Leung@amd.com">Mar=
tin.Leung@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c | 3 +--<br>
&nbsp;1 file changed, 1 insertion(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu=
/drm/amd/display/dc/clk_mgr/clk_mgr.c<br>
index 26f96ee32472..9200c8ce02ba 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c<br>
@@ -308,8 +308,7 @@ void dc_destroy_clk_mgr(struct clk_mgr *clk_mgr_base)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case FAMILY_NV:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ASICREV_IS_SIENNA_CICHLID_P(clk_mgr_base-&gt;ctx-=
&gt;asic_id.hw_internal_rev)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_=
clk_mgr_destroy(clk_mgr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ASICREV_IS_DIMGREY_CAVEFISH_P(clk_mgr_base-&gt;ctx-&gt;asic_=
id.hw_internal_rev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else if (ASICREV_IS_DIMGREY_CAVEFISH_P(clk_mgr_base-&gt;ctx-&g=
t;asic_id.hw_internal_rev)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_=
clk_mgr_destroy(clk_mgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ASICREV_IS_BEIGE_GOBY_P(clk_mgr_base-&gt;ctx-&gt;=
asic_id.hw_internal_rev)) {<br>
-- <br>
2.25.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB33061790756C46BF6D6DC4F2FB9F9DM6PR12MB3306namp_--
