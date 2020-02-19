Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A951C34047
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 12:02:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 264C220658
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 12:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="u/bMAZLI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 264C220658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA2A46E2F8;
	Wed, 19 Feb 2020 12:02:25 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::617])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1DA06E2F8
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 12:02:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMeYko2viKwXKIcikdvtMy+Z1jwfZvRITR6QFOkER8K/ucPJp6fMyc3XgJmBPeY7vdcgNO0GScquZOWzDxcExgG4mu2vbRpbyelUjLw+ftAs3K0diMF8FxawhPRWuO3Z4W5hfh/qERGAhNExNaoREZ0sRsX0eoovvGjoZqUtaeVvwhi//D0UTLoCPBlHOoD9zb3dA5njuULK9haiWzOKTvTbo461Fb275sS4b7SWUKMHcXqgwyHTgNiFQl+ZkL+Pj6f9oJMdpKsJIlEbia2e1xKvbQShz3+D3MGYrmlVhN+zhtV45EU50Ixmi2RUYGwoiXsje8pyr4oTywAO9w2hbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnF/mOLYB5v2il+uePO+v8k2qNFG79G3xjK+8r+1DSY=;
 b=od8z0K49eFiaEzE/9NmL73qzqhQzUD9hR1pZlDSgJ9j8tr8bUFMTleAgRzsZbppX4qag8NcZWdLQ4CaqvbmqfO83li3X4W8ADLXKubZ+0lmTkxVFYkZVWF5V1MDkxhNDckW0iBghs5GuAAZPur+e1AoEI9S6KXikWIrPnzwhnvm29VhBy358rSttNsZ6xo1+58t4tjtID9wnJ6JfI9WtpuX+hgFZoyCM/OaMWUeXBZCFEfOaiVBS6I7D+r3C9n+UBpebbSis5WJvBGZdJ8bzIq/zonFkBG8VVkuNr3ujko5xp4gf9WL3WhUgiAimT+/ZJuaWPlSDA7WYfgMhst/tIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnF/mOLYB5v2il+uePO+v8k2qNFG79G3xjK+8r+1DSY=;
 b=u/bMAZLI6qSWf1Q7iBPG/VcHDwqJpS4k3GtfZ29nVA3m0hND6a60BvAVXKYIVf0+2QFaB+ZFNcvKBLx8/KyqW5Sh3VBeeiXysI8Y7KdcPdRIkDCtiuKvxjj3gs6hYGf+qFXnMUVqXTe0X7wWRo15yIvYORBkJkCfHKR7IxFInXE=
Received: from MN2PR12MB3087.namprd12.prod.outlook.com (20.178.244.160) by
 MN2PR12MB3453.namprd12.prod.outlook.com (20.178.240.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Wed, 19 Feb 2020 12:02:21 +0000
Received: from MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::b93c:2786:619:c02d]) by MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::b93c:2786:619:c02d%3]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 12:02:21 +0000
From: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
To: "StDenis, Tom" <Tom.StDenis@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH umr v2] fix field names for INDIRECT_BUFFER_CONST/CIK for
 gfx9/gfx10
Thread-Topic: [PATCH umr v2] fix field names for INDIRECT_BUFFER_CONST/CIK for
 gfx9/gfx10
Thread-Index: AQHV5xukmtLj0+qZsEStw08OymjUy6gial2AgAAAP8g=
Date: Wed, 19 Feb 2020 12:02:20 +0000
Message-ID: <MN2PR12MB30879FAA1A5C220758FE80FD89100@MN2PR12MB3087.namprd12.prod.outlook.com>
References: <20200219115606.6612-1-xiaojie.yuan@amd.com>,
 <1ccbf336-8263-761b-40e9-eeeef02ad70a@amd.com>
In-Reply-To: <1ccbf336-8263-761b-40e9-eeeef02ad70a@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-19T12:02:23.521Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Xiaojie.Yuan@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f96a4bde-4c8e-4ce9-5df9-08d7b533931b
x-ms-traffictypediagnostic: MN2PR12MB3453:|MN2PR12MB3453:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3453A38C3B35C9C2911F020B89100@MN2PR12MB3453.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:499;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(346002)(396003)(376002)(39860400002)(199004)(189003)(478600001)(86362001)(81166006)(8936002)(33656002)(71200400001)(8676002)(81156014)(7696005)(2906002)(9686003)(55016002)(91956017)(5660300002)(66946007)(53546011)(76116006)(316002)(110136005)(186003)(64756008)(6506007)(66556008)(66476007)(26005)(66446008)(52536014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3453;
 H:MN2PR12MB3087.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IaEB2o9/AURA2Ev6aj8a4VPvQay4RtY3Zel6owukoYaj+M9s9eeHUoDrwFrkOUm1ikJjKj0hwJXdg6SHv3Kk0iXNQN3UFPp/I+zD9LI48pY5RcxLEyJt0c/3zcrxDrTn4jtikJ/0JT4GGzhu9JstiGQE1DsSj+TsqKgZjZhNo8JtFihdHiNIxME08CvHOm/E+rqJmkSfyqPHcAATjwc+EIwGB0ys2zaNXasSY8R85/eu2dzrP7QqxQ1yuwUrpzis0YTo4hjKvTkNk2kY5PYCWWJkMpKLdrGELhx+yfANlGEf8o+tnOdfZGS7IhRJ8zyjG3gKNux9ws7W/oyRBA9q+eqOUqJMrEOA4/2v1ACQ3f7S6cF1PckhAMJI5fMcFl4XnKjTvdK4b9DF10a6TX2a+GciO46Am6P+tgapi3ny2nAJpl8CzfDQgI5rQ/XmDkYc
x-ms-exchange-antispam-messagedata: vzpEsZoqDcsUSlhazkHqWMRByWfy96ATd5x4MRX7PADMqTbo+PmSz5L+Kqp2fgbv7DcvTSsVTx99iP4m+AUX9UwQNIhx68izovh0LYtLhwx0adCdB8n+PEjtsnEHMwaZl1UPoYbTsQPmK1VtNHDraA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f96a4bde-4c8e-4ce9-5df9-08d7b533931b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 12:02:20.9949 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 63f5T8GV+rAKJ+mUsAgMw/s6lfZh1CbcP3feJVA2eO78+NHlvCcmwH+IDXkSe76W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3453
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

[AMD Official Use Only - Internal Distribution Only]

Thanks Tom.

BR,
Xiaojie

________________________________________
From: StDenis, Tom <Tom.StDenis@amd.com>
Sent: Wednesday, February 19, 2020 8:01 PM
To: Yuan, Xiaojie; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH umr v2] fix field names for INDIRECT_BUFFER_CONST/CIK for gfx9/gfx10

Hmm it doesn't apply on top of the tip of master.  I'll just manually
apply it.


Tom

On 2020-02-19 6:56 a.m., Xiaojie Yuan wrote:
> field names for INDIRECT_BUFFER_CONST/CIK of gfx9/gfx10 are the same.
> fields like OFFLOAD_POLLING and VALID are defined in mec's
> INDIRECT_BUFFER packet, so not applicable here.
>
> v2: fix umr_pm4_decode_opcodes.c as well
>
> Signed-off-by: Xiaojie Yuan <xiaojie.yuan@amd.com>
> ---
>   src/lib/ring_decode.c            | 23 +++++++----------------
>   src/lib/umr_pm4_decode_opcodes.c | 20 ++++++--------------
>   2 files changed, 13 insertions(+), 30 deletions(-)
>
> diff --git a/src/lib/ring_decode.c b/src/lib/ring_decode.c
> index 250dfd7..fa44f27 100644
> --- a/src/lib/ring_decode.c
> +++ b/src/lib/ring_decode.c
> @@ -617,22 +617,13 @@ static void print_decode_pm4_pkt3(struct umr_asic *asic, struct umr_ring_decoder
>                               case 2: printf("IB_SIZE:%s%lu%s, VMID: %s%lu%s", BLUE, BITS(ib, 0, 20), RST, BLUE, BITS(ib, 24, 28), RST);
>                                       decoder->pm4.next_ib_state.ib_size = BITS(ib, 0, 20) * 4;
>                                       decoder->pm4.next_ib_state.ib_vmid = decoder->next_ib_info.vmid ? decoder->next_ib_info.vmid : BITS(ib, 24, 28);
> -                                     if (decoder->pm4.cur_opcode == 0x33) {
> -                                             if (asic->family >= FAMILY_NV) {
> -                                                     printf(", CHAIN: %s%u%s, PRE_ENA: %s%u%s, CACHE_POLICY: %s%u%s, PRE_RESUME: %s%u%s PRIV: %s%u%s",
> -                                                                BLUE, (unsigned)BITS(ib, 20, 21), RST,
> -                                                                BLUE, (unsigned)BITS(ib, 21, 22), RST,
> -                                                                BLUE, (unsigned)BITS(ib, 28, 30), RST,
> -                                                                BLUE, (unsigned)BITS(ib, 30, 31), RST,
> -                                                                BLUE, (unsigned)BITS(ib, 31, 32), RST);
> -                                             } else if (asic->family >= FAMILY_AI) {
> -                                                     printf(", CHAIN: %s%u%s, OFFLOAD_POLLING: %s%u%s, VALID: %s%u%s, CACHE_POLICY: %s%u%s PRIV: %s%u%s",
> -                                                                BLUE, (unsigned)BITS(ib, 20, 21), RST,
> -                                                                BLUE, (unsigned)BITS(ib, 21, 22), RST,
> -                                                                BLUE, (unsigned)BITS(ib, 23, 24), RST,
> -                                                                BLUE, (unsigned)BITS(ib, 28, 30), RST,
> -                                                                BLUE, (unsigned)BITS(ib, 31, 32), RST);
> -                                             }
> +                                     if (asic->family >= FAMILY_AI) {
> +                                             printf(", CHAIN: %s%u%s, PRE_ENA: %s%u%s, CACHE_POLICY: %s%u%s, PRE_RESUME: %s%u%s PRIV: %s%u%s",
> +                                                        BLUE, (unsigned)BITS(ib, 20, 21), RST,
> +                                                        BLUE, (unsigned)BITS(ib, 21, 22), RST,
> +                                                        BLUE, (unsigned)BITS(ib, 28, 30), RST,
> +                                                        BLUE, (unsigned)BITS(ib, 30, 31), RST,
> +                                                        BLUE, (unsigned)BITS(ib, 31, 32), RST);
>                                       }
>                                       if (!asic->options.no_follow_ib) {
>                                               if (umr_read_vram(asic, decoder->pm4.next_ib_state.ib_vmid,
> diff --git a/src/lib/umr_pm4_decode_opcodes.c b/src/lib/umr_pm4_decode_opcodes.c
> index d7c1495..a823ecf 100644
> --- a/src/lib/umr_pm4_decode_opcodes.c
> +++ b/src/lib/umr_pm4_decode_opcodes.c
> @@ -429,20 +429,12 @@ static void decode_pkt3(struct umr_asic *asic, struct umr_pm4_stream_decode_ui *
>                       ui->add_field(ui, ib_addr + 8, ib_vmid, "IB_BASE_HI", BITS(stream->words[1], 0, 16), NULL, 16);
>                       ui->add_field(ui, ib_addr + 12, ib_vmid, "IB_SIZE", BITS(stream->words[2], 0, 20), NULL, 10);
>                       ui->add_field(ui, ib_addr + 12, ib_vmid, "IB_VMID", BITS(stream->words[2], 24, 28), NULL, 10);
> -                     if (stream->opcode == 0x33) {
> -                             if (asic->family >= FAMILY_NV) {
> -                                     ui->add_field(ui, ib_addr + 12, ib_vmid, "CHAIN", BITS(stream->words[2], 20, 21), NULL, 10);
> -                                     ui->add_field(ui, ib_addr + 12, ib_vmid, "PRE_ENA", BITS(stream->words[2], 21, 22), NULL, 10);
> -                                     ui->add_field(ui, ib_addr + 12, ib_vmid, "CACHE_POLICY", BITS(stream->words[2], 28, 30), NULL, 10);
> -                                     ui->add_field(ui, ib_addr + 12, ib_vmid, "PRE_RESUME", BITS(stream->words[2], 30, 31), NULL, 10);
> -                                     ui->add_field(ui, ib_addr + 12, ib_vmid, "PRIV", BITS(stream->words[2], 31, 32), NULL, 10);
> -                             } else if (asic->family >= FAMILY_AI) {
> -                                     ui->add_field(ui, ib_addr + 12, ib_vmid, "CHAIN", BITS(stream->words[2], 20, 21), NULL, 10);
> -                                     ui->add_field(ui, ib_addr + 12, ib_vmid, "OFFLOAD_POLLING", BITS(stream->words[2], 21, 22), NULL, 10);
> -                                     ui->add_field(ui, ib_addr + 12, ib_vmid, "VALID", BITS(stream->words[2], 23, 24), NULL, 10);
> -                                     ui->add_field(ui, ib_addr + 12, ib_vmid, "CACHE_POLICY", BITS(stream->words[2], 28, 30), NULL, 10);
> -                                     ui->add_field(ui, ib_addr + 12, ib_vmid, "PRIV", BITS(stream->words[2], 31, 32), NULL, 10);
> -                             }
> +                     if (asic->family >= FAMILY_AI) {
> +                             ui->add_field(ui, ib_addr + 12, ib_vmid, "CHAIN", BITS(stream->words[2], 20, 21), NULL, 10);
> +                             ui->add_field(ui, ib_addr + 12, ib_vmid, "PRE_ENA", BITS(stream->words[2], 21, 22), NULL, 10);
> +                             ui->add_field(ui, ib_addr + 12, ib_vmid, "CACHE_POLICY", BITS(stream->words[2], 28, 30), NULL, 10);
> +                             ui->add_field(ui, ib_addr + 12, ib_vmid, "PRE_RESUME", BITS(stream->words[2], 30, 31), NULL, 10);
> +                             ui->add_field(ui, ib_addr + 12, ib_vmid, "PRIV", BITS(stream->words[2], 31, 32), NULL, 10);
>                       }
>                       break;
>               case 0x37: // WRITE_DATA
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
